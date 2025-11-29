import 'package:design_system/step3_scene_list/scene_list_ui_state.dart';
import 'package:design_system/step3_scene_list/scene_ui.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scene_list_page_view_model.g.dart';

/// 장면 리스트 페이지의 ViewModel
@riverpod
class SceneListPageViewModel extends _$SceneListPageViewModel {
  @override
  PageState<SceneListPageUiState, SceneListPageAction> build() {
    // Mock 데이터
    final mockScenes = [
      const SceneUi(
        id: '1',
        sceneNumber: 1,
        sttText: 'Once upon a time, there was a little bunny...',
        status: SceneStatus.completed,
      ),
      const SceneUi(
        id: '2',
        sceneNumber: 2,
        sttText: 'The bunny found a magical carrot in the garden.',
        status: SceneStatus.completed,
      ),
      const SceneUi(
        id: '3',
        sceneNumber: 3,
        sttText: 'And they lived happily ever after!',
        status: SceneStatus.generating,
      ),
    ];

    return PageState(
      uiState: SceneListPageUiState(
        scenes: mockScenes,
        canGenerateVideo: mockScenes.every((s) => s.status == SceneStatus.completed),
      ),
      action: SceneListPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: SceneListPageAction.none());
  }

  void onAddScenePressed() {
    state = state.copyWith(
      action: SceneListPageAction.navigateToSceneCreation(),
    );
  }

  void onGenerateVideoPressed() {
    state = state.copyWith(
      action: SceneListPageAction.navigateToVideoGeneration(),
    );
  }

  void onSceneTap(String sceneId) {
    // TODO: 장면 상세 보기
  }

  void onSceneDelete(String sceneId) {
    final updatedScenes =
        state.uiState.scenes.where((s) => s.id != sceneId).toList();
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        scenes: updatedScenes,
        canGenerateVideo:
            updatedScenes.isNotEmpty &&
            updatedScenes.every((s) => s.status == SceneStatus.completed),
      ),
    );
  }
}
