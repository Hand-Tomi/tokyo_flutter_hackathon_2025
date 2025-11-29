import 'dart:io';

import 'package:design_system/step4_video_generation/video_generation_ui_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/services/service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_generation_page_view_model.g.dart';

/// 영상 생성 페이지의 ViewModel
@riverpod
class VideoGenerationPageViewModel extends _$VideoGenerationPageViewModel {
  @override
  PageState<VideoGenerationPageUiState, VideoGenerationPageAction> build() {
    final scenes = ref.watch(sceneListProvider);

    // 페이지 진입 시 자동으로 영상 생성 시작
    Future.microtask(() => _generateVideo());

    return PageState(
      uiState: VideoGenerationPageUiState(
        step: VideoGenerationStep.preparing,
        totalScenes: scenes.length,
        statusMessage: '준비 중...',
      ),
      action: VideoGenerationPageAction.none(),
    );
  }

  /// 실제 영상 생성
  Future<void> _generateVideo() async {
    final totalStopwatch = Stopwatch()..start();

    try {
      var scenes = ref.read(sceneListProvider);

      // Scene이 비어있으면 테스트용 Scene 설정
      if (scenes.isEmpty) {
        debugPrint('Scene이 비어있어 테스트 Scene 설정 중...');
        await _setupTestScene();
        scenes = ref.read(sceneListProvider);
      }

      if (scenes.isEmpty) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            step: VideoGenerationStep.error,
            statusMessage: '생성할 장면이 없습니다.',
          ),
          action: VideoGenerationPageAction.showError('생성할 장면이 없습니다.'),
        );
        return;
      }

      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      debugPrint('🎬 영상 생성 시작 (${scenes.length}개 장면)');

      // 1. 준비 단계
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          step: VideoGenerationStep.preparing,
          progress: 0.1,
          statusMessage: '파일 준비 중...',
        ),
      );

      final appDir = await getApplicationDocumentsDirectory();
      final mediaBasePath = '${appDir.path}/media';

      // 2. 영상 생성 서비스 호출
      final service = ref.read(videoGenerationServiceProvider);

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          step: VideoGenerationStep.combiningImages,
          progress: 0.2,
          statusMessage: '이미지 합성 중...',
        ),
      );

      final video = await service.generateVideo(
        scenes: scenes,
        mediaBasePath: mediaBasePath,
        onProgress: (progress, message) {
          // 진행 상황 업데이트 (0.2 ~ 0.9 범위로 매핑)
          final mappedProgress = 0.2 + (progress * 0.7);

          VideoGenerationStep step;
          if (progress < 0.3) {
            step = VideoGenerationStep.combiningImages;
          } else if (progress < 0.7) {
            step = VideoGenerationStep.addingAudio;
          } else {
            step = VideoGenerationStep.finalizing;
          }

          state = state.copyWith(
            uiState: state.uiState.copyWith(
              step: step,
              progress: mappedProgress,
              statusMessage: message,
              currentScene: ((progress * scenes.length).ceil()).clamp(1, scenes.length),
            ),
          );
        },
      );

      // 3. 완료
      totalStopwatch.stop();
      debugPrint('✅ 영상 생성 완료: ${video.videoPath}');
      debugPrint('⏱️ 총 소요 시간: ${totalStopwatch.elapsedMilliseconds}ms (${(totalStopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1)}초)');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          step: VideoGenerationStep.completed,
          progress: 1.0,
          statusMessage: '영상이 생성되었습니다!',
          videoPath: video.videoPath,
        ),
        action: VideoGenerationPageAction.navigateToVideoPlayback(),
      );
    } catch (e) {
      totalStopwatch.stop();
      debugPrint('❌ 영상 생성 실패: $e');
      debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          step: VideoGenerationStep.error,
          statusMessage: '영상 생성 실패: $e',
        ),
        action: VideoGenerationPageAction.showError('영상 생성 실패: $e'),
      );
    }
  }

  void onFinishedAction() {
    state = state.copyWith(action: VideoGenerationPageAction.none());
  }

  /// 재시도
  void onRetryPressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        step: VideoGenerationStep.preparing,
        progress: 0.0,
        statusMessage: '준비 중...',
        videoPath: null,
      ),
      action: VideoGenerationPageAction.none(),
    );
    _generateVideo();
  }

  /// 테스트용 Scene 설정 (assets에서 일러스트 + 오디오 복사 후 Scene 추가)
  Future<void> _setupTestScene() async {
    try {
      debugPrint('테스트 Scene 설정 시작 (영상 생성용)');

      final appDir = await getApplicationDocumentsDirectory();

      // 1. assets에서 테스트 이미지 로드 → illustrations 폴더에 저장
      final imageByteData = await rootBundle.load(
        'packages/presentation/assets/style_reference.png',
      );

      final illustrationsDir = Directory('${appDir.path}/media/illustrations');
      if (!await illustrationsDir.exists()) {
        await illustrationsDir.create(recursive: true);
      }

      const testIllustrationFileName = 'test_illustration.png';
      final illustrationFile =
          File('${illustrationsDir.path}/$testIllustrationFileName');
      await illustrationFile.writeAsBytes(imageByteData.buffer.asUint8List());
      debugPrint('테스트 일러스트 저장 완료: ${illustrationFile.path}');

      // 2. assets에서 테스트 오디오 로드 및 저장
      String? testAudioFileName;
      try {
        final audioByteData = await rootBundle.load(
          'packages/presentation/assets/test_audio.m4a',
        );

        final recordsDir = Directory('${appDir.path}/media/records');
        if (!await recordsDir.exists()) {
          await recordsDir.create(recursive: true);
        }

        testAudioFileName = 'test_audio.m4a';
        final audioFile = File('${recordsDir.path}/$testAudioFileName');
        await audioFile.writeAsBytes(audioByteData.buffer.asUint8List());
        debugPrint('테스트 오디오 저장 완료: ${audioFile.path}');
      } catch (e) {
        debugPrint('테스트 오디오 로드 실패 (오디오 없이 진행): $e');
      }

      // 3. Scene 추가 (illustrationFileName + audioFileName 포함)
      ref.read(sceneListProvider.notifier).addScene(
        SceneData(
          id: 'test_video_1',
          storyScript: '옛날옛날에 한 왕이 살고 있었어요.',
          illustrationFileName: testIllustrationFileName,
          audioFileName: testAudioFileName,
        ),
      );
      debugPrint(
          '테스트 Scene 추가 완료 (illustrationFileName: $testIllustrationFileName, audioFileName: $testAudioFileName)');
    } catch (e) {
      debugPrint('테스트 Scene 설정 실패: $e');
    }
  }
}
