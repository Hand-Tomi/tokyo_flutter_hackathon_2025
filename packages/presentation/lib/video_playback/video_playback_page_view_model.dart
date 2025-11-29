import 'dart:async';

import 'package:design_system/video_playback/video_playback_ui_state.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_playback_page_view_model.g.dart';

/// 영상 재생 페이지의 ViewModel
@riverpod
class VideoPlaybackPageViewModel extends _$VideoPlaybackPageViewModel {
  Timer? _playbackTimer;

  @override
  PageState<VideoPlaybackPageUiState, VideoPlaybackPageAction> build() {
    ref.onDispose(() {
      _playbackTimer?.cancel();
    });

    // Mock: 로딩 후 자동 재생
    Future.delayed(const Duration(seconds: 1), () {
      if (state.uiState.status == PlaybackStatus.loading) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            status: PlaybackStatus.paused,
            totalDuration: const Duration(minutes: 1, seconds: 30),
          ),
        );
      }
    });

    return PageState(
      uiState: const VideoPlaybackPageUiState(
        status: PlaybackStatus.loading,
        totalDuration: Duration(minutes: 1, seconds: 30),
      ),
      action: VideoPlaybackPageAction.none(),
    );
  }

  void onFinishedAction() {
    state = state.copyWith(action: VideoPlaybackPageAction.none());
  }

  void onPlayPausePressed() {
    if (state.uiState.status == PlaybackStatus.playing) {
      _pause();
    } else {
      _play();
    }
  }

  void _play() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(status: PlaybackStatus.playing),
    );

    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newPosition = state.uiState.currentPosition + const Duration(seconds: 1);

      if (newPosition >= state.uiState.totalDuration) {
        timer.cancel();
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            status: PlaybackStatus.completed,
            currentPosition: state.uiState.totalDuration,
          ),
        );
        return;
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(currentPosition: newPosition),
      );
    });
  }

  void _pause() {
    _playbackTimer?.cancel();
    state = state.copyWith(
      uiState: state.uiState.copyWith(status: PlaybackStatus.paused),
    );
  }

  void onSeek(double progress) {
    final newPosition = Duration(
      milliseconds:
          (state.uiState.totalDuration.inMilliseconds * progress).toInt(),
    );
    state = state.copyWith(
      uiState: state.uiState.copyWith(currentPosition: newPosition),
    );
  }

  void onReplayPressed() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentPosition: Duration.zero,
        status: PlaybackStatus.paused,
      ),
    );
    _play();
  }

  void onSaveSharePressed() {
    state = state.copyWith(
      action: VideoPlaybackPageAction.navigateToSaveShare(),
    );
  }
}
