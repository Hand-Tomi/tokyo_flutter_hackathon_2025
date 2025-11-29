import 'package:design_system/step3_scene_list/scene_list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step3_scene_list/scene_list_page_view_model.dart';

/// 장면 리스트 페이지
class SceneListPage extends ConsumerWidget {
  const SceneListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sceneListPageViewModelProvider);
    final notifier = ref.read(sceneListPageViewModelProvider.notifier);

    ref.listen(
      sceneListPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToSceneCreation: () {
            context.go('/scene-creation');
          },
          navigateToVideoGeneration: () {
            context.go('/video-generation');
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

    return SceneListTemplate(
      uiState: state.uiState,
      onBackPressed: () => context.pop(),
      onAddScenePressed: notifier.onAddScenePressed,
      onGenerateVideoPressed: notifier.onGenerateVideoPressed,
      onSceneTap: notifier.onSceneTap,
      onSceneDelete: notifier.onSceneDelete,
    );
  }
}
