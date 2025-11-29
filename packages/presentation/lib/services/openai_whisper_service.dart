import 'dart:convert';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:presentation/src/logger.dart';

/// OpenAI Whisper API를 사용한 STT 서비스 구현
/// https://platform.openai.com/docs/guides/speech-to-text
class OpenAiWhisperService implements SttService {
  final String apiKey;

  OpenAiWhisperService({required this.apiKey});

  @override
  Future<String> transcribe(String audioPath) async {
    final file = File(audioPath);
    if (!await file.exists()) {
      throw Exception('오디오 파일을 찾을 수 없습니다: $audioPath');
    }

    // 파일 크기 확인
    final fileSize = await file.length();

    // 파일이 너무 작으면 비어있거나 손상된 것
    if (fileSize < 1000) {
      throw Exception(
        '오디오 파일이 너무 작습니다 ($fileSize bytes). 녹음이 제대로 되지 않았을 수 있습니다.',
      );
    }

    // 25MB 제한
    if (fileSize > 25 * 1024 * 1024) {
      throw Exception('오디오 파일이 25MB를 초과합니다.');
    }

    // 파일명 추출
    final fileName = audioPath.split('/').last;
    final extension = fileName.split('.').last.toLowerCase();
    final mimeType = _getMimeType(extension);

    logger.i(
      'Whisper API 요청: $fileName, MIME: $mimeType, Size: $fileSize bytes',
    );

    // 파일을 바이트로 읽기
    final fileBytes = await file.readAsBytes();

    // Multipart 요청 생성
    final uri = Uri.parse('https://api.openai.com/v1/audio/transcriptions');
    final request = http.MultipartRequest('POST', uri);

    // 헤더 설정
    request.headers['Authorization'] = 'Bearer $apiKey';

    // 파일 추가
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ),
    );

    // 필드 추가
    request.fields['model'] = 'gpt-4o-transcribe';
    // request.fields['language'] = 'ja';
    // request.fields['response_format'] = 'json';

    try {
      // 요청 전송
      final streamedResponse = await request.send().timeout(
        const Duration(minutes: 2),
      );

      // 응답 읽기
      final responseBody = await streamedResponse.stream.bytesToString();

      logger.i('Whisper API 응답 Status: ${streamedResponse.statusCode}');
      logger.d('Whisper API 응답 Body: $responseBody');

      if (streamedResponse.statusCode == 200) {
        final data = jsonDecode(responseBody) as Map<String, dynamic>;
        final text = data['text'] as String;
        logger.i('STT 결과: $text');
        return text;
      } else {
        // 에러 응답 파싱
        logger.e(
          'Whisper API 에러: ${streamedResponse.statusCode} - $responseBody',
        );
        try {
          final errorData = jsonDecode(responseBody) as Map<String, dynamic>;
          final error = errorData['error'] as Map<String, dynamic>?;
          final message = error?['message'] ?? responseBody;
          throw Exception('Whisper API 오류: $message');
        } catch (e) {
          throw Exception(
            'Whisper API 오류: ${streamedResponse.statusCode} - $responseBody',
          );
        }
      }
    } catch (e) {
      if (e is Exception) rethrow;
      logger.e('Whisper API 예외: $e');
      throw Exception('STT 변환 실패: $e');
    }
  }

  String _getMimeType(String extension) {
    switch (extension) {
      case 'm4a':
        return 'audio/mp4';
      case 'mp3':
        return 'audio/mpeg';
      case 'mp4':
        return 'audio/mp4';
      case 'mpeg':
      case 'mpga':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'webm':
        return 'audio/webm';
      case 'ogg':
        return 'audio/ogg';
      default:
        return 'audio/mp4';
    }
  }
}
