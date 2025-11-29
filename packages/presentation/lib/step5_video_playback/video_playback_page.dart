import 'package:design_system/step5_video_playback/video_playback_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step5_video_playback/video_playback_page_view_model.dart';

/// 영상 재생 페이지
class VideoPlaybackPage extends ConsumerWidget {
  const VideoPlaybackPage({
    super.key,
    this.slideshowId,
  });

  /// 저장된 슬라이드쇼 ID (null이면 현재 sceneList에서 새로 생성)
  final int? slideshowId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoPlaybackPageViewModelProvider(slideshowId));

    ref.listen(
      videoPlaybackPageViewModelProvider(slideshowId)
          .select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToHome: () {
            context.go('/home');
          },
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );

        ref
            .read(videoPlaybackPageViewModelProvider(slideshowId).notifier)
            .onFinishedAction();
      },
    );

    final notifier =
        ref.read(videoPlaybackPageViewModelProvider(slideshowId).notifier);

    return VideoPlaybackTemplate(
      uiState: state.uiState,
      onPlayPausePressed: notifier.onPlayPausePressed,
      onSeek: notifier.onSeek,
      onReplayPressed: notifier.onReplayPressed,
      onHomePressed: notifier.onHomePressed,
    );
  }
}
