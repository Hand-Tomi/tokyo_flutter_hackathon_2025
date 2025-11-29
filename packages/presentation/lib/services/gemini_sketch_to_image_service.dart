import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Gemini 스케치 → 이미지 변환 서비스
///
/// 아이의 스케치와 동화 텍스트를 Gemini에 전달하여
/// 동화풍 이미지로 변환
class GeminiSketchToImageService implements SketchToImageService {
  final String apiKey;

  /// Gemini 2.0 Flash Experimental (이미지 생성 지원)
  static const String _model = 'gemini-2.0-flash-exp-image-generation';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  /// 고정 스타일 프롬프트 (동화풍)
  static const String _stylePrompt = '''
Transform this child's simple sketch into a warm, magical children's book illustration.

Style requirements:
- Soft watercolor style with gentle, visible brush strokes
- Warm pastel color palette (soft pink, light blue, cream yellow, mint green)
- Dreamy, magical, and comforting atmosphere
- Rounded and friendly shapes
- Keep the original sketch's composition and shapes as the base structure
- Add subtle sparkles or magical elements where appropriate
- Soft shadows and gentle lighting
''';

  GeminiSketchToImageService({required this.apiKey});

  @override
  Future<GeneratedImage> generateFromSketch({
    required Uint8List sketchBytes,
    String storyText = '',
  }) async {
    final prompt = _buildPrompt(storyText);
    final sketchBase64 = base64Encode(sketchBytes);

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/models/$_model:generateContent?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'inlineData': {
                    'mimeType': 'image/png',
                    'data': sketchBase64,
                  }
                },
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'responseModalities': ['TEXT', 'IMAGE'],
          },
        }),
      );

      if (response.statusCode != 200) {
        throw SketchToImageException(
          'Gemini API 오류: ${response.statusCode} - ${response.body}',
        );
      }

      final data = jsonDecode(response.body);

      // 응답에서 이미지 데이터 추출
      final candidates = data['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw SketchToImageException('이미지 생성 결과가 없습니다.');
      }

      final parts = candidates[0]['content']['parts'] as List?;
      if (parts == null || parts.isEmpty) {
        throw SketchToImageException('응답에 콘텐츠가 없습니다.');
      }

      // 이미지 파트 찾기
      String? imageBase64;
      for (final part in parts) {
        if (part['inlineData'] != null) {
          imageBase64 = part['inlineData']['data'] as String?;
          break;
        }
      }

      if (imageBase64 == null) {
        throw SketchToImageException('생성된 이미지를 찾을 수 없습니다.');
      }

      // Base64 이미지를 파일로 저장
      final imagePath = await _saveImageToFile(imageBase64);

      return GeneratedImage(
        id: const Uuid().v4(),
        imagePath: imagePath,
        prompt: prompt,
        status: GenerationStatus.completed,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      if (e is SketchToImageException) rethrow;
      throw SketchToImageException('스케치 이미지 변환 실패: $e');
    }
  }

  /// 동화 텍스트를 포함한 전체 프롬프트 생성
  String _buildPrompt(String storyText) {
    if (storyText.isEmpty) {
      return _stylePrompt;
    }

    return '''
$_stylePrompt

Story context (use this to inform the mood and elements):
"$storyText"

Generate an illustration that captures the essence of this story moment while transforming the sketch into a beautiful children's book style image.
''';
  }

  /// Base64 이미지를 파일로 저장
  Future<String> _saveImageToFile(String base64Image) async {
    final bytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        'story_sketch_${DateTime.now().millisecondsSinceEpoch}.png';
    final filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }
}

/// 스케치 → 이미지 변환 예외
class SketchToImageException implements Exception {
  final String message;

  SketchToImageException(this.message);

  @override
  String toString() => message;
}
