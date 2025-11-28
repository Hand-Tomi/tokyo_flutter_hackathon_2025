import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_ui.freezed.dart';

/// Todo UI Model
/// Domain Model (Todo) を UI 用に変換したモデル
/// 表示用にフォーマット済みのデータを保持
@freezed
abstract class TodoUi with _$TodoUi {
  const factory TodoUi({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required String formattedDate, // "2024/11/20 14:30" のようにフォーマット済み
  }) = _TodoUi;
}
