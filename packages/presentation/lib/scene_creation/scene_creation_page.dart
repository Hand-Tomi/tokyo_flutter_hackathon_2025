import 'package:design_system/scene_creation/scene_creation_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/scene_creation/scene_creation_page_view_model.dart';

/// 장면 생성 페이지
///
/// Presentation 계층: 라우팅, 상태 감시, 액션 처리
class SceneCreationPage extends ConsumerWidget {
  const SceneCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sceneCreationPageViewModelProvider);
    final notifier = ref.read(sceneCreationPageViewModelProvider.notifier);

    // 액션 감시
    ref.listen(
      sceneCreationPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          navigateToSceneList: () {
            context.go('/scene-list');
          },
          showSceneCreated: (sceneNumber) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Scene $sceneNumber created!')),
            );
          },
        );

        notifier.onFinishedAction();
      },
    );

    return SceneCreationTemplate(
      uiState: state.uiState,
      onBackPressed: () => context.pop(),
      onRecordPressed: notifier.onRecordPressed,
      onStopRecordPressed: notifier.onStopRecordPressed,
      onReRecordPressed: notifier.onReRecordPressed,
      onNextStepPressed: notifier.onNextStepPressed,
      onClearDrawingPressed: notifier.onClearDrawingPressed,
      onConfirmScenePressed: notifier.onConfirmScenePressed,
      onAddMoreScenePressed: notifier.onAddMoreScenePressed,
      onFinishPressed: notifier.onFinishPressed,
    );
  }
}
