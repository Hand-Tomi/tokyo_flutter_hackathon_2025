import 'package:freezed_annotation/freezed_annotation.dart';
import 'image_analysis_ui.dart';
import 'generated_image_ui.dart';

part 'image_analysis_page_ui_state.freezed.dart';

@freezed
class ImageAnalysisPageUiState with _$ImageAnalysisPageUiState {
  const factory ImageAnalysisPageUiState({
    @Default(null) String? selectedImagePath,
    @Default(false) bool isAnalyzing,
    @Default(false) bool isGenerating,
    @Default(null) ImageAnalysisUi? currentAnalysis,
    @Default(null) GeneratedImageUi? generatedImage,
  }) = _ImageAnalysisPageUiState;
}

@freezed
class ImageAnalysisPageAction with _$ImageAnalysisPageAction {
  factory ImageAnalysisPageAction.none() = _None;
  factory ImageAnalysisPageAction.pickImage() = _PickImage;
  factory ImageAnalysisPageAction.showAnalysisResult(
    ImageAnalysisUi analysis,
  ) = _ShowAnalysisResult;
  factory ImageAnalysisPageAction.showGeneratedImage(
    GeneratedImageUi image,
  ) = _ShowGeneratedImage;
  factory ImageAnalysisPageAction.showError(String message) = _ShowError;
}
