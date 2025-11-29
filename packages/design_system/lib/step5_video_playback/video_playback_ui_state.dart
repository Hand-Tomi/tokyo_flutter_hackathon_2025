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

/// 슬라이드쇼 Scene 정보 (재생용)
class SlideshowScene {
  final int index;
  final String imagePath;
  final String? audioPath;
  final String subtitle;
  final int durationMs;
  final int startTimeMs;

  const SlideshowScene({
    required this.index,
    required this.imagePath,
    this.audioPath,
    required this.subtitle,
    required this.durationMs,
    required this.startTimeMs,
  });
}

/// 영상 재생 페이지의 UI 상태
@freezed
class VideoPlaybackPageUiState with _$VideoPlaybackPageUiState {
  const factory VideoPlaybackPageUiState({
    @Default(PlaybackStatus.loading) PlaybackStatus status,
    @Default(Duration.zero) Duration currentPosition,
    @Default(Duration.zero) Duration totalDuration,
    String? videoPath,
    @Default([]) List<SlideshowScene> scenes,
    @Default(0) int currentSceneIndex,
    String? currentImagePath,
    String? currentSubtitle,
  }) = _VideoPlaybackPageUiState;
}

/// 영상 재생 페이지의 액션
@freezed
class VideoPlaybackPageAction with _$VideoPlaybackPageAction {
  factory VideoPlaybackPageAction.none() = _None;
  factory VideoPlaybackPageAction.navigateToSaveShare() = _NavigateToSaveShare;
  factory VideoPlaybackPageAction.showError(String message) = _ShowError;
}
