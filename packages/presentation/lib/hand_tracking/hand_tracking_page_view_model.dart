import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'gesture_recognizer.dart';
import 'hand_landmark_mapper.dart';
import 'platform/hand_landmarker.dart';

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

  // Drawing state
  bool _wasDrawing = false;
  List<Offset> _currentPathPoints = [];

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
      // Lower confidence for more sensitive detection
      _plugin = HandLandmarkerPlugin.create(
        numHands: 1,
        minHandDetectionConfidence: 0.3,
        delegate: HandLandmarkerDelegate.GPU,
      );

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
      bool isDrawingMode = false;

      if (hands.isNotEmpty) {
        statusMessage = '${hands.length} hand(s) detected!';
        // Recognize gesture from first hand
        final firstHand = hands[0].landmarks;
        gestureInfo = GestureRecognizer.getHandDescription(firstHand);

        // Always in drawing mode when hand is detected
        isDrawingMode = true;

        // Track drawing path using index finger tip
        final fingerTip = GestureRecognizer.getIndexFingerTip(firstHand);
        if (fingerTip != null) {
          _processDrawingPoint(fingerTip.x, fingerTip.y);
        }
        _wasDrawing = true;
      } else {
        statusMessage = 'Looking for hands...';
        // No hand detected - finish current path
        if (_wasDrawing) {
          _finishCurrentPath();
        }
        _wasDrawing = false;
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          landmarks: landmarks,
          statusMessage: statusMessage,
          gestureInfo: gestureInfo,
          isDrawingMode: isDrawingMode,
          currentPath: List.from(_currentPathPoints),
          isFingerDown: isDrawingMode,
        ),
      );
    } catch (e) {
      debugPrint('Detection error: $e');
    } finally {
      _isDetecting = false;
    }
  }

  /// Process a drawing point from finger tip
  void _processDrawingPoint(double x, double y) {
    // Transform coordinates based on sensor orientation
    final sensorOrientation = state.uiState.sensorOrientation ?? 0;
    double transformedX, transformedY;

    if (sensorOrientation == 90) {
      transformedX = 1 - y;
      transformedY = x;
    } else if (sensorOrientation == 270) {
      transformedX = y;
      transformedY = 1 - x;
    } else if (sensorOrientation == 180) {
      transformedX = 1 - x;
      transformedY = 1 - y;
    } else {
      transformedX = x;
      transformedY = y;
    }

    final point = Offset(transformedX, transformedY);

    // Skip if point is too close to last point (reduces noise)
    if (_currentPathPoints.isNotEmpty) {
      final lastPoint = _currentPathPoints.last;
      final distance = (point - lastPoint).distance;
      if (distance < 0.01) return; // Threshold for minimum movement
    }

    _currentPathPoints.add(point);
  }

  /// Finish current drawing path and save it
  void _finishCurrentPath() {
    if (_currentPathPoints.length >= 2) {
      final newPath = DrawingPathUi(
        points: List.from(_currentPathPoints),
        strokeWidth: 4.0,
        color: const Color(0xFF000000),
      );
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          drawingPaths: [...state.uiState.drawingPaths, newPath],
        ),
      );
    }
    _currentPathPoints.clear();
  }

  /// Clear all drawings
  void onClearDrawing() {
    _currentPathPoints.clear();
    _wasDrawing = false;
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        drawingPaths: [],
        currentPath: [],
        isFingerDown: false,
      ),
    );
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
  }
}
