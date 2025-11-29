import 'package:design_system/step1_home/home_page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/step1_home/home_page_view_model.dart';

/// Home 페이지
///
/// Presentation 계층: 라우팅, 상태 감시, 액션 처리를 담당
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageViewModelProvider);

    // 액션 감시
    ref.listen(
      homePageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToSceneCreation: () {
            context.push('/scene-creation');
          },
        );

        ref.read(homePageViewModelProvider.notifier).onFinishedAction();
      },
    );

    // Template에 데이터 전달
    return HomePageTemplate(
      uiState: state.uiState,
      onPlayPressed:
          ref.read(homePageViewModelProvider.notifier).onPlayPressed,
    );
  }
}
