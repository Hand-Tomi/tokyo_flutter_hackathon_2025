import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';
import 'package:presentation/src/logger.dart';

part 'scene_state_provider.g.dart';

/// Scene 리스트 상태 Provider
/// 전 페이지에서 공유되는 전역 상태
@Riverpod(keepAlive: true)
class SceneList extends _$SceneList {
  @override
  List<SceneData> build() {
    logger.d('[SceneList] 초기화');
    return [];
  }

  void addScene(SceneData scene) {
    logger.i('[SceneList] addScene: id=${scene.id}');
    state = [...state, scene];
    logger.d('[SceneList] 현재 Scene 개수: ${state.length}');
  }

  void updateScene(int id, SceneData scene) {
    logger.i('[SceneList] updateScene: id=$id, scene=$scene');
    state = [
      for (final s in state)
        if (s.id == id) scene else s,
    ];
  }

  void updateAudio(int id, String fileName) {
    logger.i('[SceneList] updateAudio: id=$id, fileName=$fileName');
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(audioFileName: fileName) else s,
    ];
  }

  void updateSketch(int id, String fileName) {
    logger.i('[SceneList] updateSketch: id=$id, fileName=$fileName');
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(sketchFileName: fileName) else s,
    ];
  }

  void updateIllustration(int id, String fileName) {
    logger.i('[SceneList] updateIllustration: id=$id, fileName=$fileName');
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(illustrationFileName: fileName) else s,
    ];
  }

  void updateStoryScript(int id, String storyScript) {
    logger.i('[SceneList] updateStoryScript: id=$id, storyScript=$storyScript');
    state = [
      for (final s in state)
        if (s.id == id) s.copyWith(storyScript: storyScript) else s,
    ];
  }

  void removeScene(int id) {
    logger.i('[SceneList] removeScene: id=$id');
    state = state.where((s) => s.id != id).toList();
    logger.d('[SceneList] 현재 Scene 개수: ${state.length}');
  }

  void clear() {
    logger.i('[SceneList] clear');
    state = [];
  }

  SceneData? getById(int id) {
    final result = state.where((s) => s.id == id).firstOrNull;
    logger.d('[SceneList] getById: id=$id, found=${result != null}');
    return result;
  }

  /// 최신 Scene 데이터 반환(마지막에 추가된 것) : 보통 화면에서 사용해서 불러올 데이터
  SceneData? get latest {
    final result = state.lastOrNull;
    logger.d('[SceneList] latest: ${result?.id}');
    return result;
  }
}
