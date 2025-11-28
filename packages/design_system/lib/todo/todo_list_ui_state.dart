import 'package:design_system/todo/todo_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_list_ui_state.freezed.dart';

/// TodoリストページのUI状態
/// 画面に表示するデータを保持
@freezed
abstract class TodoListPageUiState with _$TodoListPageUiState {
  const factory TodoListPageUiState({
    @Default([]) List<TodoUi> todos,
    @Default(false) bool isLoading,
  }) = _TodoListPageUiState;
}

/// Todoリストページのアクション
/// 一度だけ実行されるイベント (ダイアログ表示、画面遷移など)
@freezed
abstract class TodoListPageAction with _$TodoListPageAction {
  factory TodoListPageAction.none() = _None;
  factory TodoListPageAction.showAddDialog() = _ShowAddDialog;
  factory TodoListPageAction.showError(String message) = _ShowError;
}
