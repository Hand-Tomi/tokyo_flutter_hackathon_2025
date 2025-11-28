import 'dart:math' as math;

import 'package:hand_landmarker/hand_landmarker.dart';

/// Enum for hand gestures
enum HandGesture {
  rock,
  paper,
  scissors,
  thumbsUp,
  thumbsDown,
  peace,
  pointing,
  openPalm,
  fist,
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
      case HandGesture.thumbsUp:
        return 'Thumbs Up';
      case HandGesture.thumbsDown:
        return 'Thumbs Down';
      case HandGesture.peace:
        return 'Peace';
      case HandGesture.pointing:
        return 'Pointing';
      case HandGesture.openPalm:
        return 'Open Palm';
      case HandGesture.fist:
        return 'Fist';
      case HandGesture.unknown:
        return 'Unknown';
    }
  }
}

/// Enum for hand orientation
enum HandOrientation {
  up,
  down,
  left,
  right,
  forward,
  backward,
  unknown;

  @override
  String toString() {
    switch (this) {
      case HandOrientation.up:
        return 'Up';
      case HandOrientation.down:
        return 'Down';
      case HandOrientation.left:
        return 'Left';
      case HandOrientation.right:
        return 'Right';
      case HandOrientation.forward:
        return 'Forward';
      case HandOrientation.backward:
        return 'Backward';
      case HandOrientation.unknown:
        return 'Unknown';
    }
  }
}

/// Individual finger state
class FingerState {
  final bool thumb;
  final bool index;
  final bool middle;
  final bool ring;
  final bool pinky;

  const FingerState({
    required this.thumb,
    required this.index,
    required this.middle,
    required this.ring,
    required this.pinky,
  });

  /// Get a human-readable description of which fingers are extended
  String get description {
    final extended = <String>[];
    if (thumb) extended.add('엄지');
    if (index) extended.add('검지');
    if (middle) extended.add('중지');
    if (ring) extended.add('약지');
    if (pinky) extended.add('새끼');

    if (extended.isEmpty) return '모든 손가락 접힘';
    if (extended.length == 5) return '모든 손가락 폄';
    return '${extended.join(', ')} 폄';
  }

  /// Get count of extended fingers
  int get count {
    int c = 0;
    if (thumb) c++;
    if (index) c++;
    if (middle) c++;
    if (ring) c++;
    if (pinky) c++;
    return c;
  }
}

/// Result of gesture detection with confidence score and orientation
class GestureResult {
  final HandGesture gesture;
  final double confidence;
  final int extendedFingerCount;
  final HandOrientation orientation;
  final FingerState fingerState;
  final String handedness; // 'Left' or 'Right' or 'Unknown'

  const GestureResult({
    required this.gesture,
    required this.confidence,
    required this.extendedFingerCount,
    this.orientation = HandOrientation.unknown,
    required this.fingerState,
    this.handedness = 'Unknown',
  });

  /// Get a human-readable description combining gesture and orientation
  String get description {
    if (gesture == HandGesture.unknown) return 'Unknown';
    if (orientation == HandOrientation.unknown) return gesture.toString();
    return '${gesture.toString()} ${orientation.toString()}';
  }

  /// Get detailed description with handedness and finger states
  String get detailedDescription {
    final hand = handedness != 'Unknown' ? '$handedness손' : '손';
    return '$hand: ${fingerState.description}';
  }
}

/// Utility class for hand gesture recognition with improved accuracy
class GestureRecognizer {
  // Confidence thresholds
  static const double _minConfidence = 0.7;
  static const double _fingerExtensionAngleThreshold = 150.0; // degrees

  /// Calculate normalized hand scale (wrist to middle finger tip distance)
  /// This helps make detection independent of hand distance from camera
  static double _calculateHandScale(List<Landmark> landmarks) {
    final wrist = landmarks[0];
    final middleTip = landmarks[12];
    return _distance(wrist, middleTip);
  }

  /// Calculate the angle between three points (in degrees)
  /// Returns the angle at point B in the triangle ABC
  static double _calculateAngle(Landmark a, Landmark b, Landmark c) {
    // Create vectors BA and BC
    final ba = _Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
    final bc = _Vector3(c.x - b.x, c.y - b.y, c.z - b.z);

    // Calculate dot product and magnitudes
    final dot = ba.dot(bc);
    final magBA = ba.magnitude;
    final magBC = bc.magnitude;

    if (magBA == 0 || magBC == 0) return 0;

    // Calculate angle using dot product formula
    final cosAngle = dot / (magBA * magBC);
    final angleRad = math.acos(cosAngle.clamp(-1.0, 1.0));
    return angleRad * 180 / math.pi; // Convert to degrees
  }

  /// Check if a finger is extended using angle-based detection
  /// More robust than simple Y-coordinate comparison
  static bool _isFingerExtended(
    List<Landmark> landmarks,
    int mcp,
    int pip,
    int dip,
    int tip,
  ) {
    // Calculate angles at each joint
    final pipAngle = _calculateAngle(landmarks[mcp], landmarks[pip], landmarks[dip]);
    final dipAngle = _calculateAngle(landmarks[pip], landmarks[dip], landmarks[tip]);

    // Also check if fingertip is farther from wrist than MCP (finger pointing outward)
    final wrist = landmarks[0];
    final tipDist = _distance(landmarks[tip], wrist);
    final mcpDist = _distance(landmarks[mcp], wrist);
    final isTipFartherThanMcp = tipDist > mcpDist * 0.9;

    // Finger is extended if joints are relatively straight AND tip is far from wrist
    return pipAngle >= _fingerExtensionAngleThreshold &&
        dipAngle >= _fingerExtensionAngleThreshold &&
        isTipFartherThanMcp;
  }

  /// Check if thumb is extended (special case due to different orientation)
  /// Uses multiple criteria: joint angles, distance from palm, and position relative to index finger
  static bool _isThumbExtended(List<Landmark> landmarks) {
    final wrist = landmarks[0];
    final thumbCMC = landmarks[1];
    final thumbMCP = landmarks[2];
    final thumbIP = landmarks[3];
    final thumbTip = landmarks[4];
    final indexMCP = landmarks[5]; // Index finger MCP for reference
    final middleMCP = landmarks[9]; // Middle finger MCP (palm center reference)

    // Check thumb joint angles
    final mcpAngle = _calculateAngle(thumbCMC, thumbMCP, thumbIP);
    final ipAngle = _calculateAngle(thumbMCP, thumbIP, thumbTip);

    // Thumb is extended if joints are relatively straight
    final jointsAreStraight = mcpAngle >= 140 && ipAngle >= 150;

    // Check if thumb tip is far from palm center (middle MCP)
    final thumbTipToMiddleMcp = _distance(thumbTip, middleMCP);
    final thumbMcpToMiddleMcp = _distance(thumbMCP, middleMCP);
    final isFarFromPalm = thumbTipToMiddleMcp > thumbMcpToMiddleMcp * 1.2;

    // Check if thumb tip is away from index finger (not curled inward)
    final thumbTipToIndexMcp = _distance(thumbTip, indexMCP);
    final thumbMcpToIndexMcp = _distance(thumbMCP, indexMCP);
    final isAwayFromIndex = thumbTipToIndexMcp > thumbMcpToIndexMcp * 0.8;

    // Check overall distance from wrist
    final thumbTipDist = _distance(thumbTip, wrist);
    final thumbMcpDist = _distance(thumbMCP, wrist);
    final isTipFartherThanMcp = thumbTipDist > thumbMcpDist * 1.1;

    // Thumb is extended only if multiple conditions are met
    return jointsAreStraight && isFarFromPalm && isAwayFromIndex && isTipFartherThanMcp;
  }

  /// Get detailed state of each finger
  static FingerState getFingerState(List<Landmark> landmarks) {
    if (landmarks.length < 21) {
      return const FingerState(
        thumb: false,
        index: false,
        middle: false,
        ring: false,
        pinky: false,
      );
    }

    return FingerState(
      thumb: _isThumbExtended(landmarks),
      index: _isFingerExtended(landmarks, 5, 6, 7, 8),
      middle: _isFingerExtended(landmarks, 9, 10, 11, 12),
      ring: _isFingerExtended(landmarks, 13, 14, 15, 16),
      pinky: _isFingerExtended(landmarks, 17, 18, 19, 20),
    );
  }

  /// Count the number of extended fingers with improved accuracy
  /// Returns a number between 0-5
  static int countExtendedFingers(List<Landmark> landmarks) {
    if (landmarks.length < 21) return 0;
    return getFingerState(landmarks).count;
  }

  /// Detect rock-paper-scissors gesture with confidence score
  static GestureResult detectRockPaperScissorsWithConfidence(List<Landmark> landmarks) {
    final fingerState = getFingerState(landmarks);

    if (landmarks.length < 21) {
      return GestureResult(
        gesture: HandGesture.unknown,
        confidence: 0.0,
        extendedFingerCount: 0,
        fingerState: fingerState,
      );
    }

    final extendedFingers = fingerState.count;
    final handScale = _calculateHandScale(landmarks);

    // Calculate confidence based on hand scale (better when hand is closer)
    final scaleConfidence = (handScale * 3).clamp(0.0, 1.0);

    // Rock: 0-1 fingers extended (fist)
    if (extendedFingers <= 1) {
      final confidence = scaleConfidence * (extendedFingers == 0 ? 1.0 : 0.85);
      return GestureResult(
        gesture: HandGesture.rock,
        confidence: confidence,
        extendedFingerCount: extendedFingers,
        fingerState: fingerState,
      );
    }

    // Paper: 4-5 fingers extended (open hand)
    if (extendedFingers >= 4) {
      final confidence = scaleConfidence * (extendedFingers == 5 ? 1.0 : 0.9);
      return GestureResult(
        gesture: HandGesture.paper,
        confidence: confidence,
        extendedFingerCount: extendedFingers,
        fingerState: fingerState,
      );
    }

    // Scissors: 2 fingers extended (index and middle)
    if (extendedFingers == 2) {
      if (fingerState.index && fingerState.middle) {
        return GestureResult(
          gesture: HandGesture.scissors,
          confidence: scaleConfidence * 0.95,
          extendedFingerCount: extendedFingers,
          fingerState: fingerState,
        );
      }
    }

    return GestureResult(
      gesture: HandGesture.unknown,
      confidence: 0.0,
      extendedFingerCount: extendedFingers,
      fingerState: fingerState,
    );
  }

  /// Detect rock-paper-scissors gesture (legacy method for compatibility)
  static HandGesture detectRockPaperScissors(List<Landmark> landmarks) {
    final result = detectRockPaperScissorsWithConfidence(landmarks);
    return result.confidence >= _minConfidence ? result.gesture : HandGesture.unknown;
  }

  /// Check if hand is making a thumbs up gesture
  static bool isThumbsUp(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    // Thumb should be extended
    final thumbExtended = _isThumbExtended(landmarks);
    if (!thumbExtended) return false;

    // Thumb tip should be above thumb MCP (pointing upward)
    final thumbTip = landmarks[4];
    final thumbMcp = landmarks[2];
    final thumbUpward = thumbTip.y < thumbMcp.y - 0.05;

    // Other fingers should be curled (not extended)
    int curledFingers = 0;
    final fingers = [
      [5, 6, 7, 8], // Index
      [9, 10, 11, 12], // Middle
      [13, 14, 15, 16], // Ring
      [17, 18, 19, 20], // Pinky
    ];

    for (final finger in fingers) {
      if (!_isFingerExtended(landmarks, finger[0], finger[1], finger[2], finger[3])) {
        curledFingers++;
      }
    }

    return thumbUpward && curledFingers >= 3;
  }

  /// Check if hand is making a peace sign (V gesture)
  static bool isPeaceSign(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    final extendedFingers = countExtendedFingers(landmarks);
    if (extendedFingers != 2) return false;

    // Check if index and middle fingers are extended
    final indexExtended = _isFingerExtended(landmarks, 5, 6, 7, 8);
    final middleExtended = _isFingerExtended(landmarks, 9, 10, 11, 12);

    // Check if ring and pinky are curled
    final ringExtended = _isFingerExtended(landmarks, 13, 14, 15, 16);
    final pinkyExtended = _isFingerExtended(landmarks, 17, 18, 19, 20);

    return indexExtended && middleExtended && !ringExtended && !pinkyExtended;
  }

  /// Check if hand is making a thumbs down gesture
  /// Uses specialized detection for downward-pointing thumb
  static bool isThumbsDown(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    final wrist = landmarks[0];
    final thumbCMC = landmarks[1];
    final thumbMCP = landmarks[2];
    final thumbIP = landmarks[3];
    final thumbTip = landmarks[4];
    final middleMCP = landmarks[9];

    // 1. Thumb tip should be BELOW thumb MCP (pointing downward in image coords)
    // Y increases downward, so thumbTip.y > thumbMCP.y means pointing down
    final thumbPointingDown = thumbTip.y > thumbMCP.y + 0.03;

    // 2. Thumb tip should be below or near wrist level (really pointing down)
    final thumbBelowWrist = thumbTip.y > wrist.y - 0.05;

    // 3. Check thumb is extended outward (not curled into palm)
    // Thumb tip should be away from middle finger MCP (palm center)
    final thumbTipToMiddleMCP = _distance(thumbTip, middleMCP);
    final thumbMCPToMiddleMCP = _distance(thumbMCP, middleMCP);
    final thumbExtendedOutward = thumbTipToMiddleMCP > thumbMCPToMiddleMCP * 0.7;

    // 4. Check thumb joints are reasonably straight (not fully curled)
    final mcpAngle = _calculateAngle(thumbCMC, thumbMCP, thumbIP);
    final ipAngle = _calculateAngle(thumbMCP, thumbIP, thumbTip);
    final thumbJointsStraight = mcpAngle >= 120 && ipAngle >= 130; // More relaxed than thumbs up

    // 5. Other fingers should be curled (not extended)
    int curledFingers = 0;
    final fingers = [
      [5, 6, 7, 8], // Index
      [9, 10, 11, 12], // Middle
      [13, 14, 15, 16], // Ring
      [17, 18, 19, 20], // Pinky
    ];

    for (final finger in fingers) {
      if (!_isFingerExtended(landmarks, finger[0], finger[1], finger[2], finger[3])) {
        curledFingers++;
      }
    }

    final fingersCurled = curledFingers >= 3;

    // All conditions must be met
    return thumbPointingDown && thumbBelowWrist && thumbExtendedOutward &&
           thumbJointsStraight && fingersCurled;
  }

  /// Check if hand is pointing (only index finger extended)
  static bool isPointing(List<Landmark> landmarks) {
    if (landmarks.length < 21) return false;

    // Only index finger should be extended
    final indexExtended = _isFingerExtended(landmarks, 5, 6, 7, 8);
    final middleExtended = _isFingerExtended(landmarks, 9, 10, 11, 12);
    final ringExtended = _isFingerExtended(landmarks, 13, 14, 15, 16);
    final pinkyExtended = _isFingerExtended(landmarks, 17, 18, 19, 20);
    final thumbExtended = _isThumbExtended(landmarks);

    return indexExtended && !middleExtended && !ringExtended && !pinkyExtended && !thumbExtended;
  }

  /// Detect if hand is left or right based on thumb position
  /// Returns 'Left' or 'Right' based on screen view
  /// sensorOrientation: Camera sensor orientation for coordinate transformation
  static String detectHandedness(List<Landmark> landmarks, {int sensorOrientation = 90}) {
    if (landmarks.length < 21) return 'Unknown';

    // Get thumb tip and pinky MCP for more stable comparison
    final thumbTip = landmarks[4];
    final pinkyMCP = landmarks[17];

    // Transform coordinates based on sensor orientation to match screen view
    double thumbX, pinkyX;
    if (sensorOrientation == 90) {
      // 90 degree: x -> -y (use 1-y for normalized coords)
      thumbX = 1 - thumbTip.y;
      pinkyX = 1 - pinkyMCP.y;
    } else if (sensorOrientation == 270) {
      // 270 degree: x -> y
      thumbX = thumbTip.y;
      pinkyX = pinkyMCP.y;
    } else if (sensorOrientation == 180) {
      // 180 degree: x -> 1-x
      thumbX = 1 - thumbTip.x;
      pinkyX = 1 - pinkyMCP.x;
    } else {
      // 0 degree: no change
      thumbX = thumbTip.x;
      pinkyX = pinkyMCP.x;
    }

    // In screen view after transformation:
    // - If thumb is to the LEFT of pinky, viewing palm = LEFT hand
    // - If thumb is to the RIGHT of pinky, viewing palm = RIGHT hand
    // (This assumes we're viewing the palm side of the hand)

    // If thumb is on left side of other fingers in screen view
    if (thumbX < pinkyX) {
      return 'Left'; // Palm facing camera, thumb on left = left hand
    } else {
      return 'Right'; // Palm facing camera, thumb on right = right hand
    }
  }

  /// Detect hand orientation based on palm and finger direction
  /// sensorOrientation: Camera sensor orientation (0, 90, 180, 270)
  static HandOrientation detectOrientation(List<Landmark> landmarks, {int sensorOrientation = 90}) {
    if (landmarks.length < 21) return HandOrientation.unknown;

    final wrist = landmarks[0];
    final middleTip = landmarks[12]; // Middle finger tip

    // Calculate finger direction (wrist to middle tip)
    double dirX = middleTip.x - wrist.x;
    double dirY = middleTip.y - wrist.y;
    final dirZ = middleTip.z - wrist.z;

    // Transform direction based on sensor orientation to match screen coordinates
    double transformedX, transformedY;
    if (sensorOrientation == 90) {
      // 90 degree: (x, y) -> (1-y, x) means direction: (dx, dy) -> (-dy, dx)
      transformedX = -dirY;
      transformedY = dirX;
    } else if (sensorOrientation == 270) {
      // 270 degree: (x, y) -> (y, 1-x) means direction: (dx, dy) -> (dy, -dx)
      transformedX = dirY;
      transformedY = -dirX;
    } else if (sensorOrientation == 180) {
      // 180 degree: (x, y) -> (1-x, 1-y) means direction: (dx, dy) -> (-dx, -dy)
      transformedX = -dirX;
      transformedY = -dirY;
    } else {
      // 0 degree: no transformation
      transformedX = dirX;
      transformedY = dirY;
    }

    final absX = transformedX.abs();
    final absY = transformedY.abs();
    final absZ = dirZ.abs();

    // Find the dominant axis
    // Y axis: negative = up (screen top), positive = down (screen bottom)
    // X axis: negative = left (screen left), positive = right (screen right)
    if (absY > absX && absY > absZ) {
      // Vertical orientation
      return transformedY < 0 ? HandOrientation.up : HandOrientation.down;
    } else if (absX > absY && absX > absZ) {
      // Horizontal orientation
      return transformedX < 0 ? HandOrientation.left : HandOrientation.right;
    } else {
      // Depth orientation
      return dirZ < 0 ? HandOrientation.forward : HandOrientation.backward;
    }
  }

  /// Comprehensive gesture detection with orientation
  /// sensorOrientation: Camera sensor orientation for correct direction detection
  static GestureResult detectGesture(List<Landmark> landmarks, {String? handedness, int sensorOrientation = 90}) {
    final fingerState = getFingerState(landmarks);

    // Auto-detect handedness if not provided (with sensor orientation for correct transform)
    final detectedHandedness = handedness ?? detectHandedness(landmarks, sensorOrientation: sensorOrientation);

    if (landmarks.length < 21) {
      return GestureResult(
        gesture: HandGesture.unknown,
        confidence: 0.0,
        extendedFingerCount: 0,
        orientation: HandOrientation.unknown,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    final extendedFingers = fingerState.count;
    final orientation = detectOrientation(landmarks, sensorOrientation: sensorOrientation);
    final handScale = _calculateHandScale(landmarks);
    final scaleConfidence = (handScale * 3).clamp(0.0, 1.0);

    // Check for specific gestures with priority
    // 1. Thumbs Up
    if (isThumbsUp(landmarks)) {
      return GestureResult(
        gesture: HandGesture.thumbsUp,
        confidence: scaleConfidence * 0.95,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 2. Thumbs Down
    if (isThumbsDown(landmarks)) {
      return GestureResult(
        gesture: HandGesture.thumbsDown,
        confidence: scaleConfidence * 0.95,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 3. Pointing
    if (isPointing(landmarks)) {
      return GestureResult(
        gesture: HandGesture.pointing,
        confidence: scaleConfidence * 0.95,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 4. Peace Sign
    if (isPeaceSign(landmarks)) {
      return GestureResult(
        gesture: HandGesture.peace,
        confidence: scaleConfidence * 0.95,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 5. Rock / Fist (0-1 fingers extended)
    if (extendedFingers <= 1) {
      final confidence = scaleConfidence * (extendedFingers == 0 ? 1.0 : 0.85);
      return GestureResult(
        gesture: HandGesture.fist,
        confidence: confidence,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 6. Paper / Open Palm (4-5 fingers extended)
    if (extendedFingers >= 4) {
      final confidence = scaleConfidence * (extendedFingers == 5 ? 1.0 : 0.9);
      return GestureResult(
        gesture: HandGesture.openPalm,
        confidence: confidence,
        extendedFingerCount: extendedFingers,
        orientation: orientation,
        fingerState: fingerState,
        handedness: detectedHandedness,
      );
    }

    // 7. Scissors (2 fingers extended - specifically index and middle)
    if (extendedFingers == 2) {
      if (fingerState.index && fingerState.middle) {
        return GestureResult(
          gesture: HandGesture.scissors,
          confidence: scaleConfidence * 0.95,
          extendedFingerCount: extendedFingers,
          orientation: orientation,
          fingerState: fingerState,
          handedness: detectedHandedness,
        );
      }
    }

    // Default: Unknown - still return finger states for detailed info
    return GestureResult(
      gesture: HandGesture.unknown,
      confidence: 0.0,
      extendedFingerCount: extendedFingers,
      orientation: orientation,
      fingerState: fingerState,
      handedness: detectedHandedness,
    );
  }

  /// Calculate Euclidean distance between two landmarks
  static double _distance(Landmark a, Landmark b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    final dz = a.z - b.z;
    return dx * dx + dy * dy + dz * dz; // No sqrt needed for comparison
  }

  /// Get a human-readable description of the hand state
  static String getHandDescription(List<Landmark> landmarks) {
    if (landmarks.isEmpty) return 'No hand detected';

    final result = detectGesture(landmarks);
    final parts = <String>[];

    // Add finger count
    parts.add('${result.extendedFingerCount} finger${result.extendedFingerCount != 1 ? 's' : ''} extended');

    // Add gesture and orientation
    if (result.gesture != HandGesture.unknown && result.confidence >= _minConfidence) {
      final gestureText = result.orientation != HandOrientation.unknown
          ? '${result.gesture} ${result.orientation}'
          : result.gesture.toString();
      parts.add('$gestureText (${(result.confidence * 100).toStringAsFixed(0)}%)');
    }

    return parts.join(' - ');
  }
}

/// Simple 3D vector class for angle calculations
class _Vector3 {
  final double x;
  final double y;
  final double z;

  const _Vector3(this.x, this.y, this.z);

  /// Dot product with another vector
  double dot(_Vector3 other) {
    return x * other.x + y * other.y + z * other.z;
  }

  /// Magnitude (length) of the vector
  double get magnitude {
    return math.sqrt(x * x + y * y + z * z);
  }
}
