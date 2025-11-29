import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uuid/uuid.dart';

/// 슬라이드쇼 기반 동영상 생성 서비스
///
/// FFmpeg 대신 이미지 슬라이드쇼 + 오디오 동시 재생 방식 사용
/// 실제 MP4 파일을 생성하지 않고, 재생에 필요한 정보를 준비
class SlideshowVideoService implements VideoGenerationService {
  static const _uuid = Uuid();

  @override
  Future<GeneratedVideo> generateVideo({
    required List<SceneData> scenes,
    required String mediaBasePath,
    ProgressCallback? onProgress,
  }) async {
    final totalStopwatch = Stopwatch()..start();

    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('🎬 슬라이드쇼 준비 시작 (${scenes.length}개 장면)');

    onProgress?.call(0.0, '준비 중...');

    // 1. 오디오 파일 길이 측정 및 Scene 정보 수집
    final sceneInfos = <SlideshowSceneInfo>[];
    var totalDurationMs = 0;

    final audioPlayer = AudioPlayer();

    for (var i = 0; i < scenes.length; i++) {
      final scene = scenes[i];
      final audioPath = '$mediaBasePath/records/${scene.audioFileName}';
      final imagePath =
          '$mediaBasePath/illustrations/${scene.illustrationFileName}';

      // 오디오 길이 측정 (없으면 기본 3초)
      int durationMs = 3000;
      if (scene.audioFileName != null) {
        try {
          final audioFile = File(audioPath);
          if (await audioFile.exists()) {
            final duration = await audioPlayer.setFilePath(audioPath);
            if (duration != null) {
              durationMs = duration.inMilliseconds;
            }
          }
        } catch (e) {
          debugPrint('오디오 길이 측정 실패: $e');
        }
      }

      sceneInfos.add(SlideshowSceneInfo(
        index: i,
        imagePath: imagePath,
        audioPath: scene.audioFileName != null ? audioPath : null,
        subtitle: scene.storyScript ?? '',
        durationMs: durationMs,
        startTimeMs: totalDurationMs,
      ));

      totalDurationMs += durationMs;
      final subtitlePreview = scene.storyScript != null
          ? scene.storyScript!.substring(
              0, (scene.storyScript!.length).clamp(0, 30))
          : '';
      debugPrint('📍 Scene ${i + 1}: ${durationMs}ms, "$subtitlePreview..."');

      onProgress?.call((i + 1) / scenes.length * 0.8, '장면 ${i + 1} 분석 중...');
    }

    await audioPlayer.dispose();

    // 2. 슬라이드쇼 정보 JSON 파일로 저장
    onProgress?.call(0.9, '정보 저장 중...');

    final videoId = _uuid.v4();
    final videosDir = Directory('$mediaBasePath/videos');
    if (!await videosDir.exists()) {
      await videosDir.create(recursive: true);
    }

    // JSON 형태로 슬라이드쇼 정보 저장
    final infoPath = '$mediaBasePath/videos/$videoId.json';
    final infoContent = _generateSlideshowInfo(sceneInfos, totalDurationMs);
    await File(infoPath).writeAsString(infoContent);

    totalStopwatch.stop();
    debugPrint('✅ 슬라이드쇼 준비 완료');
    debugPrint('⏱️ 총 소요 시간: ${totalStopwatch.elapsedMilliseconds}ms');
    debugPrint('📁 정보 파일: $infoPath');
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    onProgress?.call(1.0, '완료!');

    return GeneratedVideo(
      id: videoId,
      videoPath: infoPath, // JSON 파일 경로 (실제 비디오 대신)
      createdAt: DateTime.now(),
      durationMs: totalDurationMs,
      sceneCount: scenes.length,
    );
  }

  String _generateSlideshowInfo(
      List<SlideshowSceneInfo> scenes, int totalDurationMs) {
    final scenesJson = scenes.map((s) => '''
    {
      "index": ${s.index},
      "imagePath": "${s.imagePath}",
      "audioPath": ${s.audioPath != null ? '"${s.audioPath}"' : 'null'},
      "subtitle": "${s.subtitle.replaceAll('"', '\\"').replaceAll('\n', '\\n')}",
      "durationMs": ${s.durationMs},
      "startTimeMs": ${s.startTimeMs}
    }''').join(',\n');

    return '''{
  "totalDurationMs": $totalDurationMs,
  "sceneCount": ${scenes.length},
  "scenes": [
$scenesJson
  ]
}''';
  }
}

/// 슬라이드쇼 Scene 정보
class SlideshowSceneInfo {
  final int index;
  final String imagePath;
  final String? audioPath;
  final String subtitle;
  final int durationMs;
  final int startTimeMs;

  SlideshowSceneInfo({
    required this.index,
    required this.imagePath,
    required this.audioPath,
    required this.subtitle,
    required this.durationMs,
    required this.startTimeMs,
  });
}
