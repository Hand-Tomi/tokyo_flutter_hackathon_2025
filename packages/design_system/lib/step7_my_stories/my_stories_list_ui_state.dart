import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_stories_list_ui_state.freezed.dart';

/// My Stories 리스트 페이지 UI 상태
@freezed
class MyStoriesListPageUiState with _$MyStoriesListPageUiState {
  const factory MyStoriesListPageUiState({
    @Default(false) bool isLoading,
  }) = _MyStoriesListPageUiState;
}

/// My Stories 리스트 페이지 액션
@freezed
class MyStoriesListPageAction with _$MyStoriesListPageAction {
  const factory MyStoriesListPageAction.none() = _None;
}
