import '../image_analysis.dart';
import '../generated_image.dart';

/// 이미지 생성 서비스 인터페이스
///
/// 분석 결과를 기반으로 새로운 이미지를 생성하는 AI 서비스의 추상화
abstract class ImageGenerationService {
  /// 이미지 분석 결과를 기반으로 새로운 이미지 생성
  ///
  /// [analysis] 이미지 분석 결과 (프롬프트 생성에 사용)
  /// Returns 생성된 이미지 정보
  Future<GeneratedImage> generateImage(ImageAnalysis analysis);
}
