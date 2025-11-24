import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hand_landmarker/hand_landmarker.dart';
import 'package:permission_handler/permission_handler.dart';

class HandTrackingPage extends StatefulWidget {
  const HandTrackingPage({super.key});

  @override
  State<HandTrackingPage> createState() => _HandTrackingPageState();
}

class _HandTrackingPageState extends State<HandTrackingPage> {
  HandLandmarkerPlugin? _plugin;
  CameraController? _controller;
  List<Hand> _landmarks = [];
  bool _isInitialized = false;
  bool _isDetecting = false;
  String _statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // 1. Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        setState(() => _statusMessage = 'Camera permission required');
        return;
      }

      setState(() => _statusMessage = 'Initializing camera...');

      // 2. Get available cameras
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _statusMessage = 'No available cameras');
        return;
      }

      // Select back camera (or first available camera)
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      // 3. Initialize camera controller
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      setState(() => _statusMessage = 'Initializing Hand Landmarker...');

      // 4. Create HandLandmarker plugin
      _plugin = HandLandmarkerPlugin.create(
        numHands: 2, // Detect up to 2 hands
        minHandDetectionConfidence: 0.5, // Minimum confidence 50%
        delegate: HandLandmarkerDelegate.GPU, // Use GPU acceleration
      );

      // 5. Start camera stream
      await _controller!.startImageStream(_processCameraImage);

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _statusMessage = 'Initialization complete! Show your hand to the camera';
        });
      }
    } catch (e) {
      setState(() => _statusMessage = 'Initialization failed: $e');
      debugPrint('Initialization error: $e');
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting || !_isInitialized || _plugin == null) return;

    _isDetecting = true;

    try {
      // Detect hand landmarks
      final hands = _plugin!.detect(
        image,
        _controller!.description.sensorOrientation,
      );

      if (mounted) {
        setState(() {
          _landmarks = hands;
          if (hands.isNotEmpty) {
            _statusMessage = '${hands.length} hand(s) detected!';
            // Debug: Print wrist coordinates of first hand
            if (hands[0].landmarks.isNotEmpty) {
              final wrist = hands[0].landmarks[0];
              debugPrint('Wrist coordinates: (${wrist.x}, ${wrist.y})');
              debugPrint('Image size: ${image.width}x${image.height}');
              debugPrint('Preview size: ${_controller!.value.previewSize}');
              debugPrint('Sensor orientation: ${_controller!.description.sensorOrientation} degrees');
            }
          } else {
            _statusMessage = 'Looking for hands...';
          }
        });
      }
    } catch (e) {
      debugPrint('Detection error: $e');
    } finally {
      _isDetecting = false;
    }
  }

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Tracking Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Status message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade100,
            child: Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          // Camera preview
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      // Camera view (fill screen)
                      CameraPreview(_controller!),
                      // Landmark overlay (full screen)
                      CustomPaint(
                        painter: HandLandmarkPainter(
                          _landmarks,
                          _controller!.value.previewSize!,
                          _controller!.description.sensorOrientation,
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),

          // Detected hand information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detected hands: ${_landmarks.length}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_landmarks.isNotEmpty) ...[
                  for (var i = 0; i < _landmarks.length; i++)
                    Text(
                      'Hand ${i + 1}: ${_landmarks[i].landmarks.length} landmarks',
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter to draw hand landmarks
class HandLandmarkPainter extends CustomPainter {
  final List<Hand> hands;
  final Size imageSize;
  final int sensorOrientation;

  HandLandmarkPainter(this.hands, this.imageSize, this.sensorOrientation);

  // MediaPipe hand landmark connection structure
  static const List<List<int>> connections = [
    // From wrist to each finger
    [0, 1], [1, 2], [2, 3], [3, 4], // Thumb
    [0, 5], [5, 6], [6, 7], [7, 8], // Index
    [0, 9], [9, 10], [10, 11], [11, 12], // Middle
    [0, 13], [13, 14], [14, 15], [15, 16], // Ring
    [0, 17], [17, 18], [18, 19], [19, 20], // Pinky
    // Palm connections
    [5, 9], [9, 13], [13, 17], [0, 17],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (hands.isEmpty) return;

    final pointPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final hand in hands) {
      final landmarks = hand.landmarks;

      // Draw connection lines
      for (final connection in connections) {
        final start = landmarks[connection[0]];
        final end = landmarks[connection[1]];

        final p1 = _transformPoint(start.x, start.y, size);
        final p2 = _transformPoint(end.x, end.y, size);

        canvas.drawLine(p1, p2, linePaint);
      }

      // Draw landmark points
      for (final landmark in landmarks) {
        final point = _transformPoint(landmark.x, landmark.y, size);
        canvas.drawCircle(point, 6, pointPaint);
      }
    }
  }

  Offset _transformPoint(double x, double y, Size size) {
    // Transform coordinates based on sensor orientation
    double transformedX, transformedY;

    if (sensorOrientation == 90) {
      // 90 degree rotation: (x, y) -> (1-y, x)
      transformedX = 1 - y;
      transformedY = x;
    } else if (sensorOrientation == 270) {
      // 270 degree rotation: (x, y) -> (y, 1-x)
      transformedX = y;
      transformedY = 1 - x;
    } else if (sensorOrientation == 180) {
      // 180 degree rotation: (x, y) -> (1-x, 1-y)
      transformedX = 1 - x;
      transformedY = 1 - y;
    } else {
      // 0 degree (no rotation)
      transformedX = x;
      transformedY = y;
    }

    // Scale to screen size
    final dx = transformedX * size.width;
    final dy = transformedY * size.height;

    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(HandLandmarkPainter oldDelegate) {
    return true;
  }
}
