import 'dart:async';

import 'package:design_system/save_share/save_share_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_share_page_view_model.g.dart';

/// 저장/공유 페이지의 ViewModel
@riverpod
class SaveSharePageViewModel extends _$SaveSharePageViewModel {
  @override
  PageState<SaveSharePageUiState, SaveSharePageAction> build() {
    return PageState(
      uiState: const SaveSharePageUiState(
        storyTitle: 'My Amazing Story',
      ),
      action: SaveSharePageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: SaveSharePageAction.none());
  }

  void onDownloadPressed() {
    // Mock 저장 시뮬레이션
    state = state.copyWith(
      uiState: state.uiState.copyWith(saveStatus: SaveStatus.saving),
    );

    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(
        uiState: state.uiState.copyWith(saveStatus: SaveStatus.saved),
        action: SaveSharePageAction.showSaveSuccess(),
      );
    });
  }

  void onSharePressed() {
    state = state.copyWith(
      action: SaveSharePageAction.showShareSheet(),
    );
  }

  void onHomePressed() {
    state = state.copyWith(
      action: SaveSharePageAction.navigateToHome(),
    );
  }
}
