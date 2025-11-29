import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// Kling AI Video Generation Service
///
/// Image-to-Video generation using Kling AI API
/// API Documentation: https://docs.klingai.com
class KlingVideoGenerationService {
  KlingVideoGenerationService({
    required this.accessKey,
    required this.secretKey,
  });

  final String accessKey;
  final String secretKey;

  static const String _baseUrl = 'https://api.klingai.com';

  /// Generate JWT token for API authentication
  String _generateJwtToken() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = now + 1800; // 30 minutes expiration
    final nbf = now - 5; // Not before: 5 seconds ago

    // Header
    final header = {'typ': 'JWT', 'alg': 'HS256'};
    final headerBase64 = base64Url.encode(utf8.encode(jsonEncode(header))).replaceAll('=', '');

    // Payload
    final payload = {
      'iss': accessKey,
      'exp': exp,
      'nbf': nbf,
    };
    final payloadBase64 = base64Url.encode(utf8.encode(jsonEncode(payload))).replaceAll('=', '');

    // Signature
    final message = '$headerBase64.$payloadBase64';
    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final signature = hmac.convert(utf8.encode(message));
    final signatureBase64 = base64Url.encode(signature.bytes).replaceAll('=', '');

    return '$headerBase64.$payloadBase64.$signatureBase64';
  }

  /// Create image-to-video generation task
  ///
  /// [imageBytes] - Image data as bytes (works on web and mobile)
  /// [fileName] - Original file name to determine MIME type
  /// [prompt] - Optional text prompt for video generation
  /// [duration] - Video duration: '5' or '10' seconds
  /// [mode] - Generation mode: 'std' (standard) or 'pro' (professional)
  Future<KlingTaskResult> createImageToVideoTask({
    required Uint8List imageBytes,
    required String fileName,
    String? prompt,
    String duration = '5',
    String mode = 'std',
  }) async {
    final token = _generateJwtToken();

    if (imageBytes.isEmpty) {
      throw KlingApiException('Image data is empty');
    }

    // Kling API expects raw base64 string without data URI prefix
    final imageBase64 = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('$_baseUrl/v1/videos/image2video'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model_name': 'kling-v1',
        'image': imageBase64,
        if (prompt != null && prompt.isNotEmpty) 'prompt': prompt,
        'cfg_scale': 0.5,
        'mode': mode,
        'duration': duration,
      }),
    );

    return _handleTaskResponse(response);
  }

  /// Query task status
  ///
  /// [taskId] - The task ID returned from createImageToVideoTask
  Future<KlingTaskStatus> queryTaskStatus(String taskId) async {
    final token = _generateJwtToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/v1/videos/image2video/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    return _handleStatusResponse(response);
  }

  /// Poll for task completion with progress updates
  ///
  /// [taskId] - The task ID to poll
  /// [onProgress] - Callback for progress updates
  /// [maxAttempts] - Maximum polling attempts (default: 120 = ~10 minutes)
  /// [interval] - Polling interval (default: 5 seconds)
  Future<KlingVideoResult> pollForCompletion({
    required String taskId,
    void Function(KlingTaskStatus status)? onProgress,
    int maxAttempts = 120,
    Duration interval = const Duration(seconds: 5),
  }) async {
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final status = await queryTaskStatus(taskId);
      onProgress?.call(status);

      switch (status.taskStatus) {
        case 'completed':
          if (status.videos.isEmpty) {
            throw KlingApiException('Task completed but no video was generated');
          }
          return status.videos.first;

        case 'failed':
          throw KlingApiException('Video generation failed: ${status.taskStatusMsg}');

        case 'submitted':
        case 'processing':
          await Future<void>.delayed(interval);

        default:
          await Future<void>.delayed(interval);
      }
    }

    throw KlingApiException('Timeout: Video generation did not complete within expected time');
  }

  KlingTaskResult _handleTaskResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final code = body['code'] as int? ?? response.statusCode;
      final message = body['message'] as String? ?? 'Unknown error';
      throw KlingApiException('API error ($code): $message');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw KlingApiException('Invalid response: missing data field');
    }

    return KlingTaskResult(
      taskId: data['task_id'] as String,
      taskStatus: data['task_status'] as String? ?? 'submitted',
    );
  }

  KlingTaskStatus _handleStatusResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final code = body['code'] as int? ?? response.statusCode;
      final message = body['message'] as String? ?? 'Unknown error';
      throw KlingApiException('API error ($code): $message');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw KlingApiException('Invalid response: missing data field');
    }

    final videos = <KlingVideoResult>[];
    final worksData = data['task_result']?['videos'] as List<dynamic>?;
    if (worksData != null) {
      for (final work in worksData) {
        final workMap = work as Map<String, dynamic>;
        videos.add(KlingVideoResult(
          id: workMap['id'] as String? ?? '',
          url: workMap['url'] as String? ?? '',
          duration: workMap['duration'] as String? ?? '',
        ));
      }
    }

    return KlingTaskStatus(
      taskId: data['task_id'] as String,
      taskStatus: data['task_status'] as String,
      taskStatusMsg: data['task_status_msg'] as String?,
      createdAt: data['created_at'] as int? ?? 0,
      updatedAt: data['updated_at'] as int? ?? 0,
      videos: videos,
    );
  }

}

/// Result from creating a new task
class KlingTaskResult {
  const KlingTaskResult({
    required this.taskId,
    required this.taskStatus,
  });

  final String taskId;
  final String taskStatus;
}

/// Task status with video results
class KlingTaskStatus {
  const KlingTaskStatus({
    required this.taskId,
    required this.taskStatus,
    this.taskStatusMsg,
    required this.createdAt,
    required this.updatedAt,
    required this.videos,
  });

  final String taskId;
  final String taskStatus;
  final String? taskStatusMsg;
  final int createdAt;
  final int updatedAt;
  final List<KlingVideoResult> videos;

  /// Calculate progress percentage based on status
  double get progressPercentage {
    switch (taskStatus) {
      case 'submitted':
        return 0.1;
      case 'processing':
        return 0.5;
      case 'completed':
        return 1.0;
      case 'failed':
        return 0.0;
      default:
        return 0.0;
    }
  }
}

/// Generated video result
class KlingVideoResult {
  const KlingVideoResult({
    required this.id,
    required this.url,
    required this.duration,
  });

  final String id;
  final String url;
  final String duration;
}

/// Kling API Exception
class KlingApiException implements Exception {
  KlingApiException(this.message);

  final String message;

  @override
  String toString() => 'KlingApiException: $message';
}
