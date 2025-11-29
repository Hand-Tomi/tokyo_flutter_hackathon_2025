import 'dart:io';

import 'package:design_system/step3_scene_list/scene_list_ui_state.dart';
import 'package:design_system/step3_scene_list/scene_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/services/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scene_list_page_view_model.g.dart';

/// 앱 Documents 디렉토리 경로 Provider (캐시용)
@Riverpod(keepAlive: true)
Future<String> appDocumentsPath(Ref ref) async {
  final appDir = await getApplicationDocumentsDirectory();
  return appDir.path;
}

/// 장면 리스트 페이지의 ViewModel
@riverpod
class SceneListPageViewModel extends _$SceneListPageViewModel {
  @override
  PageState<SceneListPageUiState, SceneListPageAction> build() {
    final sceneDataList = ref.watch(sceneListProvider);
    final appPathAsync = ref.watch(appDocumentsPathProvider);

    // 테스트용: 전역 상태가 비어있으면 테스트 Scene 추가 (스케치 포함)
    if (sceneDataList.isEmpty) {
      Future.microtask(() => _setupTestScene());
    }

    // 최신 Scene에 sketchFileName이 있고 illustrationFileName이 없으면 자동 생성
    final latestScene = ref.read(sceneListProvider.notifier).latest;
    if (latestScene != null &&
        latestScene.sketchFileName != null &&
        latestScene.illustrationFileName == null) {
      Future.microtask(() => _generateIllustration(latestScene));
    }

    // 앱 경로가 로드될 때까지 기다림
    final appPath = appPathAsync.valueOrNull;

    final scenes = sceneDataList.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // illustrationFileName이 있고 appPath가 로드되었으면 전체 경로 생성
      String? thumbnailFullPath;
      if (data.illustrationFileName != null && appPath != null) {
        thumbnailFullPath =
            '$appPath/media/illustrations/${data.illustrationFileName}';
      }

      return SceneUi(
        id: data.id,
        sceneNumber: index + 1,
        sttText: data.storyScript ?? '',
        status: _getStatus(data),
        thumbnailPath: thumbnailFullPath,
      );
    }).toList();

    return PageState(
      uiState: SceneListPageUiState(
        scenes: scenes,
        canGenerateVideo: scenes.isNotEmpty &&
            scenes.every((s) => s.status == SceneStatus.completed),
      ),
      action: SceneListPageAction.none(),
    );
  }

  /// 테스트용 Scene 설정 (assets에서 스케치 복사 후 Scene 추가)
  Future<void> _setupTestScene() async {
    try {
      debugPrint('테스트 Scene 설정 시작');

      // 1. assets에서 테스트 이미지 로드
      final byteData = await rootBundle.load(
        'packages/presentation/assets/style_reference.png',
      );

      // 2. media/sketches/ 디렉토리에 저장
      final appDir = await getApplicationDocumentsDirectory();
      final sketchesDir = Directory('${appDir.path}/media/sketches');
      if (!await sketchesDir.exists()) {
        await sketchesDir.create(recursive: true);
      }

      const testSketchFileName = 'test_sketch.png';
      final sketchFile = File('${sketchesDir.path}/$testSketchFileName');
      await sketchFile.writeAsBytes(byteData.buffer.asUint8List());
      debugPrint('테스트 스케치 저장 완료: ${sketchFile.path}');

      // 3. Scene 추가 (sketchFileName 포함)
      ref.read(sceneListProvider.notifier).addScene(
        const SceneData(
          id: 'test_1',
          storyScript: '옛날옛날에 한 왕이 살고 있었어요.',
          sketchFileName: testSketchFileName,
        ),
      );
      debugPrint('테스트 Scene 추가 완료 (sketchFileName: $testSketchFileName)');
    } catch (e) {
      debugPrint('테스트 Scene 설정 실패: $e');
      // 실패해도 기본 Scene은 추가
      ref.read(sceneListProvider.notifier).addScene(
        const SceneData(id: 'test_1', storyScript: 'Test scene'),
      );
    }
  }

  /// 최신 Scene의 스케치를 일러스트로 변환
  Future<void> _generateIllustration(SceneData scene) async {
    try {
      debugPrint('일러스트 생성 시작: ${scene.id}');

      // 스케치 파일 경로 생성
      final appDir = await getApplicationDocumentsDirectory();
      final sketchPath = '${appDir.path}/media/sketches/${scene.sketchFileName}';
      final sketchFile = File(sketchPath);

      if (!await sketchFile.exists()) {
        debugPrint('스케치 파일이 존재하지 않습니다: $sketchPath');
        return;
      }
      final sketchBytes = await sketchFile.readAsBytes();

      // AI 서비스로 일러스트 생성
      final service = await ref.read(sketchToImageServiceProvider.future);
      final result = await service.generateFromSketch(
        sketchBytes: sketchBytes,
        storyText: scene.storyScript ?? '',
      );

      // 생성된 이미지 저장
      final repository = ref.read(illustrationsRepositoryProvider);
      final savedImage = await repository.save(result);
      debugPrint('일러스트 저장 완료: ${savedImage.imagePath}');

      // 파일명만 추출하여 전역 상태 업데이트
      final fileName = savedImage.imagePath.split('/').last;
      ref.read(sceneListProvider.notifier).updateIllustration(
        scene.id,
        fileName,
      );
    } catch (e) {
      debugPrint('일러스트 생성 실패: $e');
      state = state.copyWith(
        action: SceneListPageAction.showError('일러스트 생성 실패: $e'),
      );
    }
  }

  SceneStatus _getStatus(SceneData data) {
    if (data.illustrationFileName != null) return SceneStatus.completed;
    if (data.sketchFileName != null) return SceneStatus.generating;
    return SceneStatus.pending;
  }

  void onFinishedAction() {
    state = state.copyWith(action: SceneListPageAction.none());
  }

  void onAddScenePressed() {
    state = state.copyWith(
      action: SceneListPageAction.navigateToSceneCreation(),
    );
  }

  void onGenerateVideoPressed() {
    state = state.copyWith(
      action: SceneListPageAction.navigateToVideoGeneration(),
    );
  }

  void onSceneTap(String sceneId) {
    // TODO: 장면 상세 보기
  }

  void onSceneDelete(String sceneId) {
    ref.read(sceneListProvider.notifier).removeScene(sceneId);
  }
}
