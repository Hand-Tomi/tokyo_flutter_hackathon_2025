import 'package:flutter/material.dart';

import 'hand_tracking_ui_state.dart';

/// Settings panel for hand tracking performance configuration
class HandTrackingSettingsPanel extends StatelessWidget {
  const HandTrackingSettingsPanel({
    super.key,
    required this.frameSkip,
    required this.resolution,
    required this.onFrameSkipChanged,
    required this.onResolutionChanged,
  });

  final int frameSkip;
  final ResolutionPresetUi resolution;
  final ValueChanged<int> onFrameSkipChanged;
  final ValueChanged<ResolutionPresetUi> onResolutionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.amber.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Settings',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Frame skip slider
          Text(
            'Frame Skip: ${frameSkip}x (Process every $frameSkip frame${frameSkip > 1 ? 's' : ''})',
          ),
          Slider(
            value: frameSkip.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: '${frameSkip}x',
            onChanged: (value) => onFrameSkipChanged(value.toInt()),
          ),
          const SizedBox(height: 8),

          // Resolution selector
          const Text('Camera Resolution:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ResolutionPresetUi.values.map((preset) {
              return ChoiceChip(
                label: Text(preset.displayName),
                selected: resolution == preset,
                onSelected: (selected) {
                  if (selected) onResolutionChanged(preset);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
