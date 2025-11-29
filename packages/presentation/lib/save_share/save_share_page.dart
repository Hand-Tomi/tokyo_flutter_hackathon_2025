import 'package:design_system/save_share/save_share_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/save_share/save_share_page_view_model.dart';

/// 저장/공유 페이지
class SaveSharePage extends ConsumerWidget {
  const SaveSharePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(saveSharePageViewModelProvider);
    final notifier = ref.read(saveSharePageViewModelProvider.notifier);

    ref.listen(
      saveSharePageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          navigateToHome: () {
            context.go('/home');
          },
          showSaveSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Video saved to gallery!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          showShareSheet: () {
            // TODO: 실제 공유 시트 표시
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share feature coming soon!')),
            );
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

    return SaveShareTemplate(
      uiState: state.uiState,
      onBackPressed: () => context.pop(),
      onDownloadPressed: notifier.onDownloadPressed,
      onSharePressed: notifier.onSharePressed,
      onHomePressed: notifier.onHomePressed,
    );
  }
}
