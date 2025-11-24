import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domain/domain.dart';
import 'package:design_system/design_system.dart';
import '../page_state.dart';
import '../services/service_providers.dart';
import 'image_analysis_mapper.dart';

part 'image_analysis_page_view_model.g.dart';

@riverpod
class ImageAnalysisPageViewModel extends _$ImageAnalysisPageViewModel {
  final ImagePicker _imagePicker = ImagePicker();
  ImageAnalysis? _currentAnalysis;
  GeneratedImage? _currentGeneratedImage;

  late final VisionService _visionService;
  late final ImageGenerationService _imageGenService;

  @override
  PageState<ImageAnalysisPageUiState, ImageAnalysisPageAction> build() {
    // 서비스 주입
    _visionService = ref.read(visionServiceProvider);
    _imageGenService = ref.read(imageGenerationServiceProvider);

    return PageState(
      uiState: const ImageAnalysisPageUiState(),
      action: ImageAnalysisPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: ImageAnalysisPageAction.none());
  }

  /// 이미지 선택
  Future<void> onPickImagePressed() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          selectedImagePath: image.path,
          currentAnalysis: null,
          generatedImage: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        action: ImageAnalysisPageAction.showError('이미지 선택 실패: $e'),
      );
    }
  }

  /// 이미지 분석
  Future<void> onAnalyzeImagePressed() async {
    if (state.uiState.selectedImagePath == null) return;

    state = state.copyWith(
      uiState: state.uiState.copyWith(isAnalyzing: true),
    );

    try {
      final analysisResult = await _visionService.analyzeImage(
        state.uiState.selectedImagePath!,
      );

      _currentAnalysis = analysisResult;

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isAnalyzing: false,
          currentAnalysis: analysisResult.toUi(),
        ),
        action: ImageAnalysisPageAction.showAnalysisResult(
          analysisResult.toUi(),
        ),
      );
    } catch (e) {
      state = state.copyWith(
        uiState: state.uiState.copyWith(isAnalyzing: false),
        action: ImageAnalysisPageAction.showError('이미지 분석 실패: $e'),
      );
    }
  }

  /// 새 이미지 생성
  Future<void> onGenerateImagePressed() async {
    if (_currentAnalysis == null) return;

    state = state.copyWith(
      uiState: state.uiState.copyWith(isGenerating: true),
    );

    try {
      final generatedImage = await _imageGenService.generateImage(
        _currentAnalysis!,
      );

      _currentGeneratedImage = generatedImage;

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isGenerating: false,
          generatedImage: generatedImage.toUi(),
        ),
        action: ImageAnalysisPageAction.showGeneratedImage(
          generatedImage.toUi(),
        ),
      );
    } catch (e) {
      state = state.copyWith(
        uiState: state.uiState.copyWith(isGenerating: false),
        action: ImageAnalysisPageAction.showError('이미지 생성 실패: $e'),
      );
    }
  }
}
