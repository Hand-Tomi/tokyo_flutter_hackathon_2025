import 'package:flutter/material.dart';

import 'hand_info_panel.dart';
import 'hand_landmark_painter.dart';
import 'hand_tracking_settings_panel.dart';
import 'hand_tracking_ui_state.dart';

/// Hand Tracking Page Template
/// Pure UI layout without state management
class HandTrackingPageTemplate extends StatelessWidget {
  const HandTrackingPageTemplate({
    super.key,
    required this.uiState,
    required this.cameraPreview,
    required this.onSettingsToggle,
    required this.onFrameSkipChanged,
    required this.onResolutionChanged,
  });

  final HandTrackingPageUiState uiState;
  final Widget cameraPreview;
  final VoidCallback onSettingsToggle;
  final ValueChanged<int> onFrameSkipChanged;
  final ValueChanged<ResolutionPresetUi> onResolutionChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Tracking Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(uiState.showSettings ? Icons.close : Icons.settings),
            onPressed: onSettingsToggle,
          ),
        ],
      ),
      body: Column(
        children: [
          // Status message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade100,
            child: Text(
              uiState.statusMessage,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          // Performance settings panel (collapsible)
          if (uiState.showSettings)
            HandTrackingSettingsPanel(
              frameSkip: uiState.frameSkip,
              resolution: uiState.resolution,
              onFrameSkipChanged: onFrameSkipChanged,
              onResolutionChanged: onResolutionChanged,
            ),

          // Camera preview
          Expanded(
            child: uiState.isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      // Camera view (fill screen)
                      cameraPreview,
                      // Landmark overlay (full screen)
                      if (uiState.previewSize != null &&
                          uiState.sensorOrientation != null)
                        CustomPaint(
                          painter: HandLandmarkPainter(
                            uiState.landmarks,
                            uiState.previewSize!,
                            uiState.sensorOrientation!,
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),

          // Detected hand information with gesture recognition
          HandInfoPanel(
            landmarks: uiState.landmarks,
            frameSkip: uiState.frameSkip,
            gestureInfo: uiState.gestureInfo,
          ),
        ],
      ),
    );
  }
}
