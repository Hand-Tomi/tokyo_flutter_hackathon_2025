import 'package:design_system/step7_my_stories/my_stories_list_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_stories_list_page_view_model.g.dart';

/// My Stories 리스트 페이지의 ViewModel
@riverpod
class MyStoriesListPageViewModel extends _$MyStoriesListPageViewModel {
  @override
  PageState<MyStoriesListPageUiState, MyStoriesListPageAction> build() {
    // MVP: 빈 상태만 반환 (향후 저장된 영상 목록 로드 로직 추가 예정)
    return PageState(
      uiState: const MyStoriesListPageUiState(),
      action: const MyStoriesListPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: const MyStoriesListPageAction.none());
  }
}
