import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sketch_test_page_view_model.g.dart';

/// 스케치 테스트 페이지 ViewModel
@riverpod
class SketchTestPageViewModel extends _$SketchTestPageViewModel {
  final _imagePicker = ImagePicker();

  @override
  PageState<SketchTestPageUiState, SketchTestPageAction> build() {
    return PageState(
      uiState: const SketchTestPageUiState(),
      action: SketchTestPageAction.none(),
    );
  }

  /// 액션 완료 후 리셋
  void onFinishedAction() {
    state = state.copyWith(action: SketchTestPageAction.none());
  }

  /// 이미지 선택
  Future<void> onPickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            sketchBytes: bytes,
            statusMessage: '스케치 이미지가 선택되었습니다. 변환 버튼을 눌러주세요.',
          ),
        );
      }
    } catch (e) {
      debugPrint('이미지 선택 오류: $e');
      state = state.copyWith(
        action: SketchTestPageAction.showError('이미지 선택 실패: $e'),
      );
    }
  }

  /// 동화 텍스트 변경
  void onStoryTextChanged(String text) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(storyText: text),
    );
  }

  /// 이미지 생성
  Future<void> onGenerate() async {
    final sketchBytes = state.uiState.sketchBytes;
    if (sketchBytes == null) {
      state = state.copyWith(
        action: SketchTestPageAction.showError('스케치 이미지를 먼저 선택해주세요.'),
      );
      return;
    }

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isLoading: true,
        statusMessage: '동화풍 이미지 생성 중...',
        generatedImagePath: null,
      ),
    );

    try {
      final service = ref.read(sketchToImageServiceProvider);
      final result = await service.generateFromSketch(
        sketchBytes: sketchBytes,
        storyText: state.uiState.storyText,
      );

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isLoading: false,
          statusMessage: '이미지 생성 완료!',
          generatedImagePath: result.imagePath,
        ),
        action: SketchTestPageAction.showSuccess('동화풍 이미지가 생성되었습니다!'),
      );
    } catch (e) {
      debugPrint('이미지 생성 오류: $e');
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isLoading: false,
          statusMessage: '이미지 생성 실패: $e',
        ),
        action: SketchTestPageAction.showError('이미지 생성 실패: $e'),
      );
    }
  }

  /// 초기화
  void onClear() {
    state = PageState(
      uiState: const SketchTestPageUiState(),
      action: SketchTestPageAction.none(),
    );
  }
}
