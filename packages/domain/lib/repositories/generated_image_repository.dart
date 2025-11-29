import '../generated_image.dart';

/// 생성된 이미지 저장소 인터페이스
///
/// 스케치에서 생성된 동화풍 이미지를 로컬에 저장하고 조회
abstract class GeneratedImageRepository {
  /// 이미지 저장
  Future<GeneratedImage> save(GeneratedImage image);

  /// 모든 이미지 조회 (최신순)
  Future<List<GeneratedImage>> getAll();

  /// ID로 이미지 조회
  Future<GeneratedImage?> getById(String id);

  /// 이미지 삭제
  Future<void> delete(String id);

  /// 모든 이미지 삭제
  Future<void> deleteAll();
}
