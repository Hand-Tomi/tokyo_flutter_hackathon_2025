import 'package:design_system/step2_scene_creation/scene_creation_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scene_creation_page_view_model.g.dart';

/// 장면 생성 페이지의 ViewModel
@riverpod
class SceneCreationPageViewModel extends _$SceneCreationPageViewModel {
  @override
  PageState<SceneCreationPageUiState, SceneCreationPageAction> build() {
    return PageState(
      uiState: const SceneCreationPageUiState(),
      action: SceneCreationPageAction.none(),
    );
  }

  /// 액션 완료 시 리셋
  void onFinishedAction() {
    state = state.copyWith(action: SceneCreationPageAction.none());
  }

  /// 녹음 시작
  void onRecordPressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(isRecording: true),
    );
  }

  /// 녹음 중지
  void onStopRecordPressed() {
    // 녹음 중지 후 STT 결과 화면으로 이동
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isRecording: false,
        currentStep: SceneCreationStep.sttResult,
        sttText: 'Once upon a time, there was a little bunny...', // Mock STT
      ),
    );
  }

  /// 재녹음
  void onReRecordPressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentStep: SceneCreationStep.recording,
        sttText: '',
      ),
    );
  }

  /// 다음 단계로 이동
  void onNextStepPressed() {
    final currentStep = state.uiState.currentStep;
    SceneCreationStep nextStep;

    switch (currentStep) {
      case SceneCreationStep.recording:
        nextStep = SceneCreationStep.sttResult;
        break;
      case SceneCreationStep.sttResult:
        nextStep = SceneCreationStep.airScribble;
        break;
      case SceneCreationStep.airScribble:
        nextStep = SceneCreationStep.confirmation;
        break;
      case SceneCreationStep.confirmation:
        nextStep = SceneCreationStep.confirmation;
        break;
    }

    state = state.copyWith(
      uiState: state.uiState.copyWith(currentStep: nextStep),
    );
  }

  /// 그림 지우기
  void onClearDrawingPressed() {
    // TODO: 실제 그림 지우기 로직
  }

  /// 장면 확정
  void onConfirmScenePressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentStep: SceneCreationStep.confirmation,
      ),
    );
  }

  /// 장면 추가
  void onAddMoreScenePressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        sceneNumber: state.uiState.sceneNumber + 1,
        currentStep: SceneCreationStep.recording,
        sttText: '',
        isRecording: false,
      ),
    );
  }

  /// 완료 (장면 리스트로 이동)
  void onFinishPressed() {
    state = state.copyWith(
      action: SceneCreationPageAction.navigateToSceneList(),
    );
  }
}
