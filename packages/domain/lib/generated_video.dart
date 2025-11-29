import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated_video.freezed.dart';
part 'generated_video.g.dart';

/// 생성된 동영상 정보
@freezed
class GeneratedVideo with _$GeneratedVideo {
  const factory GeneratedVideo({
    required String id,
    required String videoPath,
    required DateTime createdAt,
    @Default(0) int durationMs,
    @Default(0) int sceneCount,
  }) = _GeneratedVideo;

  factory GeneratedVideo.fromJson(Map<String, dynamic> json) =>
      _$GeneratedVideoFromJson(json);
}
