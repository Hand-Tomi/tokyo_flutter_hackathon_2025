import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// Gemini 스케치 분석 서비스
///
/// 스케치 이미지와 동화 텍스트를 분석하여
/// Imagen 3에 전달할 상세한 장면 설명을 생성
class GeminiSketchAnalyzerService {
  final String apiKey;

  /// Gemini 2.0 Flash (텍스트 분석용)
  static const String _model = 'gemini-2.0-flash';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  GeminiSketchAnalyzerService({required this.apiKey});

  /// 스케치와 동화 텍스트를 분석하여 이미지 생성용 프롬프트 생성
  Future<String> analyzeSketch({
    required Uint8List sketchBytes,
    String storyText = '',
  }) async {
    final sketchBase64 = base64Encode(sketchBytes);
    final prompt = _buildAnalysisPrompt(storyText);

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
            'temperature': 0.3,
            'maxOutputTokens': 500,
          },
        }),
      );

      if (response.statusCode != 200) {
        throw SketchAnalysisException(
          'Gemini API 오류: ${response.statusCode} - ${response.body}',
        );
      }

      final data = jsonDecode(response.body);
      final candidates = data['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw SketchAnalysisException('분석 결과가 없습니다.');
      }

      final parts = candidates[0]['content']['parts'] as List?;
      if (parts == null || parts.isEmpty) {
        throw SketchAnalysisException('응답에 콘텐츠가 없습니다.');
      }

      final text = parts[0]['text'] as String?;
      if (text == null || text.isEmpty) {
        throw SketchAnalysisException('텍스트 응답이 없습니다.');
      }

      return text.trim();
    } catch (e) {
      if (e is SketchAnalysisException) rethrow;
      throw SketchAnalysisException('스케치 분석 실패: $e');
    }
  }

  /// 분석 프롬프트 생성
  String _buildAnalysisPrompt(String storyText) {
    final storyContext = storyText.isNotEmpty
        ? '''
Story context:
"$storyText"
'''
        : '';

    return '''
Analyze this child's sketch and describe the scene for a 2D cartoon image.

$storyContext

Instructions:
1. Describe positions of all drawn elements (e.g., "a star in the upper left", "a castle on the right")
2. Preserve the exact composition and spatial layout
3. Describe only the objects, characters, and their positions
4. DO NOT mention any art style, colors, or visual effects - just describe WHAT is in the scene

Output: One paragraph listing only the objects and their positions. No style descriptions.
''';
  }
}

/// 스케치 분석 예외
class SketchAnalysisException implements Exception {
  final String message;

  SketchAnalysisException(this.message);

  @override
  String toString() => message;
}
