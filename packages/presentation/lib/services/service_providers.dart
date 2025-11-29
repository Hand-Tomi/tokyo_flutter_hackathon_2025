import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'kling_video_generation_service.dart';

part 'service_providers.g.dart';

/// Kling Video Generation Service Provider
/// Image-to-Video using Kling AI API
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
