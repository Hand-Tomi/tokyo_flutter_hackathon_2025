import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:design_system/step5_video_playback/video_playback_ui_state.dart';
import 'package:flutter/material.dart';

/// 영상 재생 페이지 Template
class VideoPlaybackTemplate extends StatelessWidget {
  const VideoPlaybackTemplate({
    super.key,
    required this.uiState,
    this.onBackPressed,
    this.onPlayPausePressed,
    this.onSeek,
    this.onSaveSharePressed,
    this.onReplayPressed,
  });

  final VideoPlaybackPageUiState uiState;
  final VoidCallback? onBackPressed;
  final VoidCallback? onPlayPausePressed;
  final void Function(double)? onSeek;
  final VoidCallback? onSaveSharePressed;
  final VoidCallback? onReplayPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: Stack(
          children: [
            // 메인 컨텐츠
            SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      // 헤더
                      Text('Your Story', style: AppTypography.headlineLarge),

                      const SizedBox(height: AppSpacing.lg),

                      // 비디오 플레이어 영역
                      Expanded(child: _buildVideoPlayer()),

                      const SizedBox(height: AppSpacing.md),

                      // 재생 컨트롤
                      _buildPlaybackControls(),

                      const SizedBox(height: AppSpacing.lg),

                      // 저장 & 공유 버튼
                      GameButton(
                        onPressed: onSaveSharePressed,
                        style: GameButtonStyle.primary,
                        icon: Icons.share,
                        label: 'Save & Share',
                      ),

                      const SizedBox(height: 140),
                    ],
                  ),
                ),
              ),
            ),

            // 뒤로가기 버튼
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: CircleIconButton(
                onPressed: onBackPressed,
                icon: Icons.arrow_back,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.overlayMedium, width: 2),
      ),
      child: Stack(
        children: [
          // 비디오 플레이스홀더
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.movie, size: 80, color: Colors.white38),
                SizedBox(height: AppSpacing.md),
                Text(
                  'Video Preview',
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ],
            ),
          ),

          // 로딩 인디케이터
          if (uiState.status == PlaybackStatus.loading)
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          // 재생/일시정지 오버레이
          if (uiState.status != PlaybackStatus.loading)
            Positioned.fill(
              child: GestureDetector(
                onTap: onPlayPausePressed,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.overlayMedium,
                      ),
                      child: Icon(
                        uiState.status == PlaybackStatus.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // 재생 완료 시 다시 재생 버튼
          if (uiState.status == PlaybackStatus.completed)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onReplayPressed,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.buttonOrange,
                          ),
                          child: const Icon(
                            Icons.replay,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text('Watch Again', style: AppTypography.titleMedium),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls() {
    final progress = uiState.totalDuration.inMilliseconds > 0
        ? uiState.currentPosition.inMilliseconds /
              uiState.totalDuration.inMilliseconds
        : 0.0;

    return Column(
      children: [
        // 시간 표시 슬라이더
        Row(
          children: [
            Text(
              _formatDuration(uiState.currentPosition),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            Expanded(
              child: Slider(
                value: progress.clamp(0.0, 1.0),
                onChanged: onSeek,
                activeColor: AppColors.buttonOrange,
                inactiveColor: AppColors.overlayMedium,
              ),
            ),
            Text(
              _formatDuration(uiState.totalDuration),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
