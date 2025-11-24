import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_analysis_ui.freezed.dart';

@freezed
class ImageAnalysisUi with _$ImageAnalysisUi {
  const factory ImageAnalysisUi({
    required String id,
    required String originalImagePath,
    required String analysisText,
    required String sceneType,  // 이미 한글이니까 Label 불필요
    required List<String> tags,
    required String formattedDate,
  }) = _ImageAnalysisUi;
}
