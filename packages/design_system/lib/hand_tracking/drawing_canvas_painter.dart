import 'dart:ui';

import 'package:flutter/material.dart';

import 'hand_tracking_ui_state.dart';

/// CustomPainter to draw finger-traced sketches
class DrawingCanvasPainter extends CustomPainter {
  final List<DrawingPathUi> paths;
  final List<Offset> currentPath;
  final bool isDrawing;
  final Color currentColor;
  final double currentStrokeWidth;

  DrawingCanvasPainter({
    required this.paths,
    required this.currentPath,
    this.isDrawing = false,
    this.currentColor = Colors.black,
    this.currentStrokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw completed paths
    for (final path in paths) {
      if (path.points.length < 2) continue;

      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final drawPath = Path();
      final firstPoint = _scalePoint(path.points.first, size);
      drawPath.moveTo(firstPoint.dx, firstPoint.dy);

      // Use quadratic bezier curves for smooth lines
      for (int i = 1; i < path.points.length - 1; i++) {
        final p0 = _scalePoint(path.points[i], size);
        final p1 = _scalePoint(path.points[i + 1], size);
        final midPoint = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
        drawPath.quadraticBezierTo(p0.dx, p0.dy, midPoint.dx, midPoint.dy);
      }

      // Add the last point
      if (path.points.length > 1) {
        final lastPoint = _scalePoint(path.points.last, size);
        drawPath.lineTo(lastPoint.dx, lastPoint.dy);
      }

      canvas.drawPath(drawPath, paint);
    }

    // Draw current path (being drawn now)
    if (currentPath.length >= 2) {
      final paint = Paint()
        ..color = currentColor
        ..strokeWidth = currentStrokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final drawPath = Path();
      final firstPoint = _scalePoint(currentPath.first, size);
      drawPath.moveTo(firstPoint.dx, firstPoint.dy);

      for (int i = 1; i < currentPath.length - 1; i++) {
        final p0 = _scalePoint(currentPath[i], size);
        final p1 = _scalePoint(currentPath[i + 1], size);
        final midPoint = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
        drawPath.quadraticBezierTo(p0.dx, p0.dy, midPoint.dx, midPoint.dy);
      }

      if (currentPath.length > 1) {
        final lastPoint = _scalePoint(currentPath.last, size);
        drawPath.lineTo(lastPoint.dx, lastPoint.dy);
      }

      canvas.drawPath(drawPath, paint);

      // Draw a small indicator at the current drawing position
      if (isDrawing && currentPath.isNotEmpty) {
        final tipPoint = _scalePoint(currentPath.last, size);
        final indicatorPaint = Paint()
          ..color = Colors.blue.withValues(alpha: 0.6)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(tipPoint, 8, indicatorPaint);

        final outlinePaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(tipPoint, 8, outlinePaint);
      }
    }
  }

  /// Scale normalized coordinates (0-1) to screen size
  Offset _scalePoint(Offset point, Size size) {
    return Offset(point.dx * size.width, point.dy * size.height);
  }

  @override
  bool shouldRepaint(DrawingCanvasPainter oldDelegate) {
    return paths != oldDelegate.paths ||
        currentPath != oldDelegate.currentPath ||
        isDrawing != oldDelegate.isDrawing;
  }
}
