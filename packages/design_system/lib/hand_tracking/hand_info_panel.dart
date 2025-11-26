import 'package:flutter/material.dart';

import 'hand_tracking_ui_state.dart';

/// Bottom panel showing detected hand information and gestures
class HandInfoPanel extends StatelessWidget {
  const HandInfoPanel({
    super.key,
    required this.landmarks,
    required this.frameSkip,
    required this.gestureInfo,
  });

  final List<HandLandmarkUi> landmarks;
  final int frameSkip;
  final String gestureInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detected hands: ${landmarks.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FPS: ~${(60 / frameSkip).toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Gesture information
          if (gestureInfo.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.gesture, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      gestureInfo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 8),

          // Hand details
          if (landmarks.isNotEmpty) ...[
            for (var i = 0; i < landmarks.length; i++)
              Text(
                'Hand ${i + 1}: ${landmarks[i].points.length} landmarks',
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ],
      ),
    );
  }
}
