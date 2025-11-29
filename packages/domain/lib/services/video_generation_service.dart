import 'package:domain/generated_video.dart';
import 'package:domain/scene_data.dart';

/// 진행 상황 콜백 타입
typedef ProgressCallback = void Function(double progress, String message);

/// 동영상 생성 서비스 인터페이스
abstract class VideoGenerationService {
  /// Scene 리스트를 기반으로 동영상 생성
  ///
  /// [scenes]: 장면 데이터 리스트
  /// [mediaBasePath]: 미디어 파일 기본 경로 (media/)
  /// [onProgress]: 진행 상황 콜백
  ///
  /// Returns: 생성된 동영상 정보
  Future<GeneratedVideo> generateVideo({
    required List<SceneData> scenes,
    required String mediaBasePath,
    ProgressCallback? onProgress,
  });
}
