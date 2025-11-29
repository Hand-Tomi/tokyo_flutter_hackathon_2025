import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';

part 'scene_state_provider.g.dart';

/// Scene 리스트 상태 Provider
/// 전 페이지에서 공유되는 전역 상태
@Riverpod(keepAlive: true)
class SceneList extends _$SceneList {
  @override
  List<SceneData> build() => [];

  void addScene(SceneData scene) {
    state = [...state, scene];
  }

  void updateScene(String id, SceneData scene) {
    state = [
      for (final s in state)
        if (s.id == id) scene else s,
    ];
  }

  void updateAudio(String id, String fileName) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(audioFileName: fileName) else s,
    ];
  }

  void updateSketch(String id, String fileName) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(sketchFileName: fileName) else s,
    ];
  }

  void updateIllustration(String id, String fileName) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(illustrationFileName: fileName) else s,
    ];
  }

  void updateStoryScript(String id, String storyScript) {
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(storyScript: storyScript) else s,
    ];
  }

  void removeScene(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  void clear() {
    state = [];
  }

  SceneData? getById(String id) {
    return state.where((s) => s.id == id).firstOrNull;
  }

  /// 최신 Scene 데이터 반환(마지막에 추가된 것) : 보통 화면에서 사용해서 불러올 데이터
  SceneData? get latest => state.lastOrNull;
}
