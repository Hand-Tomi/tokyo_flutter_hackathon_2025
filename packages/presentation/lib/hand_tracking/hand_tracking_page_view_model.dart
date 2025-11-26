import 'package:camera/camera.dart';
import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:flutter/foundation.dart';
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

      if (hands.isNotEmpty) {
        statusMessage = '${hands.length} hand(s) detected!';
        // Recognize gesture from first hand
        final firstHand = hands[0].landmarks;
        gestureInfo = GestureRecognizer.getHandDescription(firstHand);
      } else {
        statusMessage = 'Looking for hands...';
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
  }
}
