import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hand_landmarker/hand_landmarker.dart';

/// Gesture states for drawing control
enum GestureState {
  drawing,  // Index finger only extended
  stopped,  // Fist or other gestures
  unknown,  // Uncertain state
}

/// Configuration for gesture detection sensitivity
class GestureDetectionConfig {
  /// How much longer index finger must be compared to other fingers
  /// to be considered "drawing mode"
  final double indexExtensionThreshold;

  /// Maximum average distance for all fingers to be considered "fist"
  final double fistMaxDistance;

  /// Number of consecutive frames needed to confirm state change
  final int consecutiveFramesRequired;

  /// Smoothing factor for EMA (0.0-1.0, higher = less smoothing)
  final double smoothingFactor;

  /// Threshold for other fingers to be considered "curled"
  final double otherFingersCurledThreshold;

  const GestureDetectionConfig({
    this.indexExtensionThreshold = 0.08,      // Index must be 0.08 units longer
    this.fistMaxDistance = 0.15,              // All fingers within 0.15 of wrist
    this.consecutiveFramesRequired = 2,       // 2 consecutive frames (faster response)
    this.smoothingFactor = 0.3,               // 30% new value, 70% old (smooth)
    this.otherFingersCurledThreshold = 0.05,  // Other fingers must be curled
  });
}

/// Robust gesture detector using Euclidean distance and frame buffering
class RobustGestureDetector {
  final GestureDetectionConfig config;

  // Frame buffer for debouncing
  GestureState _currentState = GestureState.unknown;
  GestureState _candidateState = GestureState.unknown;
  int _consecutiveFrameCount = 0;

  // Smoothed index finger tip position (EMA)
  Offset? _smoothedIndexTip;

  // Index finger straightness history for robust detection
  final List<bool> _indexStraightHistory = [];
  static const int _straightHistorySize = 4;

  RobustGestureDetector({
    GestureDetectionConfig? config,
  }) : config = config ?? const GestureDetectionConfig();

  /// Get current stable gesture state
  GestureState get currentState => _currentState;

  /// Get smoothed index finger tip position (for drawing)
  Offset? get smoothedIndexTip => _smoothedIndexTip;

  /// Process new hand landmarks and return stable state
  GestureState detectGesture(List<Landmark> landmarks) {
    if (landmarks.length < 21) {
      return _currentState; // Keep previous state if no hand detected
    }

    // 1. Get index finger landmarks (5=MCP, 6=PIP, 7=DIP, 8=TIP)
    final indexMcp = landmarks[5];
    final indexPip = landmarks[6];
    final indexDip = landmarks[7];
    final indexTip = landmarks[8];

    // 2. Check if index finger is straight (5-6-7-8 linearity)
    final isIndexStraight = _checkIndexStraightness(
      indexMcp, indexPip, indexDip, indexTip,
    );

    // Update straightness history
    _indexStraightHistory.add(isIndexStraight);
    if (_indexStraightHistory.length > _straightHistorySize) {
      _indexStraightHistory.removeAt(0);
    }

    // 3. Check if index is consistently straight for N frames
    final consistentlyStraight = _indexStraightHistory.length >= 3 &&
        _indexStraightHistory.where((s) => s).length >= 3;

    // 4. Apply EMA smoothing to index finger tip position
    final rawIndexTipOffset = Offset(indexTip.x, indexTip.y);
    if (_smoothedIndexTip == null) {
      _smoothedIndexTip = rawIndexTipOffset;
    } else {
      // EMA: smoothed = alpha * new + (1 - alpha) * old
      _smoothedIndexTip = Offset(
        config.smoothingFactor * rawIndexTipOffset.dx +
            (1 - config.smoothingFactor) * _smoothedIndexTip!.dx,
        config.smoothingFactor * rawIndexTipOffset.dy +
            (1 - config.smoothingFactor) * _smoothedIndexTip!.dy,
      );
    }

    // 5. Calculate distances from wrist to other fingers
    final wrist = landmarks[0];
    final middleTip = landmarks[12];
    final ringTip = landmarks[16];
    final pinkyTip = landmarks[20];

    final distIndex = _euclideanDistance(wrist, indexTip);
    final distMiddle = _euclideanDistance(wrist, middleTip);
    final distRing = _euclideanDistance(wrist, ringTip);
    final distPinky = _euclideanDistance(wrist, pinkyTip);

    // 6. Determine raw gesture based on straightness + distance
    // Use hysteresis: if already drawing, use more lenient thresholds
    final rawGesture = _analyzeGesture(
      isIndexStraight: consistentlyStraight,
      distIndex: distIndex,
      distMiddle: distMiddle,
      distRing: distRing,
      distPinky: distPinky,
      currentState: _currentState, // Pass current state for hysteresis
    );

    // 7. Apply frame buffering (debounce)
    return _updateStateWithBuffer(rawGesture);
  }

  /// Check if index finger is straight (5-6-7-8 linearity)
  bool _checkIndexStraightness(
    Landmark mcp,
    Landmark pip,
    Landmark dip,
    Landmark tip,
  ) {
    // Calculate if 5-6-7-8 form a relatively straight line
    // Method: check if 6 and 7 are close to the line formed by 5-8

    // Distance from pip (6) to line 5-8
    final pipDeviation = _pointToLineDistance3D(pip, mcp, tip);

    // Distance from dip (7) to line 5-8
    final dipDeviation = _pointToLineDistance3D(dip, mcp, tip);

    // If both are small, finger is straight
    // Relaxed threshold to prevent drawing interruptions
    const straightnessThreshold = 0.045; // More lenient for stable drawing
    final isStraight = pipDeviation < straightnessThreshold &&
        dipDeviation < straightnessThreshold;

    // Also check if tip is far enough from mcp (extended)
    final extension = _euclideanDistance(mcp, tip);
    const minExtension = 0.15; // Finger must be extended

    return isStraight && extension > minExtension;
  }

  /// Calculate 3D distance from point to line
  double _pointToLineDistance3D(
    Landmark point,
    Landmark lineStart,
    Landmark lineEnd,
  ) {
    final dx = lineEnd.x - lineStart.x;
    final dy = lineEnd.y - lineStart.y;
    final dz = lineEnd.z - lineStart.z;

    // Vector from lineStart to point
    final px = point.x - lineStart.x;
    final py = point.y - lineStart.y;
    final pz = point.z - lineStart.z;

    // Project point onto line
    final lineLengthSq = dx * dx + dy * dy + dz * dz;
    if (lineLengthSq == 0) return _euclideanDistance(point, lineStart);

    final t = (px * dx + py * dy + pz * dz) / lineLengthSq;

    // Closest point on line
    final closestX = lineStart.x + t * dx;
    final closestY = lineStart.y + t * dy;
    final closestZ = lineStart.z + t * dz;

    // Distance from point to closest point
    final distX = point.x - closestX;
    final distY = point.y - closestY;
    final distZ = point.z - closestZ;

    return sqrt(distX * distX + distY * distY + distZ * distZ);
  }

  /// Analyze gesture based on straightness and distances
  /// Uses hysteresis: more lenient thresholds when already drawing
  GestureState _analyzeGesture({
    required bool isIndexStraight,
    required double distIndex,
    required double distMiddle,
    required double distRing,
    required double distPinky,
    required GestureState currentState,
  }) {
    // If index is NOT straight, it's bent → stop gesture
    if (!isIndexStraight) {
      return GestureState.stopped;
    }

    // Apply hysteresis: use different thresholds based on current state
    // If already drawing, use more lenient threshold to prevent interruptions
    final threshold = currentState == GestureState.drawing
        ? config.indexExtensionThreshold * 0.5  // 50% of normal threshold when drawing
        : config.indexExtensionThreshold;       // Normal threshold otherwise

    // If index is straight AND extended more than others → drawing
    final isIndexLonger =
        distIndex > distMiddle + threshold &&
        distIndex > distRing + threshold &&
        distIndex > distPinky + threshold;

    if (isIndexLonger) {
      return GestureState.drawing;
    }

    // Otherwise uncertain
    return GestureState.unknown;
  }

  /// Update state with frame buffering to prevent flickering
  GestureState _updateStateWithBuffer(GestureState rawGesture) {
    if (rawGesture == _candidateState) {
      // Same gesture detected - increment counter
      _consecutiveFrameCount++;

      // If we've seen this gesture enough times, commit the change
      if (_consecutiveFrameCount >= config.consecutiveFramesRequired) {
        _currentState = _candidateState;
      }
    } else {
      // Different gesture detected - reset counter
      _candidateState = rawGesture;
      _consecutiveFrameCount = 1;
    }

    return _currentState;
  }

  /// Calculate Euclidean distance between two landmarks
  double _euclideanDistance(Landmark a, Landmark b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    final dz = a.z - b.z;
    return sqrt(dx * dx + dy * dy + dz * dz);
  }

  /// Reset the detector state
  void reset() {
    _currentState = GestureState.unknown;
    _candidateState = GestureState.unknown;
    _consecutiveFrameCount = 0;
    _smoothedIndexTip = null;
  }

  /// Get debug information about current detection
  Map<String, dynamic> getDebugInfo(List<Landmark> landmarks) {
    if (landmarks.length < 21) {
      return {'error': 'Not enough landmarks'};
    }

    final wrist = landmarks[0];
    final indexTip = landmarks[8];
    final middleTip = landmarks[12];
    final ringTip = landmarks[16];
    final pinkyTip = landmarks[20];

    final distIndex = _euclideanDistance(wrist, indexTip);
    final distMiddle = _euclideanDistance(wrist, middleTip);
    final distRing = _euclideanDistance(wrist, ringTip);
    final distPinky = _euclideanDistance(wrist, pinkyTip);

    return {
      'currentState': _currentState.toString(),
      'candidateState': _candidateState.toString(),
      'consecutiveFrames': _consecutiveFrameCount,
      'distances': {
        'index': distIndex.toStringAsFixed(3),
        'middle': distMiddle.toStringAsFixed(3),
        'ring': distRing.toStringAsFixed(3),
        'pinky': distPinky.toStringAsFixed(3),
      },
      'indexVsMiddle': (distIndex - distMiddle).toStringAsFixed(3),
      'threshold': config.indexExtensionThreshold,
    };
  }
}
