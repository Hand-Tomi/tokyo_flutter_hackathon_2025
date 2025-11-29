import 'package:design_system/debug/debug_menu_item_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_list_ui_state.freezed.dart';

/// 디버그 리스트 페이지의 UI 상태
/// 화면에 표시할 데이터를 보유
@freezed
class DebugListPageUiState with _$DebugListPageUiState {
  const factory DebugListPageUiState({
    @Default([]) List<DebugMenuItemUi> menuItems,
    @Default(false) bool isLoading,
    required void Function(String id) onMenuItemTap,
  }) = _DebugListPageUiState;
}

/// 디버그 리스트 페이지의 액션
/// 한 번만 실행되는 이벤트 (화면 전환 등)
@freezed
class DebugListPageAction with _$DebugListPageAction {
  factory DebugListPageAction.none() = _None;
  factory DebugListPageAction.navigateToTodoList() = _NavigateToTodoList;
  factory DebugListPageAction.navigateToHandTracking() = _NavigateToHandTracking;
  factory DebugListPageAction.navigateToImageAnalysis() =
      _NavigateToImageAnalysis;
  factory DebugListPageAction.navigateToSketchTest() = _NavigateToSketchTest;
}
