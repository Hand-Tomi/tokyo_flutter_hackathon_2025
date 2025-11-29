import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_generation_ui_state.freezed.dart';

/// 영상 생성 단계
enum VideoGenerationStep {
  preparing, // 준비 중
  combiningImages, // 이미지 합성 중
  addingAudio, // 오디오 추가 중
  finalizing, // 마무리 중
  completed, // 완료
  error, // 오류
}

/// 영상 생성 페이지의 UI 상태
@freezed
class VideoGenerationPageUiState with _$VideoGenerationPageUiState {
  const factory VideoGenerationPageUiState({
    @Default(VideoGenerationStep.preparing) VideoGenerationStep step,
    @Default(0.0) double progress,
    @Default(0) int currentScene,
    @Default(0) int totalScenes,
    @Default('Preparing...') String statusMessage,
    String? videoPath,
  }) = _VideoGenerationPageUiState;
}

/// 영상 생성 페이지의 액션
@freezed
class VideoGenerationPageAction with _$VideoGenerationPageAction {
  factory VideoGenerationPageAction.none() = _None;
  factory VideoGenerationPageAction.navigateToVideoPlayback() =
      _NavigateToVideoPlayback;
  factory VideoGenerationPageAction.showError(String message) = _ShowError;
}
