import 'package:design_system/debug/debug_list_ui_state.dart';
import 'package:design_system/debug/debug_menu_item_ui.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_list_page_view_model.g.dart';

/// 디버그 리스트 페이지의 ViewModel
///
/// 비즈니스 로직과 상태 관리를 담당
@riverpod
class DebugListPageViewModel extends _$DebugListPageViewModel {
  @override
  PageState<DebugListPageUiState, DebugListPageAction> build() {
    // 디버그 메뉴 항목 초기화
    final menuItems = [
      const DebugMenuItemUi(
        id: 'home',
        title: '1. 홈 화면 (Home)',
        description: '홈 화면',
      ),
      // StorySpark 화면들
      const DebugMenuItemUi(
        id: 'scene_creation',
        title: '2. 장면 생성 화면 (SceneCreation)',
        description: '음성 녹음 + Air Scribble로 장면 만들기',
      ),
      const DebugMenuItemUi(
        id: 'scene_list',
        title: '3. 장면 리스트 화면 (SceneList)',
        description: '생성된 장면들 관리',
      ),
      const DebugMenuItemUi(
        id: 'video_generation',
        title: '4. 영상 생성 화면 (VideoGeneration)',
        description: 'MP4 동화 영상 생성',
      ),
      const DebugMenuItemUi(
        id: 'video_playback',
        title: '5. 영상 재생 화면 (VideoPlayback)',
        description: '완성된 동화 영상 재생',
      ),
      const DebugMenuItemUi(
        id: 'save_share',
        title: '6. 저장/공유 화면 (SaveShare)',
        description: '영상 다운로드 및 공유',
      ),
      // 기존 디버그 화면들
      const DebugMenuItemUi(
        id: 'todo_list',
        title: 'Todo 리스트',
        description: 'Todo 관리 화면',
      ),
      const DebugMenuItemUi(
        id: 'hand_tracking',
        title: 'Hand Tracking',
        description: '손 추적 및 제스처 인식',
      ),
      const DebugMenuItemUi(
        id: 'video_generation',
        title: 'Video Generation',
        description: 'AI 비디오 생성',
      ),
    ];

    return PageState(
      uiState: DebugListPageUiState(
        menuItems: menuItems,
        onMenuItemTap: onMenuItemTap,
      ),
      action: DebugListPageAction.none(),
    );
  }

  /// 액션 완료 시의 상태 리셋
  void onFinishedAction() {
    state = state.copyWith(action: DebugListPageAction.none());
  }

  /// 메뉴 항목 탭 시
  void onMenuItemTap(String id) {
    switch (id) {
      case 'home':
        state = state.copyWith(action: DebugListPageAction.navigateToHome());
        break;
      case 'scene_creation':
        state = state.copyWith(
          action: DebugListPageAction.navigateToSceneCreation(),
        );
        break;
      case 'scene_list':
        state = state.copyWith(
          action: DebugListPageAction.navigateToSceneList(),
        );
        break;
      case 'video_generation':
        state = state.copyWith(
          action: DebugListPageAction.navigateToVideoGeneration(),
        );
        break;
      case 'video_playback':
        state = state.copyWith(
          action: DebugListPageAction.navigateToVideoPlayback(),
        );
        break;
      case 'save_share':
        state = state.copyWith(
          action: DebugListPageAction.navigateToSaveShare(),
        );
        break;
      case 'todo_list':
        state = state.copyWith(
          action: DebugListPageAction.navigateToTodoList(),
        );
        break;
      case 'hand_tracking':
        state = state.copyWith(
          action: DebugListPageAction.navigateToHandTracking(),
        );
        break;
      case 'image_analysis':
        state = state.copyWith(
          action: DebugListPageAction.navigateToImageAnalysis(),
        );
        break;
      case 'sketch_test':
        state = state.copyWith(
          action: DebugListPageAction.navigateToSketchTest(),
        );
        break;
    }
  }
}
