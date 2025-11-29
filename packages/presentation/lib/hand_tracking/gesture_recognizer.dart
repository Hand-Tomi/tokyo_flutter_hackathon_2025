import 'package:hand_landmarker/hand_landmarker.dart';

/// Enum for rock-paper-scissors gestures
enum HandGesture {
  rock,
  paper,
  scissors,
  unknown;

  @override
  String toString() {
    switch (this) {
      case HandGesture.rock:
        return 'Rock';
      case HandGesture.paper:
        return 'Paper';
      case HandGesture.scissors:
        return 'Scissors';
      case HandGesture.unknown:
        return 'Unknown';
    }
  }
}

/// Utility class for hand gesture recognition
class GestureRecognizer {
  /// Count the number of extended fingers
  /// Returns a number between 0-5
  static int countExtendedFingers(List<Landmark> landmarks) {
    if (landmarks.length < 21) return 0;

    int count = 0;

    // Thumb: Compare tip (4) with MCP joint (2) on X-axis
    // Thumb is extended if tip is further from palm center
    final thumbTip = landmarks[4];
    final thumbMcp = landmarks[2];
    final wrist = landmarks[0];

    // Calculate if thumb is extended based on distance from wrist
    final thumbTipDist = _distance(thumbTip, wrist);
    final thumbMcpDist = _distance(thumbMcp, wrist);
    if (thumbTipDist > thumbMcpDist * 1.2) {
      count++;
    }

    // Other fingers: Compare tip with PIP joint on Y-axis
    // Finger is extended if tip is higher (smaller Y value) than PIP
    final fingerTips = [8, 12, 16, 20]; // Index, Middle, Ring, Pinky tips
    final fingerPips = [6, 10, 14, 18]; // Index, Middle, Ring, Pinky PIPs

    for (int i = 0; i < 4; i++) {
      final tipY = landmarks[fingerTips[i]].y;
      final pipY = landmarks[fingerPips[i]].y;

      // Tip should be above (lower Y value) PIP for extended finger
      if (tipY < pipY - 0.03) {
        count++;
      }
    }

    return count;
  }

  /// Detect rock-paper-scissors gesture
  static HandGesture detectRockPaperScissors(List<Landmark> landmarks) {
    if (landmarks.length < 21) return HandGesture.unknown;

    final extendedFingers = countExtendedFingers(landmarks);

    // Rock: 0 fingers extended (complete fist only)
    if (extendedFingers == 0) {
      return HandGesture.rock;
    }

    // Paper: 4-5 fingers extended (open hand)
    if (extendedFingers >= 4) {
      return HandGesture.paper;
    }

    // Scissors: 2 fingers extended
    // Check if index and middle fingers are extended
    if (extendedFingers == 2) {
      final indexTip = landmarks[8];
      final indexPip = landmarks[6];
      final middleTip = landmarks[12];
      final middlePip = landmarks[10];

      final indexExtended = indexTip.y < indexPip.y - 0.03;
      final middleExtended = middleTip.y < middlePip.y - 0.03;

      if (indexExtended && middleExtended) {
        return HandGesture.scissors;
      }
    }

    return HandGesture.unknown;
  }

  /// Check if hand is making a thumbs up gesture
  static bool isThumbsUp(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    // Thumb should be extended upward
    final thumbTip = landmarks[4];
    final thumbMcp = landmarks[2];

    // Thumb tip should be above thumb MCP
    final thumbExtended = thumbTip.y < thumbMcp.y;

    // Other fingers should be curled (not extended)
    final fingerTips = [8, 12, 16, 20];
    final fingerPips = [6, 10, 14, 18];

    int curledFingers = 0;
    for (int i = 0; i < 4; i++) {
      if (landmarks[fingerTips[i]].y >= landmarks[fingerPips[i]].y) {
        curledFingers++;
      }
    }

    return thumbExtended && curledFingers >= 3;
  }

  /// Check if hand is making a peace sign (V gesture)
  static bool isPeaceSign(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    final extendedFingers = countExtendedFingers(landmarks);

    if (extendedFingers != 2) return false;

    // Check if index and middle fingers are extended
    final indexTip = landmarks[8];
    final indexPip = landmarks[6];
    final middleTip = landmarks[12];
    final middlePip = landmarks[10];

    final indexExtended = indexTip.y < indexPip.y - 0.03;
    final middleExtended = middleTip.y < middlePip.y - 0.03;

    // Check if ring and pinky are curled
    final ringTip = landmarks[16];
    final ringPip = landmarks[14];
    final pinkyTip = landmarks[20];
    final pinkyPip = landmarks[18];

    final ringCurled = ringTip.y >= ringPip.y;
    final pinkyCurled = pinkyTip.y >= pinkyPip.y;

    return indexExtended && middleExtended && ringCurled && pinkyCurled;
  }

  /// Calculate Euclidean distance between two landmarks
  static double _distance(Landmark a, Landmark b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    final dz = a.z - b.z;
    return dx * dx + dy * dy + dz * dz; // No sqrt needed for comparison
  }

  /// Check if hand is in drawing mode (pointing finger - only index extended)
  static bool isDrawingGesture(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    // Index finger should be extended
    final indexTip = landmarks[8];
    final indexPip = landmarks[6];
    final indexExtended = indexTip.y < indexPip.y - 0.03;

    if (!indexExtended) return false;

    // Other fingers (middle, ring, pinky) should be curled
    final middleTip = landmarks[12];
    final middlePip = landmarks[10];
    final ringTip = landmarks[16];
    final ringPip = landmarks[14];
    final pinkyTip = landmarks[20];
    final pinkyPip = landmarks[18];

    final middleCurled = middleTip.y >= middlePip.y - 0.02;
    final ringCurled = ringTip.y >= ringPip.y - 0.02;
    final pinkyCurled = pinkyTip.y >= pinkyPip.y - 0.02;

    // At least 2 of 3 fingers should be curled for drawing gesture
    final curledCount =
        (middleCurled ? 1 : 0) + (ringCurled ? 1 : 0) + (pinkyCurled ? 1 : 0);
    return curledCount >= 2;
  }

  /// Get the index finger tip position (landmark 8)
  static ({double x, double y, double z})? getIndexFingerTip(
      List<Landmark> landmarks) {
    if (landmarks.length < 21) return null;
    final tip = landmarks[8];
    return (x: tip.x, y: tip.y, z: tip.z);
  }

  /// Get a human-readable description of the hand state
  static String getHandDescription(List<Landmark> landmarks) {
    if (landmarks.isEmpty) return 'No hand detected';

    final fingerCount = countExtendedFingers(landmarks);
    final drawing = isDrawingGesture(landmarks);
    final gesture = detectRockPaperScissors(landmarks);
    final thumbsUp = isThumbsUp(landmarks);
    final peace = isPeaceSign(landmarks);

    final parts = <String>[];
    parts.add('$fingerCount finger${fingerCount != 1 ? 's' : ''} extended');

    // Check drawing gesture FIRST before other gestures
    if (drawing) {
      parts.add('Drawing Gesture');
    } else if (gesture != HandGesture.unknown) {
      parts.add(gesture.toString());
    } else if (thumbsUp) {
      parts.add('Thumbs Up');
    } else if (peace) {
      parts.add('Peace Sign');
    }

    return parts.join(' - ');
  }
}
