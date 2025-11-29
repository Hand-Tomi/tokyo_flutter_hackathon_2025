import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sketch_test_ui_state.freezed.dart';

/// 스케치 테스트 페이지 UI 상태
@freezed
class SketchTestPageUiState with _$SketchTestPageUiState {
  const factory SketchTestPageUiState({
    /// 선택된 스케치 이미지 바이트
    Uint8List? sketchBytes,

    /// 동화 텍스트 입력
    @Default('') String storyText,

    /// 생성된 이미지 경로
    String? generatedImagePath,

    /// 로딩 상태
    @Default(false) bool isLoading,

    /// 상태 메시지
    @Default('스케치 이미지를 선택하세요') String statusMessage,
  }) = _SketchTestPageUiState;
}

/// 스케치 테스트 페이지 액션
@freezed
sealed class SketchTestPageAction with _$SketchTestPageAction {
  const factory SketchTestPageAction.none() = _None;
  const factory SketchTestPageAction.showError(String message) = _ShowError;
  const factory SketchTestPageAction.showSuccess(String message) = _ShowSuccess;
}
