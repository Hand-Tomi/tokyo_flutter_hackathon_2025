import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_ui_state.freezed.dart';

/// Home 페이지의 UI 상태
@freezed
class HomePageUiState with _$HomePageUiState {
  const factory HomePageUiState() = _HomePageUiState;
}

/// Home 페이지의 액션
@freezed
class HomePageAction with _$HomePageAction {
  factory HomePageAction.none() = _None;
  factory HomePageAction.navigateToSceneCreation() = _NavigateToSceneCreation;
}
