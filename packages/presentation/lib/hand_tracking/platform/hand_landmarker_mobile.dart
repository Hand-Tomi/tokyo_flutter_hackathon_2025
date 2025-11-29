// Re-export hand_landmarker for mobile platforms
export 'package:hand_landmarker/hand_landmarker.dart';

/// Extension to add isSupported check
extension HandLandmarkerSupportExtension on Type {
  static bool get isSupported => true;
}

/// Helper to check platform support
bool get handLandmarkerIsSupported => true;
