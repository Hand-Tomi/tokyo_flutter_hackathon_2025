import 'package:design_system/todo/todo_list_ui_state.dart';
import 'package:domain/todo.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/todo/todo_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_list_page_view_model.g.dart';

/// Todo リストページの ViewModel
///
/// ビジネスロジックと状態管理を担当
@riverpod
class TodoListPageViewModel extends _$TodoListPageViewModel {
  // サンプル用のインメモリーストレージ
  final List<Todo> _todos = [];

  @override
  PageState<TodoListPageUiState, TodoListPageAction> build() {
    return PageState(
      uiState: TodoListPageUiState(),
      action: TodoListPageAction.none(),
    );
  }

  /// アクション完了時の状態リセット
  void onFinishedAction() {
    state = state.copyWith(action: TodoListPageAction.none());
  }

  /// TODO追加ボタン押下時
  void onAddPressed() {
    state = state.copyWith(action: TodoListPageAction.showAddDialog());
  }

  /// TODO追加実行
  Future<void> onAddTodo(String title, String description) async {
    state = state.copyWith(uiState: state.uiState.copyWith(isLoading: true));

    try {
      // 新しいTODOを作成
      final newTodo = Todo(
        id: const Uuid().v4(),
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      _todos.add(newTodo);

      // UI状態を更新
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          todos: _todos.map((todo) => todo.toUi()).toList(),
          isLoading: false,
        ),
      );
    } on Object {
      state = state.copyWith(
        uiState: state.uiState.copyWith(isLoading: false),
        action: TodoListPageAction.showError('TODOの追加に失敗しました'),
      );
    }
  }

  /// TODO完了状態トグル
  void onToggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index == -1) return;

    _todos[index] = _todos[index].copyWith(
      isCompleted: !_todos[index].isCompleted,
    );

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        todos: _todos.map((todo) => todo.toUi()).toList(),
      ),
    );
  }

  /// TODO削除
  void onDeleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        todos: _todos.map((todo) => todo.toUi()).toList(),
      ),
    );
  }
}
