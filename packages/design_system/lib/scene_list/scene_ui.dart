import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_ui.freezed.dart';

/// 장면 상태
enum SceneStatus {
  pending, // 대기 중
  generating, // 이미지 생성 중
  completed, // 완료
  error, // 오류
}

/// 장면 UI 모델
@freezed
class SceneUi with _$SceneUi {
  const factory SceneUi({
    required String id,
    required int sceneNumber,
    required String sttText,
    required SceneStatus status,
    String? thumbnailPath,
  }) = _SceneUi;
}
