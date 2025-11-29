import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_generation.freezed.dart';
part 'video_generation.g.dart';

/// 비디오 생성 요청 상태
enum VideoGenerationStatus {
  pending('대기 중', '⏳'),
  processingImages('이미지 처리 중', '🖼️'),
  processingAudio('오디오 처리 중', '🎵'),
  generatingVideo('비디오 생성 중', '🎬'),
  completed('완료', '✅'),
  failed('실패', '❌');

  const VideoGenerationStatus(this.label, this.emoji);
  final String label;
  final String emoji;
}

/// 비디오 생성에 사용할 API 타입
enum VideoApiType {
  kling('Kling 2.1/2.5', '캐릭터 일관성 최고', '🎥'),
  vidu('Vidu AI', 'Multi Entity 지원', '🎭'),
  runway('Runway Gen-4', '스타일화 강점', '🎨'),
  magicHour('Magic Hour', 'GIF 최적화', '✨');

  const VideoApiType(this.displayName, this.description, this.emoji);
  final String displayName;
  final String description;
  final String emoji;
}

/// 출력 형식
enum OutputFormat {
  mp4('MP4', '고품질 비디오', '📹'),
  mov('MOV', 'Apple 호환', '🍎'),
  gif('GIF', '애니메이션 이미지', '🎞️');

  const OutputFormat(this.displayName, this.description, this.emoji);
  final String displayName;
  final String description;
  final String emoji;
}

/// 비디오 생성 요청
@freezed
class VideoGenerationRequest with _$VideoGenerationRequest {
  const factory VideoGenerationRequest({
    required String id,
    required List<String> imagePaths,
    String? audioPath,
    @Default(VideoApiType.kling) VideoApiType apiType,
    @Default(OutputFormat.mp4) OutputFormat outputFormat,
    String? prompt,
    @Default(1080) int width,
    @Default(1920) int height,
    @Default(30) int fps,
    @Default(VideoGenerationStatus.pending) VideoGenerationStatus status,
    required DateTime createdAt,
  }) = _VideoGenerationRequest;

  factory VideoGenerationRequest.fromJson(Map<String, dynamic> json) =>
      _$VideoGenerationRequestFromJson(json);
}

/// 생성된 비디오 결과
@freezed
class GeneratedVideo with _$GeneratedVideo {
  const factory GeneratedVideo({
    required String id,
    required String requestId,
    required String outputPath,
    required OutputFormat format,
    required int durationMs,
    required int fileSizeBytes,
    String? thumbnailPath,
    required DateTime createdAt,
  }) = _GeneratedVideo;

  factory GeneratedVideo.fromJson(Map<String, dynamic> json) =>
      _$GeneratedVideoFromJson(json);
}

/// 비디오 생성 진행 상황
@freezed
class VideoGenerationProgress with _$VideoGenerationProgress {
  const factory VideoGenerationProgress({
    required String requestId,
    required VideoGenerationStatus status,
    @Default(0.0) double progress,
    String? message,
    String? errorMessage,
  }) = _VideoGenerationProgress;

  factory VideoGenerationProgress.fromJson(Map<String, dynamic> json) =>
      _$VideoGenerationProgressFromJson(json);
}
