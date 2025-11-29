import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_story_ui.freezed.dart';

/// My Stories 리스트 아이템 UI 모델
@freezed
class MyStoryUi with _$MyStoryUi {
  const factory MyStoryUi({
    required int id,
    required String title,
    required String fileName,
    String? thumbnailPath,
  }) = _MyStoryUi;
}
