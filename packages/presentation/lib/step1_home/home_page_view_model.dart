import 'package:design_system/step1_home/home_page_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_view_model.g.dart';

/// Home 페이지의 ViewModel
@riverpod
class HomePageViewModel extends _$HomePageViewModel {
  @override
  PageState<HomePageUiState, HomePageAction> build() {
    return PageState(
      uiState: const HomePageUiState(),
      action: HomePageAction.none(),
    );
  }

  /// 액션 완료 시의 상태 리셋
  void onFinishedAction() {
    state = state.copyWith(action: HomePageAction.none());
  }
}
