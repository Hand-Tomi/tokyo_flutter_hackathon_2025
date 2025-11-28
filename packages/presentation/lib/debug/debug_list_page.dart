import 'package:design_system/debug/debug_list_template.dart';
import 'package:design_system/debug/debug_list_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/debug/debug_list_page_view_model.dart';

/// 디버그 리스트 페이지
///
/// Presentation 계층: 라우팅, 상태 감시, 액션 처리를 담당
class DebugListPage extends ConsumerWidget {
  const DebugListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(debugListPageViewModelProvider);

    // 액션 감시
    ref.listen(
      debugListPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToTodoList: () {
            context.push('/todo');
          },
          navigateToHandTracking: () {
            context.push('/hand-tracking');
          },
          navigateToVoiceChat: () {
            context.push('/voice-chat');
          },
        );

        ref.read(debugListPageViewModelProvider.notifier).onFinishedAction();
      },
    );

    // Template에 데이터와 콜백을 전달
    return DebugListPageTemplate(
      uiState: state.uiState,
    );
  }
}
