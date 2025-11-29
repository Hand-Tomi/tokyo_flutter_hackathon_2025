// Conditional export for hand_landmarker
// Uses stub on web, real implementation on mobile

export 'hand_landmarker_stub.dart'
    if (dart.library.io) 'hand_landmarker_mobile.dart';
