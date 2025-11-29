import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/page_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'gesture_recognizer.dart';
import 'hand_landmark_mapper.dart';
import 'robust_gesture_detector.dart';

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

  // Robust gesture detector with frame buffering
  late final RobustGestureDetector _gestureDetector;

  // Drawing state
  bool _wasDrawing = false;
  List<Offset> _currentPathPoints = [];

  // Pen down/up control based on movement speed
  Offset? _lastDrawPoint;
  DateTime? _lastDrawTime;
  bool _isPenDown = false;

  // Hand detection timer
  DateTime? _lastHandDetectedTime;
  bool _timerDialogShown = false;

  @override
  PageState<HandTrackingPageUiState, HandTrackingPageAction> build() {
    ref.onDispose(_dispose);

    // Initialize robust gesture detector with custom config
    _gestureDetector = RobustGestureDetector(
      config: const GestureDetectionConfig(
        indexExtensionThreshold: 0.06,        // Reduced threshold for easier detection
        fistMaxDistance: 0.15,                // Fist detection threshold
        consecutiveFramesRequired: 2,         // Only 2 frames for immediate response
        smoothingFactor: 0.5,                 // 50/50 for balance
        otherFingersCurledThreshold: 0.03,    // Not used anymore but kept for config
      ),
    );

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

        final firstHand = hands[0].landmarks;

        // Use robust gesture detector
        final gestureState = _gestureDetector.detectGesture(firstHand);

        // Get debug info
        final debugInfo = _gestureDetector.getDebugInfo(firstHand);
        debugPrint('Gesture: ${gestureState.name} | Frames: ${debugInfo['consecutiveFrames']} | '
            'Index-Middle diff: ${debugInfo['indexVsMiddle']}');

        gestureInfo = 'State: ${gestureState.name}';

        if (gestureState == GestureState.drawing) {
          // DRAWING MODE: Index finger extended
          isDrawingMode = true;
          statusMessage = 'Drawing with index finger...';

          // Use smoothed index finger position to reduce jitter
          final smoothedTip = _gestureDetector.smoothedIndexTip;
          if (smoothedTip != null) {
            _processDrawingPoint(smoothedTip.dx, smoothedTip.dy);
          }
          _wasDrawing = true;
        } else if (gestureState == GestureState.stopped) {
          // STOPPED MODE: Fist detected
          statusMessage = 'Fist detected - path saved!';

          if (_wasDrawing) {
            _finishCurrentPath();
            debugPrint('Path saved - fist gesture detected');
          }
          _wasDrawing = false;
        } else {
          // UNKNOWN STATE: Keep previous behavior
          statusMessage = 'Show index finger to draw, fist to stop';

          // If was drawing but now unknown, keep drawing until clear stop
          if (_wasDrawing) {
            final fingerTip = GestureRecognizer.getIndexFingerTip(firstHand);
            if (fingerTip != null) {
              _processDrawingPoint(fingerTip.x, fingerTip.y);
            }
          }
        }
      } else {
        statusMessage = 'Show your hand to draw';
        // No hand detected - save current path automatically
        if (_wasDrawing) {
          _finishCurrentPath();
          debugPrint('Path saved - hand removed from screen');
        }
        _wasDrawing = false;
        _gestureDetector.reset(); // Reset detector when hand disappears

        // Reset pen state when hand disappears
        _lastDrawPoint = null;
        _lastDrawTime = null;
        _isPenDown = false;

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

  /// Process a drawing point from finger tip with speed-based pen control
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
    final now = DateTime.now();

    // Calculate movement speed to detect pen down/up
    if (_lastDrawPoint != null && _lastDrawTime != null) {
      final distance = (point - _lastDrawPoint!).distance;
      final timeDelta = now.difference(_lastDrawTime!).inMilliseconds;

      // Velocity threshold: if hand moves too fast, lift pen (start new path)
      const maxVelocity = 2.0; // Threshold for "fast movement" (adjust as needed)
      final velocity = timeDelta > 0 ? distance / (timeDelta / 1000.0) : 0.0;

      if (velocity > maxVelocity) {
        // Hand moving too fast - lift pen and start new path
        if (_isPenDown && _currentPathPoints.isNotEmpty) {
          _finishCurrentPath();
        }
        _isPenDown = false;
      } else {
        // Hand moving slowly - pen down, continue drawing
        _isPenDown = true;
      }
    } else {
      // First point - pen down
      _isPenDown = true;
    }

    // Only add point if pen is down
    if (_isPenDown) {
      // Skip if point is too close to last point (reduces noise)
      if (_currentPathPoints.isNotEmpty) {
        final lastPoint = _currentPathPoints.last;
        final distance = (point - lastPoint).distance;
        if (distance < 0.01) {
          _lastDrawPoint = point;
          _lastDrawTime = now;
          return; // Too close, skip
        }
      }

      _currentPathPoints.add(point);
    }

    _lastDrawPoint = point;
    _lastDrawTime = now;
  }

  /// Finish current drawing path and save it (no shape recognition)
  void _finishCurrentPath() {
    if (_currentPathPoints.length >= 2) {
      // Save raw path as-is (no shape normalization)
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
      debugPrint('Path saved: ${_currentPathPoints.length} points');
    }
    _currentPathPoints.clear();
  }

  /// Clear all drawings
  void onClearDrawing() {
    debugPrint('🗑️ Clear drawing button pressed');
    _currentPathPoints.clear();
    _wasDrawing = false;
    _lastHandDetectedTime = null;
    _timerDialogShown = false;
    _gestureDetector.reset();

    // Reset pen state
    _lastDrawPoint = null;
    _lastDrawTime = null;
    _isPenDown = false;

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        drawingPaths: [],
        currentPath: [],
        isFingerDown: false,
      ),
    );
    debugPrint('✅ Drawings cleared: ${state.uiState.drawingPaths.length} paths');
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

      // Use camera preview aspect ratio to prevent distortion
      final previewSize = state.uiState.previewSize;
      final sensorOrientation = state.uiState.sensorOrientation ?? 0;
      double imageWidth = 1080.0;
      double imageHeight = 1920.0;

      if (previewSize != null) {
        // Calculate aspect ratio considering sensor orientation
        // When sensor is rotated (90 or 270), width and height are swapped on screen
        double aspectRatio;
        if (sensorOrientation == 90 || sensorOrientation == 270) {
          // Camera is rotated - screen shows swapped dimensions
          aspectRatio = previewSize.width / previewSize.height;
        } else {
          // Camera is not rotated - screen shows normal dimensions
          aspectRatio = previewSize.height / previewSize.width;
        }

        // Set width to 1080 and calculate height to match screen aspect ratio
        imageWidth = 1080.0;
        imageHeight = imageWidth * aspectRatio;

        debugPrint('Preview size: ${previewSize.width}x${previewSize.height}');
        debugPrint('Sensor orientation: $sensorOrientation°');
        debugPrint('Screen aspect ratio: $aspectRatio');
      }

      debugPrint('Image size: ${imageWidth.toInt()}x${imageHeight.toInt()}');

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

  /// Save image to gallery
  Future<bool> onSaveToGallery(Uint8List imageBytes) async {
    try {
      // Request storage permission
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        debugPrint('Gallery permission denied');
        state = state.copyWith(
          action: HandTrackingPageAction.showError('갤러리 권한이 필요합니다'),
        );
        return false;
      }

      // Save to temporary file first
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/hand_drawing_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(imageBytes);

      // Save to gallery using gal package
      await Gal.putImage(file.path, album: 'HandDrawings');

      debugPrint('Image saved to gallery: ${file.path}');
      return true;
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      state = state.copyWith(
        action: HandTrackingPageAction.showError('갤러리 저장 실패: $e'),
      );
      return false;
    }
  }

  void _dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
  }
}
