import 'package:design_system/step2_scene_creation/scene_creation_ui_state.dart';
import 'package:domain/domain.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/services/service_providers.dart';
import 'package:presentation/services/scene_state_provider.dart';
import 'package:presentation/src/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scene_creation_page_view_model.g.dart';

/// 장면 생성 페이지의 ViewModel
@riverpod
class SceneCreationPageViewModel extends _$SceneCreationPageViewModel {
  /// 현재 생성 중인 Scene의 ID
  int? _currentSceneId;

  @override
  PageState<SceneCreationPageUiState, SceneCreationPageAction> build() {
    return PageState(
      uiState: const SceneCreationPageUiState(),
      action: SceneCreationPageAction.none(),
    );
  }

  /// 액션 완료 시 리셋
  void onFinishedAction() {
    state = state.copyWith(action: SceneCreationPageAction.none());
  }

  /// 녹음 시작
  Future<void> onRecordPressed() async {
    // 이미 녹음 중이면 무시
    if (state.uiState.isRecording) return;

    final recorder = ref.read(audioRecorderServiceProvider);

    // 마이크 권한 확인
    final hasPermission = await recorder.hasPermission();
    if (!hasPermission) {
      state = state.copyWith(
        action: SceneCreationPageAction.showError('마이크 권한이 필요합니다.'),
      );
      return;
    }

    // 새로운 Scene ID 생성 (기존 Scene 개수 + 1)
    final sceneList = ref.read(sceneListProvider);
    _currentSceneId = sceneList.length + 1;

    // Scene 추가 (녹음 시작 시)
    ref.read(sceneListProvider.notifier).addScene(
      SceneData(id: _currentSceneId!),
    );
    logger.i('Scene 추가됨: id=$_currentSceneId');

    // 먼저 UI 상태 업데이트 (버튼 즉시 변경)
    state = state.copyWith(uiState: state.uiState.copyWith(isRecording: true));

    // 파일명 생성
    final fileName =
        'scene_${state.uiState.sceneNumber}_${DateTime.now().millisecondsSinceEpoch}';

    try {
      final path = await recorder.startRecording(fileName);
      logger.i('recording file path = $path');
      // 녹음 시작 시 경로 저장
      state = state.copyWith(
        uiState: state.uiState.copyWith(currentRecordingPath: path),
      );
    } catch (e) {
      // 실패 시 상태 롤백 및 Scene 삭제
      if (_currentSceneId != null) {
        ref.read(sceneListProvider.notifier).removeScene(_currentSceneId!);
      }
      state = state.copyWith(
        uiState: state.uiState.copyWith(isRecording: false),
        action: SceneCreationPageAction.showError('녹음 시작 실패: $e'),
      );
    }
  }

  /// 녹음 중지 + STT 변환
  Future<void> onStopRecordPressed() async {
    // 녹음 중이 아니면 무시
    if (!state.uiState.isRecording) return;

    final recorder = ref.read(audioRecorderServiceProvider);
    final sttService = ref.read(sttServiceProvider);

    // 먼저 UI 상태 업데이트 (녹음 중지 표시)
    state = state.copyWith(
      uiState: state.uiState.copyWith(isRecording: false, isSttLoading: true),
    );

    try {
      var audioPath = await recorder.stopRecording();
      // stopRecording이 null이면 시작 시 저장한 경로 사용
      if (audioPath == null || audioPath.isEmpty) {
        audioPath = state.uiState.currentRecordingPath;
      }
      if (audioPath.isEmpty) {
        throw Exception('녹음 파일을 찾을 수 없습니다.');
      }
      logger.d('recorded audioPath = $audioPath');

      state = state.copyWith(
        uiState: state.uiState.copyWith(currentRecordingPath: audioPath),
      );

      // 녹음 완료 시 오디오 파일명 업데이트
      if (_currentSceneId != null) {
        final audioFileName = audioPath.split('/').last;
        ref.read(sceneListProvider.notifier).updateAudio(
          _currentSceneId!,
          audioFileName,
        );
        logger.i('Scene 오디오 업데이트: id=$_currentSceneId, audio=$audioFileName');
      }

      // STT 변환 실행
      final transcribedText = await sttService.transcribe(audioPath);

      // STT 완료 시 스토리 스크립트 업데이트
      if (_currentSceneId != null) {
        ref.read(sceneListProvider.notifier).updateStoryScript(
          _currentSceneId!,
          transcribedText,
        );
        logger.i('Scene 스토리 업데이트: id=$_currentSceneId, text=$transcribedText');
      }

      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isSttLoading: false,
          currentStep: SceneCreationStep.sttResult,
          sttText: transcribedText,
        ),
      );
    } catch (e) {
      logger.e('SST 변환 실패', error: e);
      state = state.copyWith(
        uiState: state.uiState.copyWith(isSttLoading: false),
        action: SceneCreationPageAction.showError('STT 변환 실패: $e'),
      );
    }
  }

  /// 재녹음
  void onReRecordPressed() {
    // 현재 Scene 삭제
    if (_currentSceneId != null) {
      ref.read(sceneListProvider.notifier).removeScene(_currentSceneId!);
      logger.i('재녹음으로 인한 Scene 삭제: id=$_currentSceneId');
      _currentSceneId = null;
    }

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        currentStep: SceneCreationStep.recording,
        sttText: '',
        currentRecordingPath: '',
      ),
    );
  }

  /// 다음 단계로 이동
  void onNextStepPressed() {
    final currentStep = state.uiState.currentStep;

    switch (currentStep) {
      case SceneCreationStep.recording:
        state = state.copyWith(
          uiState: state.uiState.copyWith(currentStep: SceneCreationStep.sttResult),
        );
        break;
      case SceneCreationStep.sttResult:
        state = state.copyWith(
          uiState: state.uiState.copyWith(currentStep: SceneCreationStep.airScribble),
        );
        break;
      case SceneCreationStep.airScribble:
        // airScribble 이후에는 바로 장면 리스트로 이동
        state = state.copyWith(
          action: SceneCreationPageAction.navigateToSceneList(),
        );
        break;
    }
  }

  /// 그림 지우기
  void onClearDrawingPressed() {
    // TODO: 실제 그림 지우기 로직
  }

}
