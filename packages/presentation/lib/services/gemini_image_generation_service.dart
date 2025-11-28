import 'dart:convert';
import 'dart:io';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Gemini 이미지 생성 서비스
///
/// Google Gemini API를 직접 HTTP로 호출하여 이미지 생성
/// Gemini 2.0 Flash Experimental의 이미지 생성 기능 사용
class GeminiImageGenerationService implements ImageGenerationService {
  final String apiKey;

  /// Gemini 2.0 Flash Experimental (이미지 생성 지원)
  static const String _model = 'gemini-2.0-flash-exp-image-generation';
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';

  GeminiImageGenerationService({required this.apiKey});

  @override
  Future<GeneratedImage> generateImage(ImageAnalysis analysis) async {
    final prompt = _createPromptFromAnalysis(analysis);

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
        throw ImageGenerationException(
          'Gemini API 오류: ${response.statusCode} - ${response.body}',
        );
      }

      final data = jsonDecode(response.body);

      // 응답에서 이미지 데이터 추출
      final candidates = data['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw ImageGenerationException('이미지 생성 결과가 없습니다.');
      }

      final parts = candidates[0]['content']['parts'] as List?;
      if (parts == null || parts.isEmpty) {
        throw ImageGenerationException('응답에 콘텐츠가 없습니다.');
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
        throw ImageGenerationException('생성된 이미지를 찾을 수 없습니다.');
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
      if (e is ImageGenerationException) rethrow;
      throw ImageGenerationException('이미지 생성 실패: $e');
    }
  }

  /// 분석 결과를 기반으로 이미지 생성 프롬프트 생성
  String _createPromptFromAnalysis(ImageAnalysis analysis) {
    final theme = analysis.sceneType;
    final tags = analysis.tags.join(', ');
    final description = analysis.analysisText;

    return '''
Generate a stunning photorealistic landscape image based on the following analysis:

Theme: $theme
Key elements: $tags
Scene description: $description

Style requirements:
- Ultra high quality, 8K resolution, professional photography
- Cinematic lighting with dramatic atmosphere
- Vibrant and natural colors
- Highly detailed textures
- Wide aspect ratio suitable for landscape (16:9)
''';
  }

  /// Base64 이미지를 파일로 저장
  Future<String> _saveImageToFile(String base64Image) async {
    final bytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'generated_${DateTime.now().millisecondsSinceEpoch}.png';
    final filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }
}

/// 이미지 생성 예외
class ImageGenerationException implements Exception {
  final String message;

  ImageGenerationException(this.message);

  @override
  String toString() => message;
}
