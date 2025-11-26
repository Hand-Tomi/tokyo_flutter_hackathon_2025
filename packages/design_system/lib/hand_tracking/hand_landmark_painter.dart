import 'package:flutter/material.dart';

import 'hand_tracking_ui_state.dart';

/// CustomPainter to draw hand landmarks on camera preview
class HandLandmarkPainter extends CustomPainter {
  final List<HandLandmarkUi> hands;
  final Size imageSize;
  final int sensorOrientation;

  HandLandmarkPainter(this.hands, this.imageSize, this.sensorOrientation);

  /// MediaPipe hand landmark connection structure
  static const List<List<int>> connections = [
    // From wrist to each finger
    [0, 1], [1, 2], [2, 3], [3, 4], // Thumb
    [0, 5], [5, 6], [6, 7], [7, 8], // Index
    [0, 9], [9, 10], [10, 11], [11, 12], // Middle
    [0, 13], [13, 14], [14, 15], [15, 16], // Ring
    [0, 17], [17, 18], [18, 19], [19, 20], // Pinky
    // Palm connections
    [5, 9], [9, 13], [13, 17], [0, 17],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (hands.isEmpty) return;

    final pointPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final hand in hands) {
      final landmarks = hand.points;

      // Draw connection lines
      for (final connection in connections) {
        final start = landmarks[connection[0]];
        final end = landmarks[connection[1]];

        final p1 = _transformPoint(start.x, start.y, size);
        final p2 = _transformPoint(end.x, end.y, size);

        canvas.drawLine(p1, p2, linePaint);
      }

      // Draw landmark points
      for (final landmark in landmarks) {
        final point = _transformPoint(landmark.x, landmark.y, size);
        canvas.drawCircle(point, 6, pointPaint);
      }
    }
  }

  Offset _transformPoint(double x, double y, Size size) {
    // Transform coordinates based on sensor orientation
    double transformedX, transformedY;

    if (sensorOrientation == 90) {
      // 90 degree rotation: (x, y) -> (1-y, x)
      transformedX = 1 - y;
      transformedY = x;
    } else if (sensorOrientation == 270) {
      // 270 degree rotation: (x, y) -> (y, 1-x)
      transformedX = y;
      transformedY = 1 - x;
    } else if (sensorOrientation == 180) {
      // 180 degree rotation: (x, y) -> (1-x, 1-y)
      transformedX = 1 - x;
      transformedY = 1 - y;
    } else {
      // 0 degree (no rotation)
      transformedX = x;
      transformedY = y;
    }

    // Scale to screen size
    final dx = transformedX * size.width;
    final dy = transformedY * size.height;

    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(HandLandmarkPainter oldDelegate) {
    return true;
  }
}
