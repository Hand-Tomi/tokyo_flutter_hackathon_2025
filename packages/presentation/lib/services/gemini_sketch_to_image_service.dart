import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'cartoon_style_processor.dart';

/// Gemini 스케치 → 이미지 변환 서비스
///
/// 아이의 스케치와 동화 텍스트를 Gemini에 전달하여
/// 동화풍 이미지로 변환
///
/// 1. 강화된 프롬프트로 스타일 지정
/// 2. 후처리로 색상 양자화 + 외곽선 강화
class GeminiSketchToImageService implements SketchToImageService {
  final String apiKey;
  final Uint8List? styleReferenceImage;
  final bool enablePostProcessing;

  /// Gemini 2.0 Flash Experimental (이미지 생성 지원)
  static const String _model = 'gemini-2.0-flash-exp';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  /// 간결한 스타일 프롬프트
  static const String _stylePrompt = '''
Convert this sketch to a colorful children's cartoon image.

Style:
- Simple flat colors only (red, blue, yellow, green, orange, pink, brown, white, black)
- NO gradients, NO shading, NO texture
- Thick black outlines around everything
- Cute chibi style for characters
- Clean solid color fills

Rules:
- Keep the same objects from the sketch
- Do NOT add text or words
- Do NOT add new characters
''';

  GeminiSketchToImageService({
    required this.apiKey,
    this.styleReferenceImage,
    this.enablePostProcessing = true, // 후처리 활성화
  });

  @override
  Future<GeneratedImage> generateFromSketch({
    required Uint8List sketchBytes,
    String storyText = '',
  }) async {
    final prompt = _buildPrompt(storyText);
    final sketchBase64 = base64Encode(sketchBytes);

    try {
      // 1단계: 3개의 이미지 후보 생성
      final candidates = await _generateCandidates(sketchBase64, prompt, 3);

      if (candidates.isEmpty) {
        throw SketchToImageException('이미지 생성 결과가 없습니다.');
      }

      // 후보가 1개면 바로 사용
      if (candidates.length == 1) {
        return _processAndSaveImage(candidates[0], prompt);
      }

      // 2단계: AI가 스케치와 가장 비슷한 이미지 선택
      final bestIndex = await _selectBestCandidate(sketchBase64, candidates);
      final bestImage = candidates[bestIndex];

      return _processAndSaveImage(bestImage, prompt);
    } catch (e) {
      if (e is SketchToImageException) rethrow;
      throw SketchToImageException('스케치 이미지 변환 실패: $e');
    }
  }

  /// 여러 이미지 후보 생성
  Future<List<Uint8List>> _generateCandidates(
    String sketchBase64,
    String prompt,
    int count,
  ) async {
    final candidates = <Uint8List>[];

    // 병렬로 여러 이미지 생성 요청
    final futures = List.generate(count, (_) => _generateSingleImage(sketchBase64, prompt));
    final results = await Future.wait(futures, eagerError: false);

    for (final result in results) {
      if (result != null) {
        candidates.add(result);
      }
    }

    return candidates;
  }

  /// 단일 이미지 생성
  Future<Uint8List?> _generateSingleImage(String sketchBase64, String prompt) async {
    final requestParts = <Map<String, dynamic>>[];

    // 레퍼런스 이미지
    if (styleReferenceImage != null) {
      final referenceBase64 = base64Encode(styleReferenceImage!);
      requestParts.add({
        'inlineData': {'mimeType': 'image/png', 'data': referenceBase64}
      });
      requestParts.add({'text': 'Reference style:'});
    }

    // 스케치 이미지
    requestParts.add({
      'inlineData': {'mimeType': 'image/png', 'data': sketchBase64}
    });
    requestParts.add({'text': 'Sketch to transform:'});
    requestParts.add({'text': prompt});

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/models/$_model:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': requestParts}],
          'generationConfig': {
            'responseModalities': ['TEXT', 'IMAGE'],
            'temperature': 0.7, // 다양성을 위해 약간 높임
          },
        }),
      );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      final candidatesList = data['candidates'] as List?;
      if (candidatesList == null || candidatesList.isEmpty) return null;

      final parts = candidatesList[0]['content']['parts'] as List?;
      if (parts == null) return null;

      for (final part in parts) {
        if (part['inlineData'] != null) {
          final imageBase64 = part['inlineData']['data'] as String?;
          if (imageBase64 != null) {
            return base64Decode(imageBase64);
          }
        }
      }
    } catch (e) {
      // 개별 실패는 무시하고 다른 후보 사용
    }
    return null;
  }

  /// AI가 스케치와 가장 비슷한 이미지 선택
  Future<int> _selectBestCandidate(String sketchBase64, List<Uint8List> candidates) async {
    final requestParts = <Map<String, dynamic>>[];

    // 원본 스케치
    requestParts.add({
      'inlineData': {'mimeType': 'image/png', 'data': sketchBase64}
    });
    requestParts.add({'text': 'This is the ORIGINAL SKETCH.'});

    // 후보 이미지들
    for (int i = 0; i < candidates.length; i++) {
      final candidateBase64 = base64Encode(candidates[i]);
      requestParts.add({
        'inlineData': {'mimeType': 'image/png', 'data': candidateBase64}
      });
      requestParts.add({'text': 'Candidate ${i + 1}'});
    }

    // 선택 요청
    requestParts.add({
      'text': '''
Compare each candidate image with the original sketch.
Select the candidate that BEST preserves:
1. The same objects/characters from the sketch
2. The same positions and composition
3. No added characters or objects that weren't in the sketch

Reply with ONLY the number (1, 2, or 3) of the best candidate.
'''
    });

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/models/$_model:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': requestParts}],
          'generationConfig': {
            'temperature': 0.1, // 일관된 선택을 위해 낮춤
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidatesList = data['candidates'] as List?;
        if (candidatesList != null && candidatesList.isNotEmpty) {
          final parts = candidatesList[0]['content']['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            final text = parts[0]['text'] as String? ?? '';
            // 숫자 추출
            final match = RegExp(r'[1-3]').firstMatch(text);
            if (match != null) {
              final index = int.parse(match.group(0)!) - 1;
              if (index >= 0 && index < candidates.length) {
                return index;
              }
            }
          }
        }
      }
    } catch (e) {
      // 선택 실패 시 첫 번째 후보 사용
    }
    return 0;
  }

  /// 이미지 후처리 및 저장
  Future<GeneratedImage> _processAndSaveImage(Uint8List imageBytes, String prompt) async {
    var processedBytes = imageBytes;

    // 후처리 적용
    if (enablePostProcessing) {
      processedBytes = CartoonStyleProcessor.process(
        imageBytes,
        colorReduction: true,
        addOutlines: false,
      );
    }

    final imagePath = await _saveImageBytesToFile(processedBytes);

    return GeneratedImage(
      id: const Uuid().v4(),
      imagePath: imagePath,
      prompt: prompt,
      status: GenerationStatus.completed,
      createdAt: DateTime.now(),
    );
  }

  /// 동화 텍스트를 포함한 전체 프롬프트 생성
  String _buildPrompt(String storyText) {
    if (storyText.isEmpty) {
      return _stylePrompt;
    }

    return '''
$_stylePrompt

Story context: "$storyText"
- Set the background based on the story (night sky, forest, ocean, etc.)
- Show the action from the story (running, jumping, etc.)
''';
  }

  /// 이미지 바이트를 파일로 저장
  Future<String> _saveImageBytesToFile(List<int> bytes) async {
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
