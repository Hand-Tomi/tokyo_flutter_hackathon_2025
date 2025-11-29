import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'gemini_vision_service.dart';
import 'gemini_image_generation_service.dart';
import 'gemini_sketch_to_image_service.dart';
import 'imagen_generation_service.dart';

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
///
/// 환경 변수 IMAGE_GEN_PROVIDER로 선택:
/// - 'imagen': Imagen 3 API (기본값, 추천)
/// - 'gemini': Gemini 2.0 Flash 이미지 생성
@riverpod
ImageGenerationService imageGenerationService(
  ImageGenerationServiceRef ref,
) {
  final provider = dotenv.env['IMAGE_GEN_PROVIDER'] ?? 'imagen';
  final apiKey = dotenv.env['GEMINI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  if (provider.toLowerCase() == 'gemini') {
    return GeminiImageGenerationService(apiKey: apiKey);
  }
  return ImagenGenerationService(apiKey: apiKey);
}

/// Sketch to Image Service Provider
/// 스케치 + 텍스트 → 동화풍 이미지 변환
@riverpod
SketchToImageService sketchToImageService(SketchToImageServiceRef ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }
  return GeminiSketchToImageService(apiKey: apiKey);
}
