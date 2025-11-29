// Stub implementation for web platform
// These types mirror hand_landmarker package but do nothing on web

import 'package:camera/camera.dart';

/// Stub for HandLandmarkerDelegate
enum HandLandmarkerDelegate { CPU, GPU }

/// Stub for Landmark
class Landmark {
  const Landmark({
    required this.x,
    required this.y,
    required this.z,
  });

  final double x;
  final double y;
  final double z;
}

/// Stub for Hand
class Hand {
  const Hand({required this.landmarks});

  final List<Landmark> landmarks;
}

/// Stub for HandLandmarkerPlugin
class HandLandmarkerPlugin {
  HandLandmarkerPlugin._();

  /// Check if hand landmarker is supported on current platform
  static bool get isSupported => false;

  /// Create plugin (returns dummy on web)
  static HandLandmarkerPlugin create({
    int numHands = 2,
    double minHandDetectionConfidence = 0.5,
    HandLandmarkerDelegate delegate = HandLandmarkerDelegate.CPU,
  }) {
    return HandLandmarkerPlugin._();
  }

  /// Detect hands (always returns empty on web)
  List<Hand> detect(CameraImage image, int sensorOrientation) {
    return [];
  }
}
