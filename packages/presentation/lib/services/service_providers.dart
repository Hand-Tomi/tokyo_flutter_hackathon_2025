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
