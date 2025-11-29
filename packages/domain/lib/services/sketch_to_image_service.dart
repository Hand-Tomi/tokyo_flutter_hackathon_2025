import 'dart:typed_data';

import '../generated_image.dart';

/// 스케치를 이미지로 변환하는 서비스 인터페이스
///
/// 아이의 스케치와 동화 텍스트를 받아 동화풍 이미지로 변환
abstract class SketchToImageService {
  /// 스케치 이미지와 텍스트를 기반으로 동화풍 이미지 생성
  ///
  /// [sketchBytes] 스케치 이미지 (PNG 바이트)
  /// [storyText] 동화 텍스트 (음성에서 변환된 텍스트)
  /// Returns 생성된 이미지 정보
  Future<GeneratedImage> generateFromSketch({
    required Uint8List sketchBytes,
    required String storyText,
  });
}
