import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_share_ui_state.freezed.dart';

/// 저장 상태
enum SaveStatus {
  idle,
  saving,
  saved,
  error,
}

/// 저장/공유 페이지의 UI 상태
@freezed
class SaveSharePageUiState with _$SaveSharePageUiState {
  const factory SaveSharePageUiState({
    @Default(SaveStatus.idle) SaveStatus saveStatus,
    String? videoPath,
    String? thumbnailPath,
    @Default('') String storyTitle,
  }) = _SaveSharePageUiState;
}

/// 저장/공유 페이지의 액션
@freezed
class SaveSharePageAction with _$SaveSharePageAction {
  factory SaveSharePageAction.none() = _None;
  factory SaveSharePageAction.navigateToHome() = _NavigateToHome;
  factory SaveSharePageAction.showSaveSuccess() = _ShowSaveSuccess;
  factory SaveSharePageAction.showShareSheet() = _ShowShareSheet;
  factory SaveSharePageAction.showError(String message) = _ShowError;
}
