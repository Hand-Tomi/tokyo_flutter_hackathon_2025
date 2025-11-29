import 'package:design_system/step7_my_stories/my_stories_list_ui_state.dart';
import 'package:design_system/step7_my_stories/my_story_ui.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/slideshow_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_stories_list_page_view_model.g.dart';

/// My Stories 리스트 페이지의 ViewModel
@riverpod
class MyStoriesListPageViewModel extends _$MyStoriesListPageViewModel {
  @override
  PageState<MyStoriesListPageUiState, MyStoriesListPageAction> build() {
    // slideshowList를 watch하여 실시간으로 업데이트
    final slideshowList = ref.watch(slideshowListProvider);

    // SlideshowData -> MyStoryUi 변환
    final stories = slideshowList
        .map(
          (data) => MyStoryUi(
            id: data.id,
            title: data.title,
            fileName: data.fileName,
            thumbnailPath: data.thumbnailPath,
          ),
        )
        .toList();

    return PageState(
      uiState: MyStoriesListPageUiState(stories: stories),
      action: const MyStoriesListPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: const MyStoriesListPageAction.none());
  }

  void onStoryTap(int storyId) {
    state = state.copyWith(
      action: MyStoriesListPageAction.navigateToPlayback(storyId),
    );
  }
}
