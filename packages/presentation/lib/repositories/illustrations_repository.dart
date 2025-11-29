import 'dart:convert';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:path_provider/path_provider.dart';

/// 일러스트레이션 저장소
///
/// AI가 생성한 동화풍 이미지를 로컬에 저장
/// 경로: media/illustrations/
class IllustrationsRepository implements GeneratedImageRepository {
  static const String _mediaDirName = 'media';
  static const String _illustrationsDirName = 'illustrations';
  static const String _metadataFileName = 'illustrations_metadata.json';

  Directory? _imagesDir;
  File? _metadataFile;

  /// 저장 디렉토리 초기화
  Future<void> _ensureInitialized() async {
    if (_imagesDir != null && _metadataFile != null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final mediaDir = Directory('${appDir.path}/$_mediaDirName');
    _imagesDir = Directory('${mediaDir.path}/$_illustrationsDirName');
    _metadataFile = File('${mediaDir.path}/$_metadataFileName');

    if (!await _imagesDir!.exists()) {
      await _imagesDir!.create(recursive: true);
    }

    if (!await _metadataFile!.exists()) {
      await _metadataFile!.writeAsString('[]');
    }
  }

  /// 메타데이터 로드
  Future<List<GeneratedImage>> _loadMetadata() async {
    await _ensureInitialized();
    final content = await _metadataFile!.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList.map((json) => GeneratedImage.fromJson(json)).toList();
  }

  /// 메타데이터 저장
  Future<void> _saveMetadata(List<GeneratedImage> images) async {
    await _ensureInitialized();
    final jsonList = images.map((img) => img.toJson()).toList();
    await _metadataFile!.writeAsString(jsonEncode(jsonList));
  }

  @override
  Future<GeneratedImage> save(GeneratedImage image) async {
    await _ensureInitialized();

    // 이미지 파일을 저장 디렉토리로 복사
    final sourceFile = File(image.imagePath);
    if (await sourceFile.exists()) {
      final fileName = '${image.id}.png';
      final destPath = '${_imagesDir!.path}/$fileName';
      await sourceFile.copy(destPath);

      // 새 경로로 이미지 업데이트
      final savedImage = image.copyWith(imagePath: destPath);

      // 메타데이터 업데이트
      final images = await _loadMetadata();
      // 중복 방지: 같은 ID가 있으면 제거
      images.removeWhere((img) => img.id == savedImage.id);
      images.insert(0, savedImage); // 최신순으로 맨 앞에 추가
      await _saveMetadata(images);

      return savedImage;
    }

    throw Exception('이미지 파일을 찾을 수 없습니다: ${image.imagePath}');
  }

  @override
  Future<List<GeneratedImage>> getAll() async {
    final images = await _loadMetadata();
    // 최신순 정렬
    images.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return images;
  }

  @override
  Future<GeneratedImage?> getById(String id) async {
    final images = await _loadMetadata();
    try {
      return images.firstWhere((img) => img.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> delete(String id) async {
    await _ensureInitialized();

    final images = await _loadMetadata();
    final image = images.where((img) => img.id == id).firstOrNull;

    if (image != null) {
      // 파일 삭제
      final file = File(image.imagePath);
      if (await file.exists()) {
        await file.delete();
      }

      // 메타데이터에서 제거
      images.removeWhere((img) => img.id == id);
      await _saveMetadata(images);
    }
  }

  @override
  Future<void> deleteAll() async {
    await _ensureInitialized();

    // 모든 이미지 파일 삭제
    if (await _imagesDir!.exists()) {
      await for (final entity in _imagesDir!.list()) {
        if (entity is File) {
          await entity.delete();
        }
      }
    }

    // 메타데이터 초기화
    await _saveMetadata([]);
  }
}
