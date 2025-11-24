import 'dart:io';
import 'dart:convert';
import 'package:domain/domain.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class GeminiVisionService implements VisionService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiVisionService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
  }

  @override
  Future<ImageAnalysis> analyzeImage(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();

    final prompt = TextPart('''
이 이미지를 상세히 분석해주세요.

다음 정보를 JSON 형식으로 제공해주세요:
{
  "sceneType": "풍경 종류 (한글로, 예: 산, 바다, 도시, 숲, 사막, 호수, 계곡, 공원 등 자유롭게)",
  "tags": ["태그1", "태그2", "태그3", "태그4", "태그5"],
  "description": "1000자 내외의 상세한 분석..."
}

분석 내용:
1. 풍경의 종류를 한글로 자유롭게 표현 (예: 산, 바다, 도시, 숲, 사막, 호수, 계곡, 공원, 해변, 들판 등)
2. 이미지의 주요 특징을 나타내는 한글 태그 5개
3. 이미지의 분위기, 색감, 구도, 시간대, 날씨 등을 포함한 상세 설명 (한글, 1000자 내외)

반드시 JSON 형식으로만 응답해주세요.
''');

    final imagePart = DataPart('image/jpeg', imageBytes);

    final response = await _model.generateContent([
      Content.multi([prompt, imagePart])
    ]);

    final text = response.text ?? '';

    // JSON 파싱
    final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (jsonMatch == null) {
      throw Exception('JSON 응답을 찾을 수 없습니다: $text');
    }

    final jsonData = jsonDecode(jsonMatch.group(0)!);

    return ImageAnalysis(
      id: const Uuid().v4(),
      originalImagePath: imagePath,
      analysisText: jsonData['description'] as String,
      sceneType: jsonData['sceneType'] as String,  // 이미 한글이니까 그대로 사용
      tags: (jsonData['tags'] as List).cast<String>(),
      createdAt: DateTime.now(),
    );
  }
}
