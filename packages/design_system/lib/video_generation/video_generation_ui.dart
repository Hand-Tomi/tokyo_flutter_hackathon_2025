import 'package:domain/video_generation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_generation_ui.freezed.dart';

// Domain enums are used directly (VideoGenerationStatus, VideoApiType, OutputFormat)
// They now include display properties (label/displayName, description, emoji)

/// 선택된 이미지 (UI용)
@freezed
class SelectedImageUi with _$SelectedImageUi {
  const factory SelectedImageUi({
    required String id,
    required String path,
    required String fileName,
    required String fileSizeFormatted,
    String? thumbnailPath,
  }) = _SelectedImageUi;
}

/// 선택된 오디오 (UI용)
@freezed
class SelectedAudioUi with _$SelectedAudioUi {
  const factory SelectedAudioUi({
    required String id,
    required String path,
    required String fileName,
    required String fileSizeFormatted,
    required String durationFormatted,
  }) = _SelectedAudioUi;
}

/// 비디오 생성 진행 상황 (UI용)
@freezed
class VideoGenerationProgressUi with _$VideoGenerationProgressUi {
  const factory VideoGenerationProgressUi({
    required VideoGenerationStatus status,
    required double progress,
    required String progressPercentage,
    String? message,
    String? errorMessage,
  }) = _VideoGenerationProgressUi;
}

/// 생성된 비디오 (UI용)
@freezed
class GeneratedVideoUi with _$GeneratedVideoUi {
  const factory GeneratedVideoUi({
    required String id,
    required String outputPath,
    required OutputFormat format,
    required String durationFormatted,
    required String fileSizeFormatted,
    String? thumbnailPath,
    required String createdAtFormatted,
  }) = _GeneratedVideoUi;
}
