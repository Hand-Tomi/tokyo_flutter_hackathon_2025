import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:domain/domain.dart';

part 'slideshow_state_provider.g.dart';

/// Slideshow 리스트 상태 Provider
/// 전 페이지에서 공유되는 전역 상태
@Riverpod(keepAlive: true)
class SlideshowList extends _$SlideshowList {
  int _nextId = 1;

  @override
  List<SlideshowData> build() => [];

  void addSlideshow({
    required String title,
    required String fileName,
    String? thumbnailPath,
  }) {
    final slideshow = SlideshowData(
      id: _nextId++,
      title: title,
      fileName: fileName,
      thumbnailPath: thumbnailPath,
    );
    state = [...state, slideshow];
  }

  void removeSlideshow(int id) {
    state = state.where((s) => s.id != id).toList();
  }

  void clear() {
    state = [];
    _nextId = 1;
  }

  SlideshowData? getById(int id) {
    return state.where((s) => s.id == id).firstOrNull;
  }

  SlideshowData? get latest => state.lastOrNull;
}
