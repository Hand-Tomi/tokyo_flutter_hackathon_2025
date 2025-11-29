import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hand_tracking_page_view_model.dart';
import '../image/image_analysis_page.dart';
import '../image/image_analysis_page_view_model.dart';

/// Hand Tracking Page
///
/// Presentation layer: routing, state watching, action handling
class HandTrackingPage extends ConsumerStatefulWidget {
  const HandTrackingPage({super.key});

  @override
  ConsumerState<HandTrackingPage> createState() => _HandTrackingPageState();
}

class _HandTrackingPageState extends ConsumerState<HandTrackingPage> {
  @override
  void initState() {
    super.initState();
    // Initialize camera and hand landmarker after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(handTrackingPageViewModelProvider.notifier).onInitialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(handTrackingPageViewModelProvider);
    final viewModel = ref.read(handTrackingPageViewModelProvider.notifier);

    // Watch for actions
    ref.listen(
      handTrackingPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          showConfirmDialog: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('그림 완성'),
                content: const Text('이대로 그림을 만들까요?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // Create image from drawing paths
                      final imageBytes = await viewModel.onCreateImage();
                      if (imageBytes != null && context.mounted) {
                        // Show image preview dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('생성된 이미지'),
                            content: SizedBox(
                              width: 300,
                              height: 300,
                              child: Image.memory(
                                imageBytes,
                                fit: BoxFit.contain,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('닫기'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();

                                  // 이미지 저장
                                  final saved = await viewModel.onSaveToGallery(imageBytes);

                                  if (saved && context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('저장되었습니다!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    // 이미지 분석 페이지의 ViewModel에 이미지 설정
                                    await ref
                                        .read(imageAnalysisPageViewModelProvider.notifier)
                                        .onSetImageFromBytes(imageBytes);

                                    // 이미지 분석 페이지로 이동
                                    if (context.mounted) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const ImageAnalysisPage(),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text('저장'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
            );
          },
        );

        viewModel.onFinishedAction();
      },
    );

    // Build camera preview widget
    Widget cameraPreview;
    final controller = viewModel.cameraController;
    if (controller != null && controller.value.isInitialized) {
      cameraPreview = CameraPreview(controller);
    } else {
      cameraPreview = const SizedBox.shrink();
    }

    return HandTrackingPageTemplate(
      uiState: state.uiState,
      cameraPreview: cameraPreview,
      onSettingsToggle: viewModel.onSettingsToggle,
      onFrameSkipChanged: viewModel.onFrameSkipChanged,
      onResolutionChanged: viewModel.onResolutionChanged,
      onClearDrawing: viewModel.onClearDrawing,
    );
  }
}
