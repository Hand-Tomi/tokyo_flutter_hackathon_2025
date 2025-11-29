import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/// fal.ai Video Generation Service
///
/// Image-to-Video generation using fal.ai Kling wrapper API
/// API Documentation: https://fal.ai/models/fal-ai/kling-video
class FalVideoGenerationService {
  FalVideoGenerationService({
    required this.apiKey,
  });

  final String apiKey;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static const String _baseUrl = 'https://queue.fal.run';
  static const String _resultBaseUrl = 'https://queue.fal.run';

  /// Create image-to-video generation task
  ///
  /// [imageBytes] - Image data as bytes
  /// [fileName] - Original file name to determine MIME type
  /// [prompt] - Text prompt for video generation
  /// [duration] - Video duration: '5' or '10' seconds
  /// [model] - Model version: 'v1/standard', 'v1.5/pro', 'v1.6/pro', 'v2/master', 'v2.1/master'
  Future<FalTaskResult> createImageToVideoTask({
    required Uint8List imageBytes,
    required String fileName,
    String? prompt,
    String duration = '5',
    String model = 'v1/standard',
  }) async {
    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.i('🎬 [FAL.AI] Creating Image-to-Video Task');
    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.d('📁 File: $fileName');
    _logger.d('📏 Image size: ${imageBytes.length} bytes (${(imageBytes.length / 1024).toStringAsFixed(2)} KB)');
    _logger.d('⏱️ Duration: ${duration}s');
    _logger.d('🤖 Model: $model');
    _logger.d('📝 Prompt: ${prompt ?? "(default)"}');

    if (imageBytes.isEmpty) {
      _logger.e('❌ Image data is empty!');
      throw FalApiException('Image data is empty');
    }

    // Convert to base64 data URI (fal.ai supports this format)
    final extension = fileName.split('.').last.toLowerCase();
    final mimeType = _getMimeType(extension);
    final imageBase64 = base64Encode(imageBytes);
    final dataUri = 'data:$mimeType;base64,$imageBase64';

    _logger.d('🔄 Converting image to base64 data URI');
    _logger.d('📎 MIME type: $mimeType');
    _logger.d('📊 Base64 length: ${imageBase64.length} chars');

    final url = '$_baseUrl/fal-ai/kling-video/$model/image-to-video';
    _logger.i('📤 POST $url');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Key $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'image_url': dataUri,
        'prompt': prompt ?? 'Generate a natural video from this image',
        'duration': duration,
        'cfg_scale': 0.5,
      }),
    );

    _logger.i('📥 Response: ${response.statusCode}');
    _logger.d('📄 Response body: ${response.body}');

    return _handleSubmitResponse(response);
  }

  /// Query task status
  Future<FalTaskStatus> queryTaskStatus(String requestId) async {
    _logger.d('🔍 [FAL.AI] Querying status for request: $requestId');

    final response = await http.get(
      Uri.parse('$_resultBaseUrl/fal-ai/kling-video/requests/$requestId/status'),
      headers: {
        'Authorization': 'Key $apiKey',
      },
    );

    _logger.d('📥 Status response: ${response.statusCode}');

    return _handleStatusResponse(response, requestId);
  }

  /// Get task result
  Future<FalVideoResult> getTaskResult(String requestId) async {
    _logger.i('📦 [FAL.AI] Getting result for request: $requestId');

    final response = await http.get(
      Uri.parse('$_resultBaseUrl/fal-ai/kling-video/requests/$requestId'),
      headers: {
        'Authorization': 'Key $apiKey',
      },
    );

    _logger.i('📥 Result response: ${response.statusCode}');
    _logger.d('📄 Result body: ${response.body}');

    return _handleResultResponse(response);
  }

  /// Poll for task completion with progress updates
  Future<FalVideoResult> pollForCompletion({
    required String requestId,
    void Function(FalTaskStatus status)? onProgress,
    int maxAttempts = 120,
    Duration interval = const Duration(seconds: 5),
  }) async {
    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.i('🔄 [FAL.AI] Starting polling for request: $requestId');
    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.d('⏱️ Max attempts: $maxAttempts, Interval: ${interval.inSeconds}s');

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final status = await queryTaskStatus(requestId);
      onProgress?.call(status);

      _logger.i('📊 [Attempt ${attempt + 1}/$maxAttempts] Status: ${status.status}');
      if (status.queuePosition != null) {
        _logger.d('📍 Queue position: ${status.queuePosition}');
      }

      switch (status.status) {
        case 'COMPLETED':
          _logger.i('✅ [FAL.AI] Video generation COMPLETED!');
          return getTaskResult(requestId);

        case 'FAILED':
          _logger.e('❌ [FAL.AI] Video generation FAILED: ${status.error}');
          throw FalApiException('Video generation failed: ${status.error ?? "Unknown error"}');

        case 'IN_QUEUE':
          _logger.d('⏳ Status: IN_QUEUE - waiting ${interval.inSeconds}s...');
          await Future<void>.delayed(interval);

        case 'IN_PROGRESS':
          _logger.d('🎬 Status: IN_PROGRESS - waiting ${interval.inSeconds}s...');
          await Future<void>.delayed(interval);

        default:
          _logger.w('⚠️ Unknown status: ${status.status} - waiting ${interval.inSeconds}s...');
          await Future<void>.delayed(interval);
      }
    }

    _logger.e('❌ [FAL.AI] Timeout after $maxAttempts attempts');
    throw FalApiException('Timeout: Video generation did not complete within expected time');
  }

  FalTaskResult _handleSubmitResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    // fal.ai queue API returns 200 or 202 (Accepted) for successful submissions
    if (response.statusCode != 200 && response.statusCode != 202) {
      final detail = body['detail'] as String? ?? 'Unknown error';
      _logger.e('❌ [FAL.AI] Submit failed: ${response.statusCode} - $detail');
      throw FalApiException('API error (${response.statusCode}): $detail');
    }

    final requestId = body['request_id'] as String?;
    if (requestId == null) {
      _logger.e('❌ [FAL.AI] Invalid response: missing request_id');
      throw FalApiException('Invalid response: missing request_id');
    }

    final status = body['status'] as String? ?? 'IN_QUEUE';
    _logger.i('✅ [FAL.AI] Task submitted successfully!');
    _logger.i('🆔 Request ID: $requestId');
    _logger.i('📊 Initial status: $status');

    return FalTaskResult(
      requestId: requestId,
      status: status,
    );
  }

  FalTaskStatus _handleStatusResponse(http.Response response, String requestId) {
    // Accept 200 and 202 as success codes
    if (response.statusCode != 200 && response.statusCode != 202) {
      _logger.e('❌ [FAL.AI] Failed to get status: ${response.statusCode}');
      throw FalApiException('Failed to get status: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final status = body['status'] as String? ?? 'UNKNOWN';
    final queuePosition = body['queue_position'] as int?;
    final error = body['error'] as String?;

    if (error != null) {
      _logger.w('⚠️ [FAL.AI] Status error: $error');
    }

    return FalTaskStatus(
      requestId: requestId,
      status: status,
      queuePosition: queuePosition,
      error: error,
    );
  }

  FalVideoResult _handleResultResponse(http.Response response) {
    if (response.statusCode != 200) {
      _logger.e('❌ [FAL.AI] Failed to get result: ${response.statusCode}');
      throw FalApiException('Failed to get result: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final video = body['video'] as Map<String, dynamic>?;

    if (video == null) {
      _logger.e('❌ [FAL.AI] Invalid response: missing video field');
      throw FalApiException('Invalid response: missing video field');
    }

    final url = video['url'] as String? ?? '';
    final contentType = video['content_type'] as String?;
    final fileName = video['file_name'] as String?;
    final fileSize = video['file_size'] as int?;

    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.i('🎉 [FAL.AI] Video Generation Result');
    _logger.i('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.i('🔗 URL: $url');
    _logger.d('📎 Content-Type: $contentType');
    _logger.d('📁 File name: $fileName');
    if (fileSize != null) {
      _logger.d('📏 File size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB');
    }

    return FalVideoResult(
      url: url,
      contentType: contentType,
      fileName: fileName,
      fileSize: fileSize,
    );
  }

  String _getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}

/// Result from submitting a new task
class FalTaskResult {
  const FalTaskResult({
    required this.requestId,
    required this.status,
  });

  final String requestId;
  final String status;
}

/// Task status
class FalTaskStatus {
  const FalTaskStatus({
    required this.requestId,
    required this.status,
    this.queuePosition,
    this.error,
  });

  final String requestId;
  final String status;
  final int? queuePosition;
  final String? error;

  /// Calculate progress percentage based on status
  double get progressPercentage {
    switch (status) {
      case 'IN_QUEUE':
        return 0.1;
      case 'IN_PROGRESS':
        return 0.5;
      case 'COMPLETED':
        return 1.0;
      case 'FAILED':
        return 0.0;
      default:
        return 0.0;
    }
  }
}

/// Generated video result
class FalVideoResult {
  const FalVideoResult({
    required this.url,
    this.contentType,
    this.fileName,
    this.fileSize,
  });

  final String url;
  final String? contentType;
  final String? fileName;
  final int? fileSize;
}

/// fal.ai API Exception
class FalApiException implements Exception {
  FalApiException(this.message);

  final String message;

  @override
  String toString() => 'FalApiException: $message';
}
