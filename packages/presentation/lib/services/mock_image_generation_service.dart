import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

/// Mock 이미지 생성 서비스
///
/// 실제 AI 서비스 대신 테스트용 Mock 구현
/// 추후 Imagen 3 등 실제 서비스로 교체 예정
class MockImageGenerationService implements ImageGenerationService {
  @override
  Future<GeneratedImage> generateImage(ImageAnalysis analysis) async {
    // 실제 API 호출을 시뮬레이션하기 위한 딜레이
    await Future.delayed(const Duration(seconds: 2));

    // Mock 이미지 URL (unsplash에서 랜덤 이미지)
    final mockImageUrl = 'https://source.unsplash.com/800x600/?${analysis.sceneType}';

    // 분석 결과를 기반으로 프롬프트 생성
    final prompt = '${analysis.sceneType} 풍경, ${analysis.tags.join(", ")}';

    return GeneratedImage(
      id: const Uuid().v4(),
      imagePath: mockImageUrl,
      prompt: prompt,
      status: GenerationStatus.completed,
      createdAt: DateTime.now(),
    );
  }
}
