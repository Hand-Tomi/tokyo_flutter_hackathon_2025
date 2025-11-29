import 'dart:async';

import 'package:design_system/step4_video_generation/video_generation_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_generation_page_view_model.g.dart';

/// 영상 생성 페이지의 ViewModel
@riverpod
class VideoGenerationPageViewModel extends _$VideoGenerationPageViewModel {
  Timer? _progressTimer;

  @override
  PageState<VideoGenerationPageUiState, VideoGenerationPageAction> build() {
    // 자동으로 생성 시뮬레이션 시작
    ref.onDispose(() {
      _progressTimer?.cancel();
    });

    // Mock: 자동 진행 시뮬레이션
    _startMockGeneration();

    return PageState(
      uiState: const VideoGenerationPageUiState(
        step: VideoGenerationStep.preparing,
        totalScenes: 3,
      ),
      action: VideoGenerationPageAction.none(),
    );
  }

  void _startMockGeneration() {
    var progress = 0.0;
    var currentStep = VideoGenerationStep.preparing;

    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      progress += 0.02;

      if (progress >= 1.0) {
        timer.cancel();
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            step: VideoGenerationStep.completed,
            progress: 1.0,
            statusMessage: 'Video created successfully!',
          ),
          action: VideoGenerationPageAction.navigateToVideoPlayback(),
        );
        return;
      }

      // 단계 업데이트
      if (progress < 0.2) {
        currentStep = VideoGenerationStep.preparing;
      } else if (progress < 0.6) {
        currentStep = VideoGenerationStep.combiningImages;
      } else if (progress < 0.8) {
        currentStep = VideoGenerationStep.addingAudio;
      } else {
        currentStep = VideoGenerationStep.finalizing;
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          step: currentStep,
          progress: progress,
          currentScene: ((progress * 3).ceil()).clamp(1, 3),
          statusMessage: _getStatusMessage(currentStep, progress),
        ),
      );
    });
  }

  String _getStatusMessage(VideoGenerationStep step, double progress) {
    switch (step) {
      case VideoGenerationStep.preparing:
        return 'Getting everything ready...';
      case VideoGenerationStep.combiningImages:
        return 'Weaving your story together...';
      case VideoGenerationStep.addingAudio:
        return 'Adding your voice...';
      case VideoGenerationStep.finalizing:
        return 'Almost there...';
      case VideoGenerationStep.completed:
        return 'Video created successfully!';
      case VideoGenerationStep.error:
        return 'Something went wrong';
    }
  }

  void onFinishedAction() {
    state = state.copyWith(action: VideoGenerationPageAction.none());
  }
}
