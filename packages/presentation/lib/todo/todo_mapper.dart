import 'package:design_system/todo/todo_ui.dart';
import 'package:domain/todo.dart';
import 'package:presentation/utils/formatters.dart';

/// Todo Domain Model → UI Model の変換拡張
///
/// ドメイン層のデータをUI層で表示可能な形式に変換
extension TodoMapper on Todo {
  /// UI Model に変換
  TodoUi toUi() {
    return TodoUi(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      formattedDate: Formatters.formatDateTime(createdAt),
    );
  }
}
