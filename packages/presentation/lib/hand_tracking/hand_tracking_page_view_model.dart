import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'gesture_recognizer.dart';
import 'gesture_recognizer_channel.dart';
import 'hand_landmark_mapper.dart';

part 'hand_tracking_page_view_model.g.dart';

/// Hand Tracking Page ViewModel
///
/// Manages camera, hand landmarker plugin, and state
@riverpod
class HandTrackingPageViewModel extends _$HandTrackingPageViewModel {
  HandLandmarkerPlugin? _plugin;
  CameraController? _controller;
  bool _isDetecting = false;
  int _frameCounter = 0;

  // Native MediaPipe Gesture Recognizer
  final GestureRecognizerChannel _gestureChannel = GestureRecognizerChannel();
  bool _useNativeGestureRecognizer = true;

  // Gesture stabilization buffer
  static const int _gestureBufferSize = 5; // Number of frames to average
  final List<HandGesture> _gestureBuffer = [];
  String _lastNativeGesture = '';

  @override
  PageState<HandTrackingPageUiState, HandTrackingPageAction> build() {
    ref.onDispose(_dispose);
    return PageState(
      uiState: const HandTrackingPageUiState(),
      action: HandTrackingPageAction.none(),
    );
  }

  /// Camera controller accessor for CameraPreview widget
  CameraController? get cameraController => _controller;

  /// Reset action after handling
  void onFinishedAction() {
    state = state.copyWith(action: HandTrackingPageAction.none());
  }

  /// Toggle settings panel visibility
  void onSettingsToggle() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        showSettings: !state.uiState.showSettings,
      ),
    );
  }

  /// Update frame skip value
  void onFrameSkipChanged(int value) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(frameSkip: value),
    );
  }

  /// Change camera resolution
  Future<void> onResolutionChanged(ResolutionPresetUi resolution) async {
    if (state.uiState.resolution == resolution) return;

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        resolution: resolution,
        isInitialized: false,
        statusMessage: 'Changing resolution...',
      ),
    );

    // Stop current camera
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;

    // Reinitialize with new resolution
    await onInitialize();
  }

  /// Initialize camera and hand landmarker
  Future<void> onInitialize() async {
    try {
      // 1. Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            statusMessage: 'Camera permission required',
          ),
        );
        return;
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(statusMessage: 'Initializing camera...'),
      );

      // 2. Get available cameras
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(statusMessage: 'No available cameras'),
        );
        return;
      }

      // Select back camera (or first available camera)
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      // 3. Initialize camera controller with selected resolution
      _controller = CameraController(
        camera,
        _mapResolutionPreset(state.uiState.resolution),
        enableAudio: false,
      );

      await _controller!.initialize();

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          statusMessage: 'Initializing Hand Landmarker...',
        ),
      );

      // 4. Create HandLandmarker plugin
      _plugin = HandLandmarkerPlugin.create(
        numHands: 2,
        minHandDetectionConfidence: 0.5,
        delegate: HandLandmarkerDelegate.GPU,
      );

      // 4.5. Initialize native MediaPipe Gesture Recognizer
      if (_useNativeGestureRecognizer) {
        state = state.copyWith(
          uiState: state.uiState.copyWith(
            statusMessage: 'Initializing Gesture Recognizer...',
          ),
        );
        final gestureInitialized = await _gestureChannel.initialize();
        debugPrint('Native Gesture Recognizer initialized: $gestureInitialized');
      }

      // 5. Start camera stream
      await _controller!.startImageStream(_processCameraImage);

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isInitialized: true,
          statusMessage: 'Ready! Show your hand to the camera',
          previewSize: _controller!.value.previewSize,
          sensorOrientation: _controller!.description.sensorOrientation,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          statusMessage: 'Initialization failed: $e',
        ),
        action: HandTrackingPageAction.showError('Initialization failed: $e'),
      );
      debugPrint('Initialization error: $e');
    }
  }

  /// Stabilize gesture recognition by using a sliding window buffer
  HandGesture _getStabilizedGesture(HandGesture currentGesture) {
    // Add current gesture to buffer
    _gestureBuffer.add(currentGesture);

    // Keep buffer size limited
    if (_gestureBuffer.length > _gestureBufferSize) {
      _gestureBuffer.removeAt(0);
    }

    // Count occurrences of each gesture
    final gestureCounts = <HandGesture, int>{};
    for (final gesture in _gestureBuffer) {
      gestureCounts[gesture] = (gestureCounts[gesture] ?? 0) + 1;
    }

    // Return the most frequent gesture
    HandGesture mostFrequent = currentGesture;
    int maxCount = 0;

    gestureCounts.forEach((gesture, count) {
      if (count > maxCount) {
        maxCount = count;
        mostFrequent = gesture;
      }
    });

    return mostFrequent;
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting || !state.uiState.isInitialized || _plugin == null) return;

    // Frame skipping for performance optimization
    _frameCounter++;
    if (_frameCounter % state.uiState.frameSkip != 0) {
      return;
    }

    _isDetecting = true;

    try {
      // Detect hand landmarks
      final hands = _plugin!.detect(
        image,
        _controller!.description.sensorOrientation,
      );

      final landmarks = hands.map((h) => h.toUi()).toList();
      String statusMessage;
      String gestureInfo = '';

      // Try native gesture recognition if enabled
      if (_useNativeGestureRecognizer && _gestureChannel.isInitialized) {
        final nativeResult = await _gestureChannel.recognizeFromCameraImage(
          image,
          _controller!.description.sensorOrientation,
        );

        // Debug logging with all gesture candidates
        if (nativeResult != null) {
          debugPrint('Native result: ${nativeResult.hands.length} hands, hasHands: ${nativeResult.hasHands}');
          for (final h in nativeResult.hands) {
            debugPrint('  Top Gesture: ${h.gesture}, Score: ${(h.gestureScore * 100).toStringAsFixed(1)}%, Hand: ${h.handedness}');
            debugPrint('  allGestures count: ${h.allGestures.length}');
            for (final g in h.allGestures) {
              debugPrint('    - ${g.name}: ${(g.score * 100).toStringAsFixed(1)}%');
            }
          }
        } else {
          debugPrint('Native result is null');
        }

        if (nativeResult != null && nativeResult.hasHands) {
          statusMessage = '${nativeResult.hands.length} hand(s) detected! (AI)';

          final handInfos = <String>[];
          for (final hand in nativeResult.hands) {
            final parts = <String>[];

            // Handedness
            parts.add(hand.handednessDisplayName);

            // Gesture from AI
            parts.add(hand.gestureDisplayName);

            // Confidence
            if (hand.gestureScore > 0) {
              parts.add('(${(hand.gestureScore * 100).toStringAsFixed(0)}%)');
            }

            handInfos.add(parts.join(' '));
            _lastNativeGesture = hand.gesture;
          }

          gestureInfo = handInfos.join('\n');

          state = state.copyWith(
            uiState: state.uiState.copyWith(
              landmarks: landmarks,
              statusMessage: statusMessage,
              gestureInfo: gestureInfo,
            ),
          );
          return;
        }
      }

      // Fallback to rule-based recognition
      if (hands.isNotEmpty) {
        statusMessage = '${hands.length} hand(s) detected!';

        // Build info for all detected hands
        final handInfos = <String>[];

        for (int i = 0; i < hands.length; i++) {
          final hand = hands[i].landmarks;
          final gestureResult = GestureRecognizer.detectGesture(
            hand,
            sensorOrientation: _controller!.description.sensorOrientation,
          );

          // Apply stabilization filter (only for first hand for now)
          final stabilizedGesture = i == 0 ? _getStabilizedGesture(gestureResult.gesture) : gestureResult.gesture;

          // Build detailed description for this hand
          final parts = <String>[];

          // Add handedness (왼손/오른손)
          final handName = gestureResult.handedness == 'Left' ? '왼손' :
                          gestureResult.handedness == 'Right' ? '오른손' : '손';
          parts.add(handName);

          // Add detailed finger state (e.g., "엄지, 중지 폄")
          parts.add(gestureResult.fingerState.description);

          // Add orientation if available
          if (gestureResult.orientation != HandOrientation.unknown) {
            parts.add('방향: ${gestureResult.orientation}');
          }

          // Add named gesture if recognized
          if (stabilizedGesture != HandGesture.unknown && gestureResult.confidence >= 0.7) {
            parts.add('${stabilizedGesture} (${(gestureResult.confidence * 100).toStringAsFixed(0)}%)');
          }

          handInfos.add(parts.join(' | '));
        }

        gestureInfo = handInfos.join('\n');
      } else {
        statusMessage = 'Looking for hands...';
        // Clear gesture buffer when no hand detected
        _gestureBuffer.clear();
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          landmarks: landmarks,
          statusMessage: statusMessage,
          gestureInfo: gestureInfo,
        ),
      );
    } catch (e) {
      debugPrint('Detection error: $e');
    } finally {
      _isDetecting = false;
    }
  }

  ResolutionPreset _mapResolutionPreset(ResolutionPresetUi preset) {
    switch (preset) {
      case ResolutionPresetUi.low:
        return ResolutionPreset.low;
      case ResolutionPresetUi.medium:
        return ResolutionPreset.medium;
      case ResolutionPresetUi.high:
        return ResolutionPreset.high;
    }
  }

  void _dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    _gestureChannel.close();
  }
}
