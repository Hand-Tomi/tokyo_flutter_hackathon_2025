import 'package:design_system/step7_my_stories/my_stories_list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step7_my_stories/my_stories_list_page_view_model.dart';

/// My Stories 리스트 페이지
class MyStoriesListPage extends ConsumerWidget {
  const MyStoriesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myStoriesListPageViewModelProvider);
    final notifier = ref.read(myStoriesListPageViewModelProvider.notifier);

    ref.listen(
      myStoriesListPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToPlayback: (slideshowId) {
            context.push('/video-playback?slideshowId=$slideshowId');
          },
        );

        notifier.onFinishedAction();
      },
    );

    return MyStoriesListTemplate(
      uiState: state.uiState,
      onBackPressed: () => context.pop(),
      onStoryTap: notifier.onStoryTap,
    );
  }
}
