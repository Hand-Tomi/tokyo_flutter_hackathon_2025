import 'dart:convert';
import 'dart:io';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Imagen 3 이미지 생성 서비스
///
/// Google Vertex AI의 Imagen 3 API를 사용하여 이미지 생성
/// API 문서: https://cloud.google.com/vertex-ai/generative-ai/docs/image/generate-images
class ImagenGenerationService implements ImageGenerationService {
  final String apiKey;

  /// Imagen 3 모델 사용
  /// 옵션: imagen-3.0-generate-002 (최신), imagen-3.0-fast-generate-001 (빠름)
  static const String _model = 'imagen-3.0-generate-002';

  ImagenGenerationService({required this.apiKey});

  @override
  Future<GeneratedImage> generateImage(ImageAnalysis analysis) async {
    final prompt = _createPromptFromAnalysis(analysis);

    try {
      // Imagen 3 API 호출 (Generative Language API 사용)
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/$_model:predict?key=$apiKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'instances': [
            {
              'prompt': prompt,
            },
          ],
          'parameters': {
            'sampleCount': 1,
            'aspectRatio': '16:9',  // 풍경에 적합한 비율
            'safetyFilterLevel': 'block_few',
            'personGeneration': 'allow_adult',
          },
        }),
      );

      if (response.statusCode != 200) {
        throw ImageGenerationException(
          'Imagen API 오류: ${response.statusCode} - ${response.body}',
        );
      }

      final data = jsonDecode(response.body);

      // 응답에서 이미지 데이터 추출
      final predictions = data['predictions'] as List?;
      if (predictions == null || predictions.isEmpty) {
        throw ImageGenerationException('이미지 생성 결과가 없습니다.');
      }

      final imageBase64 = predictions[0]['bytesBase64Encoded'] as String?;
      if (imageBase64 == null) {
        throw ImageGenerationException('이미지 데이터를 찾을 수 없습니다.');
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
  ///
  /// 분석에서 받아온 테마, 태그, 설명을 모두 활용
  String _createPromptFromAnalysis(ImageAnalysis analysis) {
    final theme = analysis.sceneType;  // 한글 테마 (예: 산, 바다, 도시)
    final tags = analysis.tags.join(', ');  // 한글 태그들
    final description = analysis.analysisText;  // 이미 500자 이내로 요약됨

    return '''
A stunning photorealistic landscape photograph.
Theme: $theme
Key elements: $tags
Scene details: $description
Style: Ultra high quality, 8K resolution, professional photography, cinematic lighting, vibrant colors, detailed textures.
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
