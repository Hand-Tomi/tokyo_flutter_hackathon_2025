import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hand_tracking_ui_state.freezed.dart';

/// Hand Tracking Page UI State
/// Persistent data displayed on screen
@freezed
class HandTrackingPageUiState with _$HandTrackingPageUiState {
  const factory HandTrackingPageUiState({
    @Default('Initializing...') String statusMessage,
    @Default('') String gestureInfo,
    @Default([]) List<HandLandmarkUi> landmarks,
    @Default(false) bool isInitialized,
    @Default(false) bool showSettings,
    @Default(2) int frameSkip,
    @Default(ResolutionPresetUi.medium) ResolutionPresetUi resolution,
    Size? previewSize,
    int? sensorOrientation,
    // Drawing mode state
    @Default(false) bool isDrawingMode,
    @Default([]) List<DrawingPathUi> drawingPaths,
    @Default([]) List<Offset> currentPath,
    @Default(false) bool isFingerDown,
  }) = _HandTrackingPageUiState;
}

/// Drawing path with stroke information
@freezed
class DrawingPathUi with _$DrawingPathUi {
  const factory DrawingPathUi({
    required List<Offset> points,
    @Default(3.0) double strokeWidth,
    @Default(Color(0xFF000000)) Color color,
  }) = _DrawingPathUi;
}

/// Hand Tracking Page Actions
/// One-time events (dialogs, navigation, etc.)
@freezed
class HandTrackingPageAction with _$HandTrackingPageAction {
  factory HandTrackingPageAction.none() = _None;
  factory HandTrackingPageAction.showError(String message) = _ShowError;
  factory HandTrackingPageAction.showConfirmDialog() = _ShowConfirmDialog;
  factory HandTrackingPageAction.navigateToSceneList() = _NavigateToSceneList;
}

/// UI model for hand landmark data (decoupled from hand_landmarker package)
@freezed
class HandLandmarkUi with _$HandLandmarkUi {
  const factory HandLandmarkUi({
    required List<LandmarkPointUi> points,
  }) = _HandLandmarkUi;
}

/// UI model for a single landmark point
@freezed
class LandmarkPointUi with _$LandmarkPointUi {
  const factory LandmarkPointUi({
    required double x,
    required double y,
    required double z,
  }) = _LandmarkPointUi;
}

/// Camera resolution presets for UI
enum ResolutionPresetUi {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case ResolutionPresetUi.low:
        return 'Low';
      case ResolutionPresetUi.medium:
        return 'Medium';
      case ResolutionPresetUi.high:
        return 'High';
    }
  }
}
