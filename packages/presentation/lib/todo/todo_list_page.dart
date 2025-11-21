import 'package:design_system/todo/todo_list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/todo/todo_list_page_view_model.dart';

/// Todo リストページ
///
/// Presentation層: ルーティング、状態監視、アクション処理を担当
class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoListPageViewModelProvider);

    // アクション監視
    ref.listen(todoListPageViewModelProvider.select((value) => value.action), (
      _,
      next,
    ) {
      if (!context.mounted) return;

      next.when(
        none: () {},
        showAddDialog: () {
          _showAddDialog(context, ref);
        },
        showError: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );

      ref.read(todoListPageViewModelProvider.notifier).onFinishedAction();
    });

    // Template にデータとコールバックを渡すだけ
    return TodoListPageTemplate(
      uiState: state.uiState,
      onAddPressed: () {
        ref.read(todoListPageViewModelProvider.notifier).onAddPressed();
      },
      onToggle: (id) {
        ref.read(todoListPageViewModelProvider.notifier).onToggleTodo(id);
      },
      onDelete: (id) {
        ref.read(todoListPageViewModelProvider.notifier).onDeleteTodo(id);
      },
    );
  }

  /// TODO追加ダイアログ表示
  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('TODO追加'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: '説明',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                ref
                    .read(todoListPageViewModelProvider.notifier)
                    .onAddTodo(
                      titleController.text,
                      descriptionController.text,
                    );
                Navigator.of(context).pop();
              }
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
