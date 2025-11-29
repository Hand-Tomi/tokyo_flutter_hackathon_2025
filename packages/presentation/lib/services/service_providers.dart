import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../repositories/illustrations_repository.dart';
import 'gemini_vision_service.dart';
import 'gemini_image_generation_service.dart';
import 'gemini_sketch_to_image_service.dart';
import 'imagen_generation_service.dart';
import 'imagen_sketch_to_image_service.dart';
import 'fal_video_generation_service.dart';
import 'kling_video_generation_service.dart';

part 'service_providers.g.dart';

/// 일러스트레이션 저장소 Provider
/// AI가 생성한 동화풍 이미지 저장
@riverpod
GeneratedImageRepository illustrationsRepository(IllustrationsRepositoryRef ref) {
  return IllustrationsRepository();
}

/// 저장된 일러스트레이션 목록 Provider
/// 다른 기능에서 생성된 이미지를 참조할 때 사용
@riverpod
Future<List<GeneratedImage>> savedIllustrations(SavedIllustrationsRef ref) async {
  final repository = ref.watch(illustrationsRepositoryProvider);
  return repository.getAll();
}

/// 스타일 레퍼런스 이미지 Provider
/// assets에서 레퍼런스 이미지를 로드
@riverpod
Future<Uint8List?> styleReferenceImage(StyleReferenceImageRef ref) async {
  try {
    final byteData = await rootBundle.load('packages/presentation/assets/style_reference.png');
    return byteData.buffer.asUint8List();
  } catch (e) {
    // 레퍼런스 이미지가 없으면 null 반환
    return null;
  }
}

/// Vision Service Provider
/// Gemini 2.5 Flash 고정
@riverpod
GeminiVisionService visionService(VisionServiceRef ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  return GeminiVisionService(apiKey: apiKey);
}

/// Image Generation Service Provider
/// Gemini 2.0 Flash Experimental 고정
@riverpod
GeminiImageGenerationService imageGenerationService(ImageGenerationServiceRef ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  return GeminiImageGenerationService(apiKey: apiKey);
}

/// Video Generation Provider Type
enum VideoGenProvider { fal, kling }

/// Current Video Generation Provider
@riverpod
VideoGenProvider videoGenProvider(VideoGenProviderRef ref) {
  final provider = dotenv.env['VIDEO_GEN_PROVIDER']?.toLowerCase() ?? 'fal';
  return provider == 'kling' ? VideoGenProvider.kling : VideoGenProvider.fal;
}

/// fal.ai Video Generation Service Provider
/// Image-to-Video using fal.ai Kling wrapper (recommended)
@riverpod
FalVideoGenerationService falVideoGenerationService(
  FalVideoGenerationServiceRef ref,
) {
  final apiKey = dotenv.env['FAL_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('FAL_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  return FalVideoGenerationService(apiKey: apiKey);
}

/// Kling Video Generation Service Provider (Direct API)
/// Image-to-Video using Kling AI API directly
@riverpod
KlingVideoGenerationService klingVideoGenerationService(
  KlingVideoGenerationServiceRef ref,
) {
  final accessKey = dotenv.env['KLING_ACCESS_KEY'];
  final secretKey = dotenv.env['KLING_SECRET_KEY'];

  if (accessKey == null || accessKey.isEmpty) {
    throw Exception('KLING_ACCESS_KEY가 .env 파일에 설정되지 않았습니다.');
  }
  if (secretKey == null || secretKey.isEmpty) {
    throw Exception('KLING_SECRET_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  return KlingVideoGenerationService(
    accessKey: accessKey,
    secretKey: secretKey,
  );
}

/// Sketch to Image Service Provider
/// 스케치 + 텍스트 → 동화풍 이미지 변환
///
/// 환경 변수 SKETCH_TO_IMAGE_PROVIDER로 선택:
/// - 'imagen': Gemini 분석 + Imagen 3 생성 (2단계, 추천)
/// - 'gemini': Gemini 직접 이미지 생성 (기본값, 레퍼런스 이미지 지원)
@riverpod
Future<SketchToImageService> sketchToImageService(
  SketchToImageServiceRef ref,
) async {
  final provider = dotenv.env['SKETCH_TO_IMAGE_PROVIDER'] ?? 'gemini';
  final apiKey = dotenv.env['GEMINI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY가 .env 파일에 설정되지 않았습니다.');
  }

  if (provider.toLowerCase() == 'imagen') {
    return ImagenSketchToImageService(apiKey: apiKey);
  }

  // Gemini 사용 시 레퍼런스 이미지 로드
  final styleReference = await ref.watch(styleReferenceImageProvider.future);
  return GeminiSketchToImageService(
    apiKey: apiKey,
    styleReferenceImage: styleReference,
  );
}
