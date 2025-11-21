import 'package:design_system/todo/todo_card.dart';
import 'package:design_system/todo/todo_list_ui_state.dart';
import 'package:flutter/material.dart';

/// TodoリストページTemplate
/// 純粋なUIレイアウト (状態管理なし)
class TodoListPageTemplate extends StatelessWidget {
  const TodoListPageTemplate({
    super.key,
    required this.uiState,
    required this.onAddPressed,
    required this.onToggle,
    required this.onDelete,
  });

  final TodoListPageUiState uiState;
  final VoidCallback onAddPressed;
  final void Function(String id) onToggle;
  final void Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 TODO リスト'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: uiState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : uiState.todos.isEmpty
          ? const Center(
              child: Text(
                'TODOがありません\n下の＋ボタンで追加できます',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: uiState.todos.length,
              itemBuilder: (context, index) {
                final todo = uiState.todos[index];
                return TodoCard(
                  todo: todo,
                  onToggle: () => onToggle(todo.id),
                  onDelete: () => onDelete(todo.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
