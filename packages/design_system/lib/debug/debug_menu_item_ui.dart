import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_menu_item_ui.freezed.dart';

/// 디버그 메뉴 아이템 UI 모델
@freezed
class DebugMenuItemUi with _$DebugMenuItemUi {
  const factory DebugMenuItemUi({
    required String id,
    required String title,
    required String description,
  }) = _DebugMenuItemUi;
}
