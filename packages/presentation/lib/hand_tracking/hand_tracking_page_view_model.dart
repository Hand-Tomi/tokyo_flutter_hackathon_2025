import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'gesture_recognizer.dart';
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

  // Drawing state
  bool _wasDrawing = false;
  List<Offset> _currentPathPoints = [];

  // Fist gesture state
  bool _wasFist = false;

  // Hand detection timer
  DateTime? _lastHandDetectedTime;
  bool _timerDialogShown = false;

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
        // Hand detected - reset timer
        _lastHandDetectedTime = DateTime.now();
        _timerDialogShown = false;

        statusMessage = '${hands.length} hand(s) detected!';
        // Recognize gesture from first hand
        final firstHand = hands[0].landmarks;
        gestureInfo = GestureRecognizer.getHandDescription(firstHand);

        // Simple fist detection
        final extendedFingers = GestureRecognizer.countExtendedFingers(firstHand);
        final isFist = extendedFingers == 0;

        if (isFist) {
          // Fist detected - save current path and stop drawing
          if (!_wasFist && _wasDrawing) {
            _finishCurrentPath();
            statusMessage = 'Fist - Path saved!';
          }
          _wasFist = true;
          _wasDrawing = false;
        } else {
          // Any other hand gesture - draw with index finger
          isDrawingMode = true;
          _wasFist = false;
          statusMessage = 'Drawing... ($extendedFingers fingers)';

          // Track drawing path using index finger tip
          final fingerTip = GestureRecognizer.getIndexFingerTip(firstHand);
          if (fingerTip != null) {
            _processDrawingPoint(fingerTip.x, fingerTip.y);
          }
          _wasDrawing = true;
        }
      } else {
        statusMessage = 'Looking for hands...';
        // No hand detected - finish current path
        if (_wasDrawing) {
          _finishCurrentPath();
        }
        _wasDrawing = false;
        _wasFist = false;

        // Check timer for dialog
        if (_lastHandDetectedTime != null && !_timerDialogShown) {
          final timeSinceLastHand =
              DateTime.now().difference(_lastHandDetectedTime!);
          if (timeSinceLastHand.inSeconds >= 5) {
            // Show confirmation dialog
            state = state.copyWith(
              action: HandTrackingPageAction.showConfirmDialog(),
            );
            _timerDialogShown = true;
          }
        }
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

  /// Convert drawing paths to white background image
  Future<Uint8List?> onCreateImage() async {
    try {
      final paths = state.uiState.drawingPaths;
      if (paths.isEmpty) {
        debugPrint('No paths to convert');
        return null;
      }

      // Image size (you can adjust this)
      const imageWidth = 512.0;
      const imageHeight = 512.0;

      // Create a picture recorder
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw white background
      final backgroundPaint = Paint()..color = const Color(0xFFFFFFFF);
      canvas.drawRect(
        Rect.fromLTWH(0, 0, imageWidth, imageHeight),
        backgroundPaint,
      );

      // Draw all paths
      for (final pathData in paths) {
        if (pathData.points.length < 2) continue;

        final paint = Paint()
          ..color = pathData.color
          ..strokeWidth = pathData.strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

        final path = Path();
        final firstPoint = Offset(
          pathData.points.first.dx * imageWidth,
          pathData.points.first.dy * imageHeight,
        );
        path.moveTo(firstPoint.dx, firstPoint.dy);

        // Draw smooth curves
        for (int i = 1; i < pathData.points.length - 1; i++) {
          final p0 = Offset(
            pathData.points[i].dx * imageWidth,
            pathData.points[i].dy * imageHeight,
          );
          final p1 = Offset(
            pathData.points[i + 1].dx * imageWidth,
            pathData.points[i + 1].dy * imageHeight,
          );
          final midPoint = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
          path.quadraticBezierTo(p0.dx, p0.dy, midPoint.dx, midPoint.dy);
        }

        // Add last point
        if (pathData.points.length > 1) {
          final lastPoint = Offset(
            pathData.points.last.dx * imageWidth,
            pathData.points.last.dy * imageHeight,
          );
          path.lineTo(lastPoint.dx, lastPoint.dy);
        }

        canvas.drawPath(path, paint);
      }

      // Convert to image
      final picture = recorder.endRecording();
      final image = await picture.toImage(
        imageWidth.toInt(),
        imageHeight.toInt(),
      );

      // Convert to PNG bytes
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        debugPrint('Failed to convert image to bytes');
        return null;
      }

      final pngBytes = byteData.buffer.asUint8List();
      debugPrint('Image created: ${pngBytes.length} bytes');
      return pngBytes;
    } catch (e) {
      debugPrint('Error creating image: $e');
      return null;
    }
  }

  void _dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
  }
}
