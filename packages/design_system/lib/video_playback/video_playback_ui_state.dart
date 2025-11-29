import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_playback_ui_state.freezed.dart';

/// 재생 상태
enum PlaybackStatus {
  loading,
  playing,
  paused,
  completed,
  error,
}

/// 영상 재생 페이지의 UI 상태
@freezed
class VideoPlaybackPageUiState with _$VideoPlaybackPageUiState {
  const factory VideoPlaybackPageUiState({
    @Default(PlaybackStatus.loading) PlaybackStatus status,
    @Default(Duration.zero) Duration currentPosition,
    @Default(Duration.zero) Duration totalDuration,
    String? videoPath,
  }) = _VideoPlaybackPageUiState;
}

/// 영상 재생 페이지의 액션
@freezed
class VideoPlaybackPageAction with _$VideoPlaybackPageAction {
  factory VideoPlaybackPageAction.none() = _None;
  factory VideoPlaybackPageAction.navigateToSaveShare() = _NavigateToSaveShare;
  factory VideoPlaybackPageAction.showError(String message) = _ShowError;
}
