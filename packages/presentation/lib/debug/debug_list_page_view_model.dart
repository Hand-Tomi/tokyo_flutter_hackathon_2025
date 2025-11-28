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
        id: 'voice_chat',
        title: 'Voice Chat',
        description: 'AI 음성 대화 (OpenAI Realtime)',
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
      case 'todo_list':
        state = state.copyWith(action: DebugListPageAction.navigateToTodoList());
        break;
      case 'hand_tracking':
        state =
            state.copyWith(action: DebugListPageAction.navigateToHandTracking());
        break;
      case 'voice_chat':
        state =
            state.copyWith(action: DebugListPageAction.navigateToVoiceChat());
        break;
    }
  }
}
