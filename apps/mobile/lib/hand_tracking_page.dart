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
  String _statusMessage = '초기화 중...';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // 1. 카메라 권한 요청
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        setState(() => _statusMessage = '카메라 권한이 필요합니다');
        return;
      }

      setState(() => _statusMessage = '카메라 초기화 중...');

      // 2. 카메라 목록 가져오기
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _statusMessage = '사용 가능한 카메라가 없습니다');
        return;
      }

      // 후면 카메라 선택 (없으면 첫 번째 카메라)
      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      // 3. 카메라 컨트롤러 초기화
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      setState(() => _statusMessage = 'Hand Landmarker 초기화 중...');

      // 4. HandLandmarker 플러그인 생성
      _plugin = HandLandmarkerPlugin.create(
        numHands: 2, // 최대 2개의 손 감지
        minHandDetectionConfidence: 0.5, // 신뢰도 50% 이상
        delegate: HandLandmarkerDelegate.GPU, // GPU 가속 사용
      );

      // 5. 카메라 스트림 시작
      await _controller!.startImageStream(_processCameraImage);

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _statusMessage = '초기화 완료! 손을 카메라에 보여주세요';
        });
      }
    } catch (e) {
      setState(() => _statusMessage = '초기화 실패: $e');
      debugPrint('초기화 에러: $e');
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting || !_isInitialized || _plugin == null) return;

    _isDetecting = true;

    try {
      // 손 랜드마크 감지
      final hands = _plugin!.detect(
        image,
        _controller!.description.sensorOrientation,
      );

      if (mounted) {
        setState(() {
          _landmarks = hands;
          if (hands.isNotEmpty) {
            _statusMessage = '${hands.length}개의 손 감지됨!';
            // 디버깅: 첫 번째 손의 손목 좌표 출력
            if (hands[0].landmarks.isNotEmpty) {
              final wrist = hands[0].landmarks[0];
              debugPrint('손목 좌표: (${wrist.x}, ${wrist.y})');
              debugPrint('이미지 크기: ${image.width}x${image.height}');
              debugPrint('화면 크기: ${_controller!.value.previewSize}');
              debugPrint('센서 방향: ${_controller!.description.sensorOrientation}도');
            }
          } else {
            _statusMessage = '손을 찾는 중...';
          }
        });
      }
    } catch (e) {
      debugPrint('감지 에러: $e');
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
          // 상태 메시지
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

          // 카메라 프리뷰
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      // 카메라 화면 (전체 화면 채우기)
                      CameraPreview(_controller!),
                      // 랜드마크 오버레이 (전체 화면)
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

          // 감지된 손 정보
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '감지된 손: ${_landmarks.length}개',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_landmarks.isNotEmpty) ...[
                  for (var i = 0; i < _landmarks.length; i++)
                    Text(
                      '손 ${i + 1}: 랜드마크 ${_landmarks[i].landmarks.length}개',
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

// 손 랜드마크를 그리는 CustomPainter
class HandLandmarkPainter extends CustomPainter {
  final List<Hand> hands;
  final Size imageSize;
  final int sensorOrientation;

  HandLandmarkPainter(this.hands, this.imageSize, this.sensorOrientation);

  // MediaPipe 손 랜드마크 연결 구조
  static const List<List<int>> connections = [
    // 손목에서 각 손가락 시작점으로
    [0, 1], [1, 2], [2, 3], [3, 4], // 엄지
    [0, 5], [5, 6], [6, 7], [7, 8], // 검지
    [0, 9], [9, 10], [10, 11], [11, 12], // 중지
    [0, 13], [13, 14], [14, 15], [15, 16], // 약지
    [0, 17], [17, 18], [18, 19], [19, 20], // 새끼
    // 손바닥 연결
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

      // 연결선 그리기
      for (final connection in connections) {
        final start = landmarks[connection[0]];
        final end = landmarks[connection[1]];

        final p1 = _transformPoint(start.x, start.y, size);
        final p2 = _transformPoint(end.x, end.y, size);

        canvas.drawLine(p1, p2, linePaint);
      }

      // 랜드마크 포인트 그리기
      for (final landmark in landmarks) {
        final point = _transformPoint(landmark.x, landmark.y, size);
        canvas.drawCircle(point, 6, pointPaint);
      }
    }
  }

  Offset _transformPoint(double x, double y, Size size) {
    // 센서 방향에 따라 좌표 변환
    double transformedX, transformedY;

    if (sensorOrientation == 90) {
      // 90도 회전: (x, y) -> (1-y, x)
      transformedX = 1 - y;
      transformedY = x;
    } else if (sensorOrientation == 270) {
      // 270도 회전: (x, y) -> (y, 1-x)
      transformedX = y;
      transformedY = 1 - x;
    } else if (sensorOrientation == 180) {
      // 180도 회전: (x, y) -> (1-x, 1-y)
      transformedX = 1 - x;
      transformedY = 1 - y;
    } else {
      // 0도 (회전 없음)
      transformedX = x;
      transformedY = y;
    }

    // 화면 크기에 맞춰 스케일 조정
    final dx = transformedX * size.width;
    final dy = transformedY * size.height;

    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(HandLandmarkPainter oldDelegate) {
    return true;
  }
}
