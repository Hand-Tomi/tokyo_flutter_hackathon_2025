import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_data.freezed.dart';
part 'scene_data.g.dart';

@freezed
class SceneData with _$SceneData {
  const factory SceneData({
    required int id,
    String? audioFileName,
    String? sketchFileName,
    String? illustrationFileName,
    String? storyScript,
  }) = _SceneData;

  factory SceneData.fromJson(Map<String, dynamic> json) =>
      _$SceneDataFromJson(json);
}
