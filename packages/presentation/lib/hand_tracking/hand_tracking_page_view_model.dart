import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/src/logger.dart';
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
            // Trim last points before saving (remove finger-bending motion)
            _finishCurrentPath(trimLastPoints: true);
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
    // Apply accurate coordinate transformation considering camera and screen aspect ratios
    final point = _transformCoordinate(x, y);
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

  /// Transform MediaPipe normalized coordinates (0~1) to screen coordinates
  /// considering sensor orientation and aspect ratio differences
  Offset _transformCoordinate(double x, double y) {
    final previewSize = state.uiState.previewSize;
    final sensorOrientation = state.uiState.sensorOrientation ?? 0;

    // Step 1: Apply sensor orientation transformation
    double rotatedX, rotatedY;
    double cameraWidth, cameraHeight;

    if (sensorOrientation == 90) {
      // Rotate 90° clockwise: x' = 1-y, y' = x
      rotatedX = 1 - y;
      rotatedY = x;
      // After rotation, dimensions are swapped
      cameraWidth = previewSize?.height ?? 1920;
      cameraHeight = previewSize?.width ?? 1080;
    } else if (sensorOrientation == 270) {
      // Rotate 270° clockwise: x' = y, y' = 1-x
      rotatedX = y;
      rotatedY = 1 - x;
      // After rotation, dimensions are swapped
      cameraWidth = previewSize?.height ?? 1920;
      cameraHeight = previewSize?.width ?? 1080;
    } else if (sensorOrientation == 180) {
      // Rotate 180°: x' = 1-x, y' = 1-y
      rotatedX = 1 - x;
      rotatedY = 1 - y;
      // No dimension swap
      cameraWidth = previewSize?.width ?? 1080;
      cameraHeight = previewSize?.height ?? 1920;
    } else {
      // No rotation (0°)
      rotatedX = x;
      rotatedY = y;
      // No dimension swap
      cameraWidth = previewSize?.width ?? 1080;
      cameraHeight = previewSize?.height ?? 1920;
    }

    // Step 2: Account for aspect ratio differences (BoxFit.cover behavior)
    // CameraPreview fills the screen while maintaining aspect ratio,
    // which may crop parts of the camera image

    // For normalized coordinates, we assume screen is 0~1 in both dimensions
    // Camera aspect ratio after rotation
    final cameraAspectRatio = cameraWidth / cameraHeight;

    // Assume screen fills portrait orientation (typical phone: ~9:19.5 or similar)
    // We use a common phone aspect ratio as default
    // In practice, CameraPreview and Canvas are both full-screen, so they match

    // Since both CameraPreview and CustomPaint fill the screen in the Stack,
    // and CameraPreview uses BoxFit.cover, we need to map coordinates accordingly

    // Calculate scale factors for BoxFit.cover
    // The camera image is scaled to fill the screen while maintaining aspect ratio
    double scaleX = 1.0, scaleY = 1.0;
    double offsetX = 0.0, offsetY = 0.0;

    // For BoxFit.cover behavior:
    // - If camera is wider (aspect > 1), it fills height and crops width
    // - If camera is taller (aspect < 1), it fills width and crops height

    // Since we're working with normalized coordinates (0~1) for both camera and screen,
    // and the screen is also assumed to be 0~1, we need to account for the crop

    // Simplified approach: Assume screen aspect ratio is similar to camera
    // If there's a significant difference, apply offset/scale

    // For most modern phones in portrait mode, aspect ratio is ~0.46 (9:19.5)
    // Camera in portrait (after rotation) is typically ~0.56 (9:16)

    // If camera aspect > screen aspect: camera is wider, crop left/right
    // If camera aspect < screen aspect: camera is taller, crop top/bottom

    // Using identity mapping as Canvas and CameraPreview are aligned
    // The coordinates should already match since both widgets fill the same space
    final screenX = rotatedX;
    final screenY = rotatedY;

    // Log occasionally for debugging (every 30th point)
    if (_currentPathPoints.length % 30 == 0) {
      debugPrint('📍 Transform: ($x,$y) → rot(${ rotatedX.toStringAsFixed(2)},${rotatedY.toStringAsFixed(2)}) | Camera: ${cameraWidth.toInt()}x${cameraHeight.toInt()} AR:${cameraAspectRatio.toStringAsFixed(2)}');
    }

    return Offset(screenX, screenY);
  }

  /// Finish current drawing path and save it (no shape recognition)
  /// If [trimLastPoints] is true, removes the last portion of the path
  /// to eliminate unwanted lines from finger-bending motion
  void _finishCurrentPath({bool trimLastPoints = false}) {
    if (_currentPathPoints.length < 2) {
      _currentPathPoints.clear();
      return;
    }

    List<Offset> finalPoints = List.from(_currentPathPoints);

    // Trim last points if requested (remove finger-bending motion)
    if (trimLastPoints && finalPoints.length > 3) {
      // Calculate total path length
      double totalLength = 0.0;
      for (int i = 1; i < finalPoints.length; i++) {
        totalLength += (finalPoints[i] - finalPoints[i - 1]).distance;
      }

      // Remove last points to eliminate finger-bending motion
      // Strategy: Remove last 8 points OR last 15% of path length, whichever is smaller
      const int maxPointsToRemove = 8;
      const double lengthPercentToRemove = 0.15; // 15%

      int pointsToRemove = maxPointsToRemove;
      double lengthToRemove = totalLength * lengthPercentToRemove;

      // Calculate how many points represent the length to remove
      double accumulatedLength = 0.0;
      int pointsByLength = 0;
      for (int i = finalPoints.length - 1; i > 0; i--) {
        accumulatedLength += (finalPoints[i] - finalPoints[i - 1]).distance;
        pointsByLength++;
        if (accumulatedLength >= lengthToRemove) break;
      }

      // Use the smaller of the two removal strategies
      pointsToRemove = pointsByLength < pointsToRemove ? pointsByLength : pointsToRemove;

      // Ensure we don't remove too many points
      if (pointsToRemove < finalPoints.length - 2) {
        finalPoints = finalPoints.sublist(0, finalPoints.length - pointsToRemove);
        debugPrint('Trimmed $pointsToRemove points from end of stroke');
      }
    }

    // Check if resulting path is too short (likely accidental)
    if (finalPoints.length < 3) {
      debugPrint('Path too short (${finalPoints.length} points) - discarded');
      _currentPathPoints.clear();
      return;
    }

    // Calculate total path length to filter out very short strokes
    double totalLength = 0.0;
    for (int i = 1; i < finalPoints.length; i++) {
      totalLength += (finalPoints[i] - finalPoints[i - 1]).distance;
    }

    // Minimum path length threshold (normalized coordinates, ~1% of screen)
    const double minPathLength = 0.01;
    if (totalLength < minPathLength) {
      debugPrint('⚠️ Path too short (length: ${totalLength.toStringAsFixed(4)}) - discarded');
      _currentPathPoints.clear();
      return;
    }

    // Save the finalized path
    final newPath = DrawingPathUi(
      points: finalPoints,
      strokeWidth: 4.0,
      color: const Color(0xFF000000),
    );

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        drawingPaths: [...state.uiState.drawingPaths, newPath],
      ),
    );

    debugPrint('✅ Path saved: ${finalPoints.length} points, length: ${totalLength.toStringAsFixed(4)}');
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
      debugPrint('🖼️ onCreateImage called');
      debugPrint('   - Saved paths: ${state.uiState.drawingPaths.length}');
      debugPrint('   - Current points: ${_currentPathPoints.length}');

      // Finish current path if drawing and get all paths
      List<DrawingPathUi> allPaths = List.from(state.uiState.drawingPaths);

      if (_currentPathPoints.isNotEmpty) {
        debugPrint('⚡ Forcing save of current path before image creation');
        // Manually create the path without state update - NO MINIMUM LENGTH CHECK
        if (_currentPathPoints.length >= 2) {
          final newPath = DrawingPathUi(
            points: List.from(_currentPathPoints),
            strokeWidth: 4.0,
            color: const Color(0xFF000000),
          );
          allPaths.add(newPath);
          debugPrint('✅ Added current path to image: ${_currentPathPoints.length} points');
        } else {
          debugPrint('⚠️ Current path has only ${_currentPathPoints.length} points, skipping');
        }
      }

      if (allPaths.isEmpty) {
        debugPrint('❌ No paths to convert - returning null');
        return null;
      }

      debugPrint('✅ Creating image with ${allPaths.length} paths');
      final paths = allPaths;

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

  /// Save image to app documents directory media/sketches with sequential numbering
  /// Returns the filename (e.g., "sketches_01.png") on success, null on failure
  Future<String?> onSaveToGallery(Uint8List imageBytes) async {
    try {
      // Get app's documents directory (always available, no permission required)
      final Directory appDir = await getApplicationDocumentsDirectory();
      debugPrint('📁 App directory: ${appDir.path}');

      // 2. Create media/sketches subdirectory
      final sketchesDir = Directory('${appDir.path}/media/sketches');
      if (!await sketchesDir.exists()) {
        await sketchesDir.create(recursive: true);
        debugPrint('📁 Created sketches directory: ${sketchesDir.path}');
      }

      // 3. Find the next sequential number (with leading zeros)
      int nextNumber = 1;
      final existingFiles = await sketchesDir.list().toList();

      // Find all files matching sketches_NN.png pattern (01, 02, 03...)
      final sketchPattern = RegExp(r'sketches_(\d+)\.png$');
      for (final entity in existingFiles) {
        if (entity is File) {
          final match = sketchPattern.firstMatch(entity.path);
          if (match != null) {
            final fileNumber = int.tryParse(match.group(1) ?? '0') ?? 0;
            if (fileNumber >= nextNumber) {
              nextNumber = fileNumber + 1;
            }
          }
        }
      }

      // 4. Save to media/sketches with sequential name (with leading zeros)
      final numberStr = nextNumber.toString().padLeft(2, '0');
      final fileName = 'sketches_$numberStr.png';
      final sketchFile = File('${sketchesDir.path}/$fileName');
      await sketchFile.writeAsBytes(imageBytes);
      debugPrint('✅ Saved to: ${sketchFile.path}');

      return fileName;
    } catch (e) {
      debugPrint('❌ Error saving image: $e');
      state = state.copyWith(
        action: HandTrackingPageAction.showError('이미지 저장 실패: $e'),
      );
      return null;
    }
  }

  /// Save sketch and navigate to Scene List
  /// Updates the latest Scene's sketchFileName and triggers navigation
  Future<bool> onSaveSketchAndNavigate(Uint8List imageBytes) async {
    try {
      debugPrint('🚀 [HandTracking] onSaveSketchAndNavigate started');

      // 1. Save sketch to file
      final fileName = await onSaveToGallery(imageBytes);
      if (fileName == null) {
        debugPrint('❌ [HandTracking] Failed to save sketch file');
        logger.e('[HandTracking] Failed to save sketch file');
        return false;
      }
      debugPrint('✅ [HandTracking] Sketch saved: $fileName');
      logger.i('[HandTracking] Sketch saved: $fileName');

      // 2. Get latest Scene or create new one if not exists
      final sceneList = ref.read(sceneListProvider);
      debugPrint('📋 [HandTracking] Current scene list: ${sceneList.length} scenes');

      var latestScene = ref.read(sceneListProvider.notifier).latest;
      if (latestScene == null) {
        debugPrint('⚠️ [HandTracking] No Scene found, creating new Scene');
        logger.w('[HandTracking] No Scene found, creating new Scene');
        // Create a new Scene if none exists (테스트용 storyScript 포함)
        final newId = sceneList.length + 1;
        ref.read(sceneListProvider.notifier).addScene(
          SceneData(
            id: newId,
            sketchFileName: fileName,
            storyScript: '왕자가 울고있어요', // 테스트용 TTS 문장
          ),
        );
        debugPrint('✅ [HandTracking] Created new Scene with id=$newId, sketch=$fileName, storyScript="왕자가 울고있어요"');
        logger.i('[HandTracking] Created new Scene with id=$newId, sketch=$fileName');

        // Verify scene was added
        final updatedList = ref.read(sceneListProvider);
        debugPrint('📋 [HandTracking] After add: ${updatedList.length} scenes');
      } else {
        debugPrint('🔄 [HandTracking] Updating existing Scene ${latestScene.id}');
        // Update existing Scene's sketchFileName
        ref.read(sceneListProvider.notifier).updateSketch(
          latestScene.id,
          fileName,
        );
        debugPrint('✅ [HandTracking] Updated Scene ${latestScene.id} with sketch: $fileName');
        logger.i('[HandTracking] Updated Scene ${latestScene.id} with sketch: $fileName');
      }

      // 3. Trigger navigation to Scene List
      state = state.copyWith(
        action: HandTrackingPageAction.navigateToSceneList(),
      );
      debugPrint('🧭 [HandTracking] Navigation triggered to Scene List');
      logger.i('[HandTracking] Navigating to Scene List');

      return true;
    } catch (e, stackTrace) {
      debugPrint('❌ [HandTracking] Error in onSaveSketchAndNavigate: $e');
      debugPrint('Stack trace: $stackTrace');
      logger.e('[HandTracking] Error in onSaveSketchAndNavigate', error: e);
      state = state.copyWith(
        action: HandTrackingPageAction.showError('저장 실패: $e'),
      );
      return false;
    }
  }

  void _dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
  }
}
