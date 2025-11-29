import 'package:design_system/step5_video_playback/video_playback_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step5_video_playback/video_playback_page_view_model.dart';

/// 영상 재생 페이지
class VideoPlaybackPage extends ConsumerWidget {
  const VideoPlaybackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoPlaybackPageViewModelProvider);

    ref.listen(
      videoPlaybackPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToSaveShare: () {
            context.go('/save-share');
          },
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );

        ref.read(videoPlaybackPageViewModelProvider.notifier).onFinishedAction();
      },
    );

    final notifier = ref.read(videoPlaybackPageViewModelProvider.notifier);

    return VideoPlaybackTemplate(
      uiState: state.uiState,
      onPlayPausePressed: notifier.onPlayPausePressed,
      onSeek: notifier.onSeek,
      onSaveSharePressed: notifier.onSaveSharePressed,
      onReplayPressed: notifier.onReplayPressed,
    );
  }
}
