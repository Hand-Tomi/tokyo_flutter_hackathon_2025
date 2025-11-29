import 'package:design_system/scene_list/scene_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_list_ui_state.freezed.dart';

/// 장면 리스트 페이지의 UI 상태
@freezed
class SceneListPageUiState with _$SceneListPageUiState {
  const factory SceneListPageUiState({
    @Default([]) List<SceneUi> scenes,
    @Default(false) bool canGenerateVideo,
  }) = _SceneListPageUiState;
}

/// 장면 리스트 페이지의 액션
@freezed
class SceneListPageAction with _$SceneListPageAction {
  factory SceneListPageAction.none() = _None;
  factory SceneListPageAction.navigateToSceneCreation() =
      _NavigateToSceneCreation;
  factory SceneListPageAction.navigateToVideoGeneration() =
      _NavigateToVideoGeneration;
  factory SceneListPageAction.showError(String message) = _ShowError;
}
