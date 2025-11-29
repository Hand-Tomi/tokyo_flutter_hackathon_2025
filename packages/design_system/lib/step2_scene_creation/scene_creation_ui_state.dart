import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_creation_ui_state.freezed.dart';

/// 장면 생성 단계
enum SceneCreationStep {
  recording, // 음성 녹음
  sttResult, // STT 결과 확인
  airScribble, // Air Scribble 그리기
}

/// 장면 생성 페이지의 UI 상태
@freezed
class SceneCreationPageUiState with _$SceneCreationPageUiState {
  const factory SceneCreationPageUiState({
    @Default(SceneCreationStep.recording) SceneCreationStep currentStep,
    @Default(1) int sceneNumber,
    @Default(false) bool isRecording,
    @Default(false) bool isSttLoading,
    @Default('') String sttText,
    @Default(false) bool isGeneratingImage,
    @Default('') String statusMessage,
    @Default('') String currentRecordingPath,
  }) = _SceneCreationPageUiState;
}

/// 장면 생성 페이지의 액션
@freezed
class SceneCreationPageAction with _$SceneCreationPageAction {
  factory SceneCreationPageAction.none() = _None;
  factory SceneCreationPageAction.showError(String message) = _ShowError;
  factory SceneCreationPageAction.navigateToSceneList() = _NavigateToSceneList;
  factory SceneCreationPageAction.navigateToHandTracking() = _NavigateToHandTracking;
  factory SceneCreationPageAction.showSceneCreated(int sceneNumber) =
      _ShowSceneCreated;
}
