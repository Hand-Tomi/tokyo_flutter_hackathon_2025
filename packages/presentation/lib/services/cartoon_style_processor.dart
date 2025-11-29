import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// 카툰 스타일 이미지 후처리기
///
/// AI 생성 이미지를 카툰 스타일로 변환:
/// 1. 색상 양자화 (제한된 팔레트)
/// 2. 엣지 검출 → 검정 외곽선 추가
class CartoonStyleProcessor {
  /// 카툰 스타일 팔레트 (밝은 단색들 + 중간 톤)
  static final List<img.Color> _cartoonPalette = [
    // 빨강 계열
    img.ColorRgb8(255, 0, 0), // 순수 빨강
    img.ColorRgb8(220, 50, 50), // 약간 어두운 빨강
    img.ColorRgb8(180, 30, 30), // 진한 빨강

    // 파랑 계열
    img.ColorRgb8(0, 100, 255), // 밝은 파랑
    img.ColorRgb8(0, 50, 180), // 진한 파랑
    img.ColorRgb8(30, 144, 255), // 도저 블루

    // 하늘색 계열 (그라데이션 방지용 확장)
    img.ColorRgb8(135, 206, 235), // 하늘색
    img.ColorRgb8(135, 206, 250), // 밝은 하늘색
    img.ColorRgb8(100, 180, 220), // 중간 하늘색
    img.ColorRgb8(173, 216, 230), // 연한 하늘색
    img.ColorRgb8(200, 230, 255), // 아주 연한 하늘색

    // 밤하늘 계열 (어두운 파랑/남색)
    img.ColorRgb8(25, 25, 112), // 미드나잇 블루 #191970
    img.ColorRgb8(0, 0, 51), // 다크 네이비 #000033
    img.ColorRgb8(0, 0, 80), // 진한 남색
    img.ColorRgb8(20, 20, 60), // 어두운 밤하늘
    img.ColorRgb8(40, 40, 100), // 중간 밤하늘
    img.ColorRgb8(70, 70, 130), // 밝은 밤하늘

    // 노랑 계열
    img.ColorRgb8(255, 204, 0), // 골드 노랑
    img.ColorRgb8(255, 255, 0), // 순수 노랑
    img.ColorRgb8(255, 240, 150), // 연한 노랑

    // 초록 계열
    img.ColorRgb8(0, 200, 0), // 밝은 초록
    img.ColorRgb8(0, 128, 0), // 진한 초록
    img.ColorRgb8(50, 180, 50), // 중간 초록
    img.ColorRgb8(144, 238, 144), // 연한 초록

    // 살색/피부톤
    img.ColorRgb8(255, 224, 189), // 밝은 살색
    img.ColorRgb8(255, 205, 148), // 중간 살색
    img.ColorRgb8(210, 180, 140), // 탠
    img.ColorRgb8(255, 235, 205), // 아주 밝은 살색

    // 갈색
    img.ColorRgb8(139, 90, 43), // 갈색
    img.ColorRgb8(101, 67, 33), // 진한 갈색
    img.ColorRgb8(180, 130, 80), // 밝은 갈색
    img.ColorRgb8(210, 180, 140), // 탠/베이지

    // 기타
    img.ColorRgb8(255, 255, 255), // 흰색
    img.ColorRgb8(240, 240, 240), // 오프화이트
    img.ColorRgb8(200, 200, 200), // 밝은 회색
    img.ColorRgb8(128, 128, 128), // 회색
    img.ColorRgb8(255, 165, 0), // 주황
    img.ColorRgb8(255, 200, 100), // 연한 주황
    img.ColorRgb8(255, 105, 180), // 핑크
    img.ColorRgb8(255, 182, 193), // 연한 핑크
    img.ColorRgb8(128, 0, 128), // 보라
    img.ColorRgb8(0, 0, 0), // 검정
  ];

  /// 이미지를 카툰 스타일로 변환
  ///
  /// [imageBytes] 원본 이미지 바이트
  /// [outlineThickness] 외곽선 두께 (기본 2)
  /// [colorReduction] 색상 단순화 강도 (true면 팔레트 적용)
  /// [addOutlines] 외곽선 추가 여부 (기본 false - 색상 양자화만)
  /// [edgeThreshold] 엣지 검출 임계값 (높을수록 적은 엣지, 기본 100)
  static Uint8List process(
    Uint8List imageBytes, {
    int outlineThickness = 2,
    bool colorReduction = true,
    bool addOutlines = false,
    int edgeThreshold = 100,
  }) {
    // 이미지 디코딩
    final original = img.decodeImage(imageBytes);
    if (original == null) {
      throw Exception('이미지 디코딩 실패');
    }

    // 1. 색상 양자화 (단순화) - 현재 비활성화 (번이 많이 발생)
    img.Image processed;
    // TODO: 색상 양자화 개선 후 재활성화
    // if (colorReduction) {
    //   processed = _quantizeColors(original);
    // } else {
    //   processed = original.clone();
    // }
    processed = original.clone();

    // 2. 엣지 검출 및 외곽선 추가 (선택적)
    if (addOutlines) {
      processed = _addOutlines(processed, original, outlineThickness, edgeThreshold);
    }

    // PNG로 인코딩
    return Uint8List.fromList(img.encodePng(processed));
  }

  /// 색상을 팔레트로 양자화
  static img.Image _quantizeColors(img.Image image) {
    final result = image.clone();

    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        final pixel = result.getPixel(x, y);
        final nearestColor = _findNearestColor(pixel);
        result.setPixel(x, y, nearestColor);
      }
    }

    return result;
  }

  /// 가장 가까운 팔레트 색상 찾기
  static img.Color _findNearestColor(img.Pixel pixel) {
    final r = pixel.r.toInt();
    final g = pixel.g.toInt();
    final b = pixel.b.toInt();

    img.Color nearest = _cartoonPalette[0];
    double minDistance = double.infinity;

    for (final color in _cartoonPalette) {
      final cr = color.r.toInt();
      final cg = color.g.toInt();
      final cb = color.b.toInt();

      // 유클리드 거리 계산
      final distance = sqrt(
        pow(r - cr, 2) + pow(g - cg, 2) + pow(b - cb, 2),
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = color;
      }
    }

    return nearest;
  }

  /// Sobel 엣지 검출 후 검정 외곽선 추가
  static img.Image _addOutlines(
    img.Image processed,
    img.Image original,
    int thickness,
    int threshold,
  ) {
    // 그레이스케일로 변환 후 엣지 검출
    final grayscale = img.grayscale(original);
    final edges = _sobelEdgeDetection(grayscale, threshold);

    // 엣지 픽셀을 검정색으로 표시
    final result = processed.clone();
    final black = img.ColorRgb8(0, 0, 0);

    for (int y = 0; y < result.height; y++) {
      for (int x = 0; x < result.width; x++) {
        if (edges[y][x]) {
          // 두께 적용
          for (int dy = -thickness ~/ 2; dy <= thickness ~/ 2; dy++) {
            for (int dx = -thickness ~/ 2; dx <= thickness ~/ 2; dx++) {
              final nx = x + dx;
              final ny = y + dy;
              if (nx >= 0 &&
                  nx < result.width &&
                  ny >= 0 &&
                  ny < result.height) {
                result.setPixel(nx, ny, black);
              }
            }
          }
        }
      }
    }

    return result;
  }

  /// Sobel 엣지 검출
  static List<List<bool>> _sobelEdgeDetection(img.Image grayscale, int threshold) {
    final height = grayscale.height;
    final width = grayscale.width;
    final edges = List.generate(height, (_) => List.filled(width, false));

    // Sobel 커널
    const sobelX = [
      [-1, 0, 1],
      [-2, 0, 2],
      [-1, 0, 1]
    ];
    const sobelY = [
      [-1, -2, -1],
      [0, 0, 0],
      [1, 2, 1]
    ];

    for (int y = 1; y < height - 1; y++) {
      for (int x = 1; x < width - 1; x++) {
        int gx = 0;
        int gy = 0;

        for (int ky = -1; ky <= 1; ky++) {
          for (int kx = -1; kx <= 1; kx++) {
            final pixel = grayscale.getPixel(x + kx, y + ky);
            final intensity = pixel.r.toInt(); // 그레이스케일이므로 R만 사용

            gx += intensity * sobelX[ky + 1][kx + 1];
            gy += intensity * sobelY[ky + 1][kx + 1];
          }
        }

        final magnitude = sqrt(gx * gx + gy * gy);
        edges[y][x] = magnitude > threshold;
      }
    }

    return edges;
  }
}
