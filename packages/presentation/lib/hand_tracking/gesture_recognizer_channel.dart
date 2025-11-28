import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Flutter Method Channel for MediaPipe Gesture Recognizer
/// Communicates with native Android/iOS for AI-based gesture recognition
class GestureRecognizerChannel {
  static const _channel = MethodChannel(
    'com.example.flutter_architecture_sample/gesture_recognizer',
  );

  bool _isInitialized = false;

  /// Check if the recognizer is initialized
  bool get isInitialized => _isInitialized;

  /// Initialize the gesture recognizer
  Future<bool> initialize() async {
    try {
      final result = await _channel.invokeMethod<bool>('initialize');
      _isInitialized = result ?? false;
      debugPrint('GestureRecognizerChannel initialized: $_isInitialized');
      return _isInitialized;
    } catch (e) {
      debugPrint('GestureRecognizerChannel initialization error: $e');
      _isInitialized = false;
      return false;
    }
  }

  /// Recognize gestures from a camera image
  /// Returns a map containing hands with gestures, landmarks, and handedness
  Future<GestureRecognitionResult?> recognizeFromCameraImage(
    CameraImage image,
    int rotationDegrees,
  ) async {
    if (!_isInitialized) {
      debugPrint('GestureRecognizerChannel not initialized');
      return null;
    }

    try {
      // Extract YUV planes from camera image
      final yPlane = image.planes[0];
      final uPlane = image.planes[1];
      final vPlane = image.planes[2];

      final result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'recognizeGesture',
        {
          'yBuffer': Uint8List.fromList(yPlane.bytes),
          'uBuffer': Uint8List.fromList(uPlane.bytes),
          'vBuffer': Uint8List.fromList(vPlane.bytes),
          'width': image.width,
          'height': image.height,
          'yRowStride': yPlane.bytesPerRow,
          'uvRowStride': uPlane.bytesPerRow,
          'uvPixelStride': uPlane.bytesPerPixel ?? 1,
          'rotationDegrees': rotationDegrees,
        },
      );

      if (result == null) return null;

      return GestureRecognitionResult.fromMap(result);
    } catch (e) {
      debugPrint('GestureRecognizerChannel recognition error: $e');
      return null;
    }
  }

  /// Close the recognizer and release resources
  Future<void> close() async {
    try {
      await _channel.invokeMethod('close');
      _isInitialized = false;
      debugPrint('GestureRecognizerChannel closed');
    } catch (e) {
      debugPrint('GestureRecognizerChannel close error: $e');
    }
  }

  /// Check if the native recognizer is ready
  Future<bool> isReady() async {
    try {
      final result = await _channel.invokeMethod<bool>('isReady');
      return result ?? false;
    } catch (e) {
      return false;
    }
  }
}

/// Result from gesture recognition
class GestureRecognitionResult {
  final List<RecognizedHand> hands;
  final int timestamp;

  GestureRecognitionResult({
    required this.hands,
    required this.timestamp,
  });

  factory GestureRecognitionResult.fromMap(Map<Object?, Object?> map) {
    final handsList = (map['hands'] as List<Object?>?)?.map((hand) {
      return RecognizedHand.fromMap(hand as Map<Object?, Object?>);
    }).toList() ?? [];

    return GestureRecognitionResult(
      hands: handsList,
      timestamp: (map['timestamp'] as int?) ?? 0,
    );
  }

  bool get hasHands => hands.isNotEmpty;
}

/// Gesture candidate with name and score
class GestureCandidate {
  final String name;
  final double score;

  GestureCandidate({required this.name, required this.score});

  factory GestureCandidate.fromMap(Map<Object?, Object?> map) {
    return GestureCandidate(
      name: (map['name'] as String?) ?? 'Unknown',
      score: (map['score'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Recognized hand data from MediaPipe
class RecognizedHand {
  /// Gesture name (e.g., "Thumb_Up", "Victory", "Open_Palm", etc.)
  final String gesture;

  /// Gesture confidence score (0.0 - 1.0)
  final double gestureScore;

  /// Handedness ("Left" or "Right")
  final String handedness;

  /// Handedness confidence score (0.0 - 1.0)
  final double handednessScore;

  /// 21 hand landmarks with x, y, z coordinates (normalized 0.0 - 1.0)
  final List<RecognizedLandmark> landmarks;

  /// All gesture candidates with scores (for debugging)
  final List<GestureCandidate> allGestures;

  RecognizedHand({
    required this.gesture,
    required this.gestureScore,
    required this.handedness,
    required this.handednessScore,
    required this.landmarks,
    required this.allGestures,
  });

  factory RecognizedHand.fromMap(Map<Object?, Object?> map) {
    final landmarkList = (map['landmarks'] as List<Object?>?)?.map((lm) {
      final lmMap = lm as Map<Object?, Object?>;
      return RecognizedLandmark(
        x: (lmMap['x'] as num?)?.toDouble() ?? 0.0,
        y: (lmMap['y'] as num?)?.toDouble() ?? 0.0,
        z: (lmMap['z'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList() ?? [];

    final allGesturesList = (map['allGestures'] as List<Object?>?)?.map((g) {
      return GestureCandidate.fromMap(g as Map<Object?, Object?>);
    }).toList() ?? [];

    return RecognizedHand(
      gesture: (map['gesture'] as String?) ?? 'None',
      gestureScore: (map['gestureScore'] as num?)?.toDouble() ?? 0.0,
      handedness: (map['handedness'] as String?) ?? 'Unknown',
      handednessScore: (map['handednessScore'] as num?)?.toDouble() ?? 0.0,
      landmarks: landmarkList,
      allGestures: allGesturesList,
    );
  }

  /// Get gesture display name in Korean
  String get gestureDisplayName {
    switch (gesture) {
      case 'Thumb_Up':
        return '👍 엄지 척';
      case 'Thumb_Down':
        return '👎 엄지 아래';
      case 'Victory':
        return '✌️ 브이';
      case 'ILoveYou':
        return '🤟 사랑해';
      case 'Open_Palm':
        return '🖐️ 손바닥';
      case 'Closed_Fist':
        return '✊ 주먹';
      case 'Pointing_Up':
        return '☝️ 검지';
      case 'None':
        return '인식 중...';
      default:
        return gesture;
    }
  }

  /// Get handedness display name in Korean
  String get handednessDisplayName {
    return handedness == 'Left' ? '왼손' : handedness == 'Right' ? '오른손' : handedness;
  }
}

/// Single landmark point
class RecognizedLandmark {
  final double x;
  final double y;
  final double z;

  RecognizedLandmark({
    required this.x,
    required this.y,
    required this.z,
  });
}
