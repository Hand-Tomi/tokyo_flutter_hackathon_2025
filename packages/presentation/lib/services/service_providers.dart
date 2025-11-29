import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'fal_video_generation_service.dart';
import 'kling_video_generation_service.dart';

part 'service_providers.g.dart';

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
