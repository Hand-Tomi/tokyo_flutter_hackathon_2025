import 'package:freezed_annotation/freezed_annotation.dart';
import 'image_analysis_ui.dart';

part 'image_analysis_page_ui_state.freezed.dart';

@freezed
class ImageAnalysisPageUiState with _$ImageAnalysisPageUiState {
  const factory ImageAnalysisPageUiState({
    @Default(null) String? selectedImagePath,
    @Default(false) bool isAnalyzing,
    @Default(null) ImageAnalysisUi? currentAnalysis,
  }) = _ImageAnalysisPageUiState;
}

@freezed
class ImageAnalysisPageAction with _$ImageAnalysisPageAction {
  factory ImageAnalysisPageAction.none() = _None;
  factory ImageAnalysisPageAction.pickImage() = _PickImage;
  factory ImageAnalysisPageAction.showAnalysisResult(
    ImageAnalysisUi analysis,
  ) = _ShowAnalysisResult;
  factory ImageAnalysisPageAction.showError(String message) = _ShowError;
}
