import '../image_analysis.dart';

/// 이미지 분석 서비스의 추상 인터페이스
abstract class VisionService {
  /// 이미지를 분석하여 ImageAnalysis를 반환합니다.
  ///
  /// [imagePath]: 분석할 이미지 파일 경로
  ///
  /// 반환: 분석 결과를 담은 ImageAnalysis 객체
  ///
  /// 예외: 분석 실패 시 Exception 발생
  Future<ImageAnalysis> analyzeImage(String imagePath);
}
