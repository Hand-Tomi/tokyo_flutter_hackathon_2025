import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../page_state.dart';
import '../services/service_providers.dart';
import 'image_analysis_mapper.dart';

part 'image_analysis_page_view_model.g.dart';

@riverpod
class ImageAnalysisPageViewModel extends _$ImageAnalysisPageViewModel {
  final ImagePicker _imagePicker = ImagePicker();
  ImageAnalysis? _currentAnalysis;

  // Lazy initialization - only when needed
  VisionService? _visionService;
  ImageGenerationService? _imageGenService;

  VisionService get visionService {
    _visionService ??= ref.read(visionServiceProvider);
    return _visionService!;
  }

  ImageGenerationService get imageGenService {
    _imageGenService ??= ref.read(imageGenerationServiceProvider);
    return _imageGenService!;
  }

  @override
  PageState<ImageAnalysisPageUiState, ImageAnalysisPageAction> build() {
    // Keep state alive to preserve image across page navigation
    ref.keepAlive();

    return PageState(
      uiState: const ImageAnalysisPageUiState(),
      action: ImageAnalysisPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: ImageAnalysisPageAction.none());
  }

  /// 이미지 바이트로 설정 (손 그림에서 생성된 이미지)
  Future<void> onSetImageFromBytes(Uint8List imageBytes) async {
    try {
      debugPrint('Setting image from bytes: ${imageBytes.length} bytes');

      // 임시 파일로 저장
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/hand_drawing_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(imageBytes);

      debugPrint('Image saved to: ${file.path}');
      debugPrint('File exists: ${await file.exists()}');

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          selectedImagePath: file.path,
          currentAnalysis: null,
          generatedImage: null,
        ),
      );

      debugPrint('State updated. selectedImagePath: ${state.uiState.selectedImagePath}');
    } catch (e) {
      debugPrint('Error setting image: $e');
      state = state.copyWith(
        action: ImageAnalysisPageAction.showError('이미지 설정 실패: $e'),
      );
    }
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

    state = state.copyWith(uiState: state.uiState.copyWith(isAnalyzing: true));

    try {
      final analysisResult = await visionService.analyzeImage(
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

    state = state.copyWith(uiState: state.uiState.copyWith(isGenerating: true));

    try {
      final generatedImage = await imageGenService.generateImage(
        _currentAnalysis!,
      );

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
