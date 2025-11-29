import 'package:design_system/video_generation/video_generation_ui.dart';
import 'package:domain/video_generation.dart';
import 'package:presentation/utils/formatters.dart';

// Domain enums are now used directly - no conversion needed!
// VideoGenerationStatus, VideoApiType, OutputFormat have display properties built-in

extension VideoGenerationProgressMapper on VideoGenerationProgress {
  VideoGenerationProgressUi toUi() {
    final progressValue = progress.clamp(0.0, 1.0);
    return VideoGenerationProgressUi(
      status: status,
      progress: progressValue,
      progressPercentage: '${(progressValue * 100).toInt()}%',
      message: message,
      errorMessage: errorMessage,
    );
  }
}

extension GeneratedVideoMapper on GeneratedVideo {
  GeneratedVideoUi toUi() {
    return GeneratedVideoUi(
      id: id,
      outputPath: outputPath,
      format: format,
      durationFormatted: Formatters.formatDuration(durationMs),
      fileSizeFormatted: Formatters.formatFileSize(fileSizeBytes),
      thumbnailPath: thumbnailPath,
      createdAtFormatted: Formatters.formatDateTime(createdAt),
    );
  }
}

/// 파일 정보에서 UI 모델 생성 유틸리티
class FileInfoMapper {
  static SelectedImageUi createImageUi({
    required String id,
    required String path,
    required String fileName,
    required int fileSizeBytes,
    String? thumbnailPath,
  }) {
    return SelectedImageUi(
      id: id,
      path: path,
      fileName: fileName,
      fileSizeFormatted: Formatters.formatFileSize(fileSizeBytes),
      thumbnailPath: thumbnailPath,
    );
  }

  static SelectedAudioUi createAudioUi({
    required String id,
    required String path,
    required String fileName,
    required int fileSizeBytes,
    required int durationMs,
  }) {
    return SelectedAudioUi(
      id: id,
      path: path,
      fileName: fileName,
      fileSizeFormatted: Formatters.formatFileSize(fileSizeBytes),
      durationFormatted: Formatters.formatDuration(durationMs),
    );
  }
}
