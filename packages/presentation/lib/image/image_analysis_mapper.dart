import 'package:domain/domain.dart';
import 'package:design_system/design_system.dart';
import 'package:intl/intl.dart';

extension ImageAnalysisMapper on ImageAnalysis {
  ImageAnalysisUi toUi() {
    return ImageAnalysisUi(
      id: id,
      originalImagePath: originalImagePath,
      analysisText: analysisText,
      sceneType: sceneType,
      tags: tags,
      formattedDate: DateFormat('yyyy/MM/dd HH:mm').format(createdAt),
    );
  }
}

extension GeneratedImageMapper on GeneratedImage {
  GeneratedImageUi toUi() {
    return GeneratedImageUi(
      id: id,
      imagePath: imagePath,
      prompt: prompt,
      statusLabel: _statusToLabel(status),
      formattedDate: DateFormat('yyyy/MM/dd HH:mm').format(createdAt),
    );
  }

  String _statusToLabel(GenerationStatus status) {
    switch (status) {
      case GenerationStatus.pending:
        return '생성 중';
      case GenerationStatus.completed:
        return '완료';
      case GenerationStatus.failed:
        return '실패';
    }
  }
}
