import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'gemini_vision_service.dart';
import 'mock_image_generation_service.dart';

part 'service_providers.g.dart';

/// Vision Service Provider
/// Gemini 2.5 Flash 고정
@riverpod
VisionService visionService(VisionServiceRef ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }
  return GeminiVisionService(apiKey: apiKey);
}

/// Image Generation Service Provider
/// Mock 서비스 (추후 Imagen 3로 교체 예정)
@riverpod
ImageGenerationService imageGenerationService(
  ImageGenerationServiceRef ref,
) {
  return MockImageGenerationService();
}
