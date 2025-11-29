import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:design_system/step5_video_playback/video_playback_ui_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/services/slideshow_state_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_playback_page_view_model.g.dart';

/// 영상 재생 페이지의 ViewModel
/// slideshowId가 null이면 현재 sceneList에서 새로 생성, 있으면 저장된 JSON에서 로드
@riverpod
class VideoPlaybackPageViewModel extends _$VideoPlaybackPageViewModel {
  Timer? _playbackTimer;
  AudioPlayer? _audioPlayer;
  int _currentAudioSceneIndex = -1;

  @override
  PageState<VideoPlaybackPageUiState, VideoPlaybackPageAction> build(
    int? slideshowId,
  ) {
    ref.onDispose(() {
      _playbackTimer?.cancel();
      _audioPlayer?.dispose();
    });

    if (slideshowId != null) {
      // 저장된 슬라이드쇼에서 로드
      final slideshow = ref.read(slideshowListProvider.notifier).getById(slideshowId);
      if (slideshow != null) {
        Future.microtask(() => _loadFromSavedSlideshow(slideshow.fileName));
      } else {
        Future.microtask(() {
          state = state.copyWith(
            action: VideoPlaybackPageAction.showError('슬라이드쇼를 찾을 수 없습니다.'),
          );
        });
      }
    } else {
      // build() 내에서 ref.read()를 먼저 수행
      final sceneDataList = ref.read(sceneListProvider);
      // 슬라이드쇼 정보 로드 (sceneDataList를 파라미터로 전달)
      Future.microtask(() => _loadSlideshowInfo(sceneDataList));
    }

    return PageState(
      uiState: const VideoPlaybackPageUiState(
        status: PlaybackStatus.loading,
      ),
      action: VideoPlaybackPageAction.none(),
    );
  }

  /// 저장된 JSON 파일에서 슬라이드쇼 로드
  Future<void> _loadFromSavedSlideshow(String fileName) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final jsonPath = '${appDir.path}/media/videos/$fileName';
      final jsonFile = File(jsonPath);

      if (!await jsonFile.exists()) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(status: PlaybackStatus.error),
          action: VideoPlaybackPageAction.showError('슬라이드쇼 파일을 찾을 수 없습니다.'),
        );
        return;
      }

      final jsonString = await jsonFile.readAsString();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      // AudioPlayer 초기화
      _audioPlayer = AudioPlayer();

      // JSON에서 Scene 데이터 파싱
      final scenesJson = jsonData['scenes'] as List<dynamic>;
      final scenes = scenesJson.map((s) {
        final sceneMap = s as Map<String, dynamic>;
        return SlideshowScene(
          index: sceneMap['index'] as int,
          imagePath: sceneMap['imagePath'] as String,
          audioPath: sceneMap['audioPath'] as String?,
          subtitle: sceneMap['subtitle'] as String,
          durationMs: sceneMap['durationMs'] as int,
          startTimeMs: sceneMap['startTimeMs'] as int,
        );
      }).toList();

      final totalDurationMs = jsonData['totalDurationMs'] as int;

      debugPrint('저장된 슬라이드쇼 로드 완료: ${scenes.length}개 장면');

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          status: PlaybackStatus.paused,
          scenes: scenes,
          totalDuration: Duration(milliseconds: totalDurationMs),
          currentSceneIndex: 0,
          currentImagePath: scenes.isNotEmpty ? scenes[0].imagePath : null,
          currentSubtitle: scenes.isNotEmpty ? scenes[0].subtitle : null,
        ),
      );
    } catch (e) {
      debugPrint('저장된 슬라이드쇼 로드 실패: $e');
      state = state.copyWith(
        uiState: state.uiState.copyWith(status: PlaybackStatus.error),
        action: VideoPlaybackPageAction.showError('슬라이드쇼 로드 실패: $e'),
      );
    }
  }

  /// 슬라이드쇼 정보 로드
  Future<void> _loadSlideshowInfo(List<SceneData> sceneDataList) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final mediaBasePath = '${appDir.path}/media';

      if (sceneDataList.isEmpty) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            status: PlaybackStatus.error,
          ),
          action: VideoPlaybackPageAction.showError('재생할 장면이 없습니다.'),
        );
        return;
      }

      // AudioPlayer 초기화
      _audioPlayer = AudioPlayer();

      // Scene 데이터를 SlideshowScene으로 변환
      final scenes = <SlideshowScene>[];
      var totalDurationMs = 0;

      for (var i = 0; i < sceneDataList.length; i++) {
        final sceneData = sceneDataList[i];
        final imagePath =
            '$mediaBasePath/illustrations/${sceneData.illustrationFileName}';
        final audioPath = sceneData.audioFileName != null
            ? '$mediaBasePath/records/${sceneData.audioFileName}'
            : null;

        // 오디오 길이 측정 (없으면 기본 3초)
        int durationMs = 3000;
        if (audioPath != null && await File(audioPath).exists()) {
          try {
            final duration = await _audioPlayer!.setFilePath(audioPath);
            if (duration != null) {
              durationMs = duration.inMilliseconds;
            }
          } catch (e) {
            debugPrint('오디오 길이 측정 실패: $e');
          }
        }

        scenes.add(SlideshowScene(
          index: i,
          imagePath: imagePath,
          audioPath: audioPath,
          subtitle: sceneData.storyScript ?? '',
          durationMs: durationMs,
          startTimeMs: totalDurationMs,
        ));

        totalDurationMs += durationMs;
      }

      debugPrint('슬라이드쇼 로드 완료: ${scenes.length}개 장면, 총 ${totalDurationMs}ms');

      // 슬라이드쇼 데이터를 JSON으로 저장
      await _saveSlideshowJson(scenes, totalDurationMs, mediaBasePath);

      // 첫 번째 장면으로 초기화
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          status: PlaybackStatus.paused,
          scenes: scenes,
          totalDuration: Duration(milliseconds: totalDurationMs),
          currentSceneIndex: 0,
          currentImagePath: scenes.isNotEmpty ? scenes[0].imagePath : null,
          currentSubtitle: scenes.isNotEmpty ? scenes[0].subtitle : null,
        ),
      );
    } catch (e) {
      debugPrint('슬라이드쇼 로드 실패: $e');
      state = state.copyWith(
        uiState: state.uiState.copyWith(status: PlaybackStatus.error),
        action: VideoPlaybackPageAction.showError('슬라이드쇼 로드 실패: $e'),
      );
    }
  }

  /// 슬라이드쇼 데이터를 JSON 파일로 저장
  Future<void> _saveSlideshowJson(
    List<SlideshowScene> scenes,
    int totalDurationMs,
    String mediaBasePath,
  ) async {
    try {
      final videosDir = Directory('$mediaBasePath/videos');
      if (!await videosDir.exists()) {
        await videosDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'slideshow_$timestamp.json';
      final jsonPath = '${videosDir.path}/$fileName';

      final jsonData = {
        'createdAt': DateTime.now().toIso8601String(),
        'totalDurationMs': totalDurationMs,
        'scenes': scenes.map((scene) => {
          'index': scene.index,
          'imagePath': scene.imagePath,
          'audioPath': scene.audioPath,
          'subtitle': scene.subtitle,
          'durationMs': scene.durationMs,
          'startTimeMs': scene.startTimeMs,
        }).toList(),
      };

      final jsonFile = File(jsonPath);
      await jsonFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(jsonData),
      );

      // 전역 상태에 슬라이드쇼 정보 저장
      final firstSubtitle = scenes.isNotEmpty ? scenes[0].subtitle : '';
      final firstImagePath = scenes.isNotEmpty ? scenes[0].imagePath : null;
      ref.read(slideshowListProvider.notifier).addSlideshow(
        title: firstSubtitle,
        fileName: fileName,
        thumbnailPath: firstImagePath,
      );

      debugPrint('슬라이드쇼 JSON 저장 완료: $jsonPath');
    } catch (e) {
      debugPrint('슬라이드쇼 JSON 저장 실패: $e');
    }
  }

  void onFinishedAction() {
    state = state.copyWith(action: VideoPlaybackPageAction.none());
  }

  void onPlayPausePressed() {
    if (state.uiState.status == PlaybackStatus.playing) {
      _pause();
    } else {
      _play();
    }
  }

  void _play() {
    final scenes = state.uiState.scenes;
    if (scenes.isEmpty) return;

    state = state.copyWith(
      uiState: state.uiState.copyWith(status: PlaybackStatus.playing),
    );

    // 현재 위치에 맞는 오디오 재생
    _playAudioForCurrentScene();

    // 타이머로 진행 상황 업데이트 (100ms 간격)
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final currentMs =
          state.uiState.currentPosition.inMilliseconds + 100;

      if (currentMs >= state.uiState.totalDuration.inMilliseconds) {
        timer.cancel();
        _audioPlayer?.stop();
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            status: PlaybackStatus.completed,
            currentPosition: state.uiState.totalDuration,
          ),
        );
        return;
      }

      // 현재 시간에 맞는 Scene 찾기
      final sceneIndex = _findSceneIndexForTime(currentMs);
      final scene = scenes[sceneIndex];

      // Scene이 변경되면 오디오도 변경
      if (sceneIndex != _currentAudioSceneIndex) {
        _playAudioForScene(sceneIndex);
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          currentPosition: Duration(milliseconds: currentMs),
          currentSceneIndex: sceneIndex,
          currentImagePath: scene.imagePath,
          currentSubtitle: scene.subtitle,
        ),
      );
    });
  }

  void _pause() {
    _playbackTimer?.cancel();
    _audioPlayer?.pause();
    state = state.copyWith(
      uiState: state.uiState.copyWith(status: PlaybackStatus.paused),
    );
  }

  int _findSceneIndexForTime(int timeMs) {
    final scenes = state.uiState.scenes;
    for (var i = scenes.length - 1; i >= 0; i--) {
      if (timeMs >= scenes[i].startTimeMs) {
        return i;
      }
    }
    return 0;
  }

  void _playAudioForCurrentScene() {
    final sceneIndex = state.uiState.currentSceneIndex;
    _playAudioForScene(sceneIndex);
  }

  Future<void> _playAudioForScene(int sceneIndex) async {
    final scenes = state.uiState.scenes;
    if (sceneIndex < 0 || sceneIndex >= scenes.length) return;

    final scene = scenes[sceneIndex];
    _currentAudioSceneIndex = sceneIndex;

    if (scene.audioPath != null && await File(scene.audioPath!).exists()) {
      try {
        await _audioPlayer?.setFilePath(scene.audioPath!);
        await _audioPlayer?.play();
      } catch (e) {
        debugPrint('오디오 재생 실패: $e');
      }
    }
  }

  void onSeek(double progress) {
    final newMs =
        (state.uiState.totalDuration.inMilliseconds * progress).toInt();
    final sceneIndex = _findSceneIndexForTime(newMs);
    final scene = state.uiState.scenes[sceneIndex];

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentPosition: Duration(milliseconds: newMs),
        currentSceneIndex: sceneIndex,
        currentImagePath: scene.imagePath,
        currentSubtitle: scene.subtitle,
      ),
    );

    // 재생 중이면 오디오도 해당 위치로
    if (state.uiState.status == PlaybackStatus.playing) {
      _playAudioForScene(sceneIndex);
    }
  }

  void onReplayPressed() {
    final scenes = state.uiState.scenes;
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentPosition: Duration.zero,
        currentSceneIndex: 0,
        currentImagePath: scenes.isNotEmpty ? scenes[0].imagePath : null,
        currentSubtitle: scenes.isNotEmpty ? scenes[0].subtitle : null,
        status: PlaybackStatus.paused,
      ),
    );
    _currentAudioSceneIndex = -1;
    _play();
  }

  void onHomePressed() {
    state = state.copyWith(
      action: VideoPlaybackPageAction.navigateToHome(),
    );
  }
}
