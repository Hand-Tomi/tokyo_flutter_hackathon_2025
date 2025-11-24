import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_analysis.freezed.dart';
part 'image_analysis.g.dart';

@freezed
class ImageAnalysis with _$ImageAnalysis {
  const factory ImageAnalysis({
    required String id,
    required String originalImagePath,
    required String analysisText,
    required String sceneType,
    required List<String> tags,
    required DateTime createdAt,
  }) = _ImageAnalysis;

  factory ImageAnalysis.fromJson(Map<String, dynamic> json) =>
      _$ImageAnalysisFromJson(json);
}
