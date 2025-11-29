import 'dart:math';
import 'package:flutter/material.dart';

/// Shape types that can be recognized
enum ShapeType {
  line,
  circle,
  freeform,
}

/// Recognizes and normalizes hand-drawn shapes
class ShapeRecognizer {
  /// Recognize what shape the points represent
  static ShapeType recognizeShape(List<Offset> points) {
    if (points.length < 5) return ShapeType.freeform;

    // Check if it's a line first (simpler check)
    if (_isLine(points)) {
      return ShapeType.line;
    }

    // Check if it's a circle
    if (_isCircle(points)) {
      return ShapeType.circle;
    }

    return ShapeType.freeform;
  }

  /// Check if points form a line
  static bool _isLine(List<Offset> points) {
    if (points.length < 3) return true;

    final start = points.first;
    final end = points.last;

    // Calculate distance from each point to the line formed by start-end
    double totalDeviation = 0.0;
    for (final point in points) {
      final deviation = _pointToLineDistance(point, start, end);
      totalDeviation += deviation;
    }

    final avgDeviation = totalDeviation / points.length;

    // If average deviation is small, it's a line
    // Threshold: 0.02 (in normalized coordinates 0-1)
    return avgDeviation < 0.02;
  }

  /// Check if points form a circle
  static bool _isCircle(List<Offset> points) {
    if (points.length < 10) return false;

    // Find center point (average of all points)
    final center = _findCenter(points);

    // Calculate distances from center to each point
    final distances = points.map((p) => _distance(p, center)).toList();

    // Calculate average radius
    final avgRadius = distances.reduce((a, b) => a + b) / distances.length;

    // Calculate standard deviation of distances
    double variance = 0.0;
    for (final dist in distances) {
      variance += pow(dist - avgRadius, 2);
    }
    final stdDev = sqrt(variance / distances.length);

    // If standard deviation is small relative to radius, it's a circle
    // Also check if start and end points are close (closed shape)
    final startEndDistance = _distance(points.first, points.last);
    final isClosed = startEndDistance < avgRadius * 0.3;

    return (stdDev / avgRadius < 0.15) && isClosed;
  }

  /// Normalize points to a perfect line
  static List<Offset> normalizeToLine(List<Offset> points) {
    if (points.length < 2) return points;

    final start = points.first;
    final end = points.last;

    // Create a line with 20 evenly spaced points
    final normalizedPoints = <Offset>[];
    const numPoints = 20;

    for (int i = 0; i < numPoints; i++) {
      final t = i / (numPoints - 1);
      final x = start.dx + (end.dx - start.dx) * t;
      final y = start.dy + (end.dy - start.dy) * t;
      normalizedPoints.add(Offset(x, y));
    }

    return normalizedPoints;
  }

  /// Normalize points to a perfect circle
  static List<Offset> normalizeToCircle(List<Offset> points) {
    if (points.length < 3) return points;

    // Find center and average radius
    final center = _findCenter(points);
    final distances = points.map((p) => _distance(p, center)).toList();
    final avgRadius = distances.reduce((a, b) => a + b) / distances.length;

    // Create a perfect circle with 40 points
    final normalizedPoints = <Offset>[];
    const numPoints = 40;

    for (int i = 0; i < numPoints; i++) {
      final angle = (i / numPoints) * 2 * pi;
      final x = center.dx + avgRadius * cos(angle);
      final y = center.dy + avgRadius * sin(angle);
      normalizedPoints.add(Offset(x, y));
    }

    return normalizedPoints;
  }

  /// Calculate distance from point to line
  static double _pointToLineDistance(Offset point, Offset lineStart, Offset lineEnd) {
    final dx = lineEnd.dx - lineStart.dx;
    final dy = lineEnd.dy - lineStart.dy;

    // Handle case where start and end are the same
    if (dx == 0 && dy == 0) {
      return _distance(point, lineStart);
    }

    // Calculate perpendicular distance
    final numerator = ((point.dx - lineStart.dx) * dy - (point.dy - lineStart.dy) * dx).abs();
    final denominator = sqrt(dx * dx + dy * dy);

    return numerator / denominator;
  }

  /// Calculate distance between two points
  static double _distance(Offset a, Offset b) {
    final dx = a.dx - b.dx;
    final dy = a.dy - b.dy;
    return sqrt(dx * dx + dy * dy);
  }

  /// Find center point of all points
  static Offset _findCenter(List<Offset> points) {
    double sumX = 0.0;
    double sumY = 0.0;

    for (final point in points) {
      sumX += point.dx;
      sumY += point.dy;
    }

    return Offset(sumX / points.length, sumY / points.length);
  }
}
