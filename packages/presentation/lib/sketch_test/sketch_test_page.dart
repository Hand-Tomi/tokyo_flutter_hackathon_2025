import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sketch_test_page_view_model.dart';

/// 스케치 테스트 페이지
///
/// 스케치 이미지 + 텍스트 → 동화풍 이미지 변환 테스트
class SketchTestPage extends ConsumerWidget {
  const SketchTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(sketchTestPageViewModelProvider);
    final viewModel = ref.read(sketchTestPageViewModelProvider.notifier);

    // 액션 리스너
    ref.listen(sketchTestPageViewModelProvider, (previous, current) {
      current.action.when(
        none: () {},
        showError: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ),
          );
          viewModel.onFinishedAction();
        },
        showSuccess: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
            ),
          );
          viewModel.onFinishedAction();
        },
      );
    });

    return SketchTestPageTemplate(
      uiState: pageState.uiState,
      onPickImage: viewModel.onPickImage,
      onStoryTextChanged: viewModel.onStoryTextChanged,
      onGenerate: viewModel.onGenerate,
      onClear: viewModel.onClear,
    );
  }
}
