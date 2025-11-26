import 'package:design_system/hand_tracking/hand_tracking_ui_state.dart';
import 'package:hand_landmarker/hand_landmarker.dart';

/// Hand Domain Model -> UI Model conversion extension
///
/// Converts hand_landmarker types to UI-ready models
extension HandMapper on Hand {
  /// Convert to UI Model
  HandLandmarkUi toUi() {
    return HandLandmarkUi(
      points: landmarks
          .map(
            (l) => LandmarkPointUi(
              x: l.x,
              y: l.y,
              z: l.z,
            ),
          )
          .toList(),
    );
  }
}

/// Landmark extension for individual point conversion
extension LandmarkMapper on Landmark {
  /// Convert to UI Model
  LandmarkPointUi toUi() {
    return LandmarkPointUi(
      x: x,
      y: y,
      z: z,
    );
  }
}
