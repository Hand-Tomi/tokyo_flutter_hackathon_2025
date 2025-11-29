import 'package:design_system/step4_video_generation/video_generation_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step4_video_generation/video_generation_page_view_model.dart';

/// 영상 생성 페이지
class VideoGenerationPage extends ConsumerWidget {
  const VideoGenerationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoGenerationPageViewModelProvider);
    final notifier = ref.read(videoGenerationPageViewModelProvider.notifier);

    ref.listen(
      videoGenerationPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToVideoPlayback: () {
            context.go('/video-playback');
          },
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );

        notifier.onFinishedAction();
      },
    );

    return VideoGenerationTemplate(uiState: state.uiState);
  }
}
