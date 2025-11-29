import 'package:flutter/material.dart';

import 'drawing_canvas_painter.dart';
import 'hand_tracking_ui_state.dart';

/// Hand Tracking Page Template
/// Pure UI layout without state management - Minimal version
class HandTrackingPageTemplate extends StatelessWidget {
  const HandTrackingPageTemplate({
    super.key,
    required this.uiState,
    required this.cameraPreview,
    required this.onSettingsToggle,
    required this.onFrameSkipChanged,
    required this.onResolutionChanged,
    this.onClearDrawing,
  });

  final HandTrackingPageUiState uiState;
  final Widget cameraPreview;
  final VoidCallback onSettingsToggle;
  final ValueChanged<int> onFrameSkipChanged;
  final ValueChanged<ResolutionPresetUi> onResolutionChanged;
  final VoidCallback? onClearDrawing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: uiState.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                // Camera view (full screen)
                cameraPreview,
                // Drawing canvas overlay
                CustomPaint(
                  painter: DrawingCanvasPainter(
                    paths: uiState.drawingPaths,
                    currentPath: uiState.currentPath,
                    isDrawing: uiState.isFingerDown,
                  ),
                ),
                // Clear button (always show)
                Positioned(
                  bottom: 80,
                  right: 16,
                  child: FloatingActionButton.small(
                    onPressed: onClearDrawing,
                    backgroundColor: Colors.red.withValues(alpha: 0.8),
                    child: const Icon(Icons.clear, color: Colors.white),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
