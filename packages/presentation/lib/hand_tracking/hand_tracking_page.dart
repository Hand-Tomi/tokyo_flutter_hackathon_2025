import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hand_tracking_page_view_model.dart';

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
    );
  }
}
