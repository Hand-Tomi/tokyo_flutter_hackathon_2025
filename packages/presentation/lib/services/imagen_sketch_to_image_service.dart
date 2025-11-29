import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'gemini_sketch_analyzer_service.dart';
import 'gemini_sketch_to_image_service.dart' show SketchToImageException;

/// Imagen 3 스케치 → 이미지 변환 서비스
///
/// 2단계 접근법:
/// 1. Gemini로 스케치 분석 → 상세 장면 설명 생성
/// 2. Imagen 3로 이미지 생성
class ImagenSketchToImageService implements SketchToImageService {
  final String apiKey;
  late final GeminiSketchAnalyzerService _analyzerService;

  /// Imagen 3 모델
  static const String _model = 'imagen-3.0-generate-002';

  /// 동화풍 스타일 프롬프트 (2등신 카툰 스타일)
  static const String _stylePrompt = '''
Digital vector illustration in the exact style of Dora the Explorer cartoon.

Character design:
- 2-head-tall proportions (head is half of total body height)
- Large round head with big expressive eyes
- Small compact body with short arms and legs
- Simple hands and feet

Art style:
- THICK BLACK OUTLINES around everything (4-5 pixel strokes)
- FLAT SOLID COLORS only - no shading, no gradients
- Bright saturated colors: red, blue, yellow, green
- Clean digital cartoon look, NOT painterly or watercolor
''';

  ImagenSketchToImageService({required this.apiKey}) {
    _analyzerService = GeminiSketchAnalyzerService(apiKey: apiKey);
  }

  @override
  Future<GeneratedImage> generateFromSketch({
    required Uint8List sketchBytes,
    String storyText = '',
  }) async {
    try {
      // 1단계: Gemini로 스케치 분석
      final sceneDescription = await _analyzerService.analyzeSketch(
        sketchBytes: sketchBytes,
        storyText: storyText,
      );

      // 2단계: Imagen 3로 이미지 생성
      // 스타일을 맨 앞에 배치하여 강하게 적용
      final fullPrompt = '$_stylePrompt\n\nScene: $sceneDescription';

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
              'prompt': fullPrompt,
            },
          ],
          'parameters': {
            'sampleCount': 1,
            'aspectRatio': '1:1',
            'safetyFilterLevel': 'block_few',
            'personGeneration': 'allow_all',
          },
        }),
      );

      if (response.statusCode != 200) {
        throw SketchToImageException(
          'Imagen API 오류: ${response.statusCode} - ${response.body}',
        );
      }

      final data = jsonDecode(response.body);
      final predictions = data['predictions'] as List?;
      if (predictions == null || predictions.isEmpty) {
        throw SketchToImageException('이미지 생성 결과가 없습니다.');
      }

      final imageBase64 = predictions[0]['bytesBase64Encoded'] as String?;
      if (imageBase64 == null) {
        throw SketchToImageException('이미지 데이터를 찾을 수 없습니다.');
      }

      // Base64 이미지를 파일로 저장
      final imagePath = await _saveImageToFile(imageBase64);

      return GeneratedImage(
        id: const Uuid().v4(),
        imagePath: imagePath,
        prompt: fullPrompt,
        status: GenerationStatus.completed,
        createdAt: DateTime.now(),
      );
    } on SketchAnalysisException catch (e) {
      throw SketchToImageException('스케치 분석 실패: ${e.message}');
    } catch (e) {
      if (e is SketchToImageException) rethrow;
      throw SketchToImageException('이미지 생성 실패: $e');
    }
  }

  /// Base64 이미지를 파일로 저장
  Future<String> _saveImageToFile(String base64Image) async {
    final bytes = base64Decode(base64Image);
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        'story_imagen_${DateTime.now().millisecondsSinceEpoch}.png';
    final filePath = '${directory.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }
}
