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
