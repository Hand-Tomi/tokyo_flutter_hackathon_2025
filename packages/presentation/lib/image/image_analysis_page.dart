import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/design_system.dart';
import 'image_analysis_page_view_model.dart';

class ImageAnalysisPage extends ConsumerWidget {
  const ImageAnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageAnalysisPageViewModelProvider);

    // 액션 감시 (일회성 이벤트 처리)
    ref.listen(
      imageAnalysisPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          pickImage: () {
            // 이미지 선택은 ViewModel에서 처리
          },
          showAnalysisResult: (analysis) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('분석 완료: ${analysis.sceneType}'),
                backgroundColor: Colors.green,
              ),
            );
          },
          showGeneratedImage: (image) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('이미지 생성 완료!'),
                backgroundColor: Colors.purple,
              ),
            );
          },
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
        );

        // 액션 처리 후 리셋
        ref
            .read(imageAnalysisPageViewModelProvider.notifier)
            .onFinishedAction();
      },
    );

    // Template에 데이터와 콜백 전달
    return ImageAnalysisPageTemplate(
      uiState: state.uiState,
      onPickImage: () => ref
          .read(imageAnalysisPageViewModelProvider.notifier)
          .onPickImagePressed(),
      onAnalyzeImage: () => ref
          .read(imageAnalysisPageViewModelProvider.notifier)
          .onAnalyzeImagePressed(),
      onGenerateImage: () => ref
          .read(imageAnalysisPageViewModelProvider.notifier)
          .onGenerateImagePressed(),
    );
  }
}
