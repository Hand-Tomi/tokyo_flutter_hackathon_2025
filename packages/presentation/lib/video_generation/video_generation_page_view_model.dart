import 'dart:async';

import 'package:design_system/video_generation/video_generation_ui.dart';
import 'package:design_system/video_generation/video_generation_ui_state.dart';
import 'package:domain/video_generation.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/utils/formatters.dart';
import 'package:presentation/video_generation/video_generation_mapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

// Domain enums (VideoApiType, OutputFormat, VideoGenerationStatus) are used directly

part 'video_generation_page_view_model.g.dart';

/// 비디오 생성 페이지의 ViewModel
///
/// 비즈니스 로직과 상태 관리를 담당
@riverpod
class VideoGenerationPageViewModel extends _$VideoGenerationPageViewModel {
  // 진행 상황 구독
  StreamSubscription<VideoGenerationProgress>? _progressSubscription;

  @override
  PageState<VideoGenerationPageUiState, VideoGenerationPageAction> build() {
    // 구독 해제
    ref.onDispose(() {
      _progressSubscription?.cancel();
    });

    return PageState(
      uiState: VideoGenerationPageUiState(),
      action: VideoGenerationPageAction.none(),
    );
  }

  /// 액션 완료 시 상태 리셋
  void onFinishedAction() {
    state = state.copyWith(action: VideoGenerationPageAction.none());
  }

  /// 이미지 선택 버튼 눌림
  void onSelectImagesPressed() {
    state = state.copyWith(action: VideoGenerationPageAction.showImagePicker());
  }

  /// 오디오 선택 버튼 눌림
  void onSelectAudioPressed() {
    state = state.copyWith(action: VideoGenerationPageAction.showAudioPicker());
  }

  /// 이미지 추가
  void onImagesSelected(List<SelectedImageInfo> images) {
    final newImages = images.map((info) {
      return FileInfoMapper.createImageUi(
        id: const Uuid().v4(),
        path: info.path,
        fileName: info.fileName,
        fileSizeBytes: info.fileSizeBytes,
        thumbnailPath: info.thumbnailPath,
      );
    }).toList();

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        selectedImages: [...state.uiState.selectedImages, ...newImages],
      ),
    );
  }

  /// 이미지 제거
  void onRemoveImage(String id) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        selectedImages: state.uiState.selectedImages
            .where((image) => image.id != id)
            .toList(),
      ),
    );
  }

  /// 오디오 선택
  void onAudioSelected(SelectedAudioInfo audio) {
    final audioUi = FileInfoMapper.createAudioUi(
      id: const Uuid().v4(),
      path: audio.path,
      fileName: audio.fileName,
      fileSizeBytes: audio.fileSizeBytes,
      durationMs: audio.durationMs,
    );

    state = state.copyWith(
      uiState: state.uiState.copyWith(selectedAudio: audioUi),
    );
  }

  /// 오디오 제거
  void onRemoveAudio() {
    state = state.copyWith(
      uiState: state.uiState.copyWith(selectedAudio: null),
    );
  }

  /// API 타입 변경
  void onApiTypeChanged(VideoApiType apiType) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(selectedApiType: apiType),
    );
  }

  /// 출력 형식 변경
  void onOutputFormatChanged(OutputFormat format) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(selectedOutputFormat: format),
    );
  }

  /// 프롬프트 변경
  void onPromptChanged(String prompt) {
    state = state.copyWith(
      uiState: state.uiState.copyWith(prompt: prompt),
    );
  }

  /// 비디오 생성 시작
  Future<void> onGeneratePressed() async {
    // 이미지가 없으면 에러
    if (state.uiState.selectedImages.isEmpty) {
      state = state.copyWith(
        action: VideoGenerationPageAction.showError('이미지를 선택해주세요'),
      );
      return;
    }

    // 로딩 시작
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isLoading: true,
        isGenerating: true,
        progress: VideoGenerationProgressUi(
          status: VideoGenerationStatus.pending,
          progress: 0.0,
          progressPercentage: '0%',
          message: '비디오 생성 준비 중...',
        ),
      ),
    );

    try {
      // 시뮬레이션: 실제 구현 시 외부 API 호출로 대체
      await _simulateVideoGeneration();
    } on Object catch (e) {
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isLoading: false,
          isGenerating: false,
          progress: null,
        ),
        action: VideoGenerationPageAction.showError('비디오 생성에 실패했습니다: $e'),
      );
    }
  }

  /// 비디오 생성 시뮬레이션 (실제 구현 시 API 호출로 대체)
  Future<void> _simulateVideoGeneration() async {
    // 이미지 처리 단계
    await _updateProgress(
      VideoGenerationStatus.processingImages,
      0.2,
      '이미지 분석 중...',
    );
    await Future<void>.delayed(const Duration(seconds: 2));

    // 오디오 처리 단계 (오디오가 있는 경우)
    if (state.uiState.selectedAudio != null) {
      await _updateProgress(
        VideoGenerationStatus.processingAudio,
        0.4,
        '오디오 처리 중...',
      );
      await Future<void>.delayed(const Duration(seconds: 2));
    }

    // 비디오 생성 단계
    await _updateProgress(
      VideoGenerationStatus.generatingVideo,
      0.6,
      '비디오 생성 중...',
    );
    await Future<void>.delayed(const Duration(seconds: 3));

    // 진행률 업데이트
    await _updateProgress(
      VideoGenerationStatus.generatingVideo,
      0.8,
      '비디오 인코딩 중...',
    );
    await Future<void>.delayed(const Duration(seconds: 2));

    // 완료
    await _updateProgress(
      VideoGenerationStatus.completed,
      1.0,
      '완료!',
    );

    // 결과 생성
    final generatedVideo = GeneratedVideoUi(
      id: const Uuid().v4(),
      outputPath: '/path/to/generated_video.${state.uiState.selectedOutputFormat.name}',
      format: state.uiState.selectedOutputFormat,
      durationFormatted: '00:15',
      fileSizeFormatted: '12.5 MB',
      thumbnailPath: null,
      createdAtFormatted: Formatters.formatDateTime(DateTime.now()),
    );

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isLoading: false,
        isGenerating: false,
        progress: null,
        generatedVideo: generatedVideo,
      ),
      action: VideoGenerationPageAction.showGenerationComplete(
        generatedVideo.outputPath,
      ),
    );
  }

  Future<void> _updateProgress(
    VideoGenerationStatus status,
    double progress,
    String message,
  ) async {
    state = state.copyWith(
      uiState: state.uiState.copyWith(
        progress: VideoGenerationProgressUi(
          status: status,
          progress: progress,
          progressPercentage: '${(progress * 100).toInt()}%',
          message: message,
        ),
      ),
    );
  }

  /// 비디오 생성 취소
  void onCancelGeneration() {
    _progressSubscription?.cancel();

    state = state.copyWith(
      uiState: state.uiState.copyWith(
        isLoading: false,
        isGenerating: false,
        progress: null,
      ),
    );
  }

  /// 비디오 미리보기
  void onPreviewVideo() {
    final video = state.uiState.generatedVideo;
    if (video != null) {
      state = state.copyWith(
        action: VideoGenerationPageAction.showVideoPreview(video.outputPath),
      );
    }
  }

  /// 비디오 공유
  void onShareVideo() {
    final video = state.uiState.generatedVideo;
    if (video != null) {
      state = state.copyWith(
        action: VideoGenerationPageAction.shareVideo(video.outputPath),
      );
    }
  }

}

/// 선택된 이미지 정보 (파일 선택 결과)
class SelectedImageInfo {
  const SelectedImageInfo({
    required this.path,
    required this.fileName,
    required this.fileSizeBytes,
    this.thumbnailPath,
  });

  final String path;
  final String fileName;
  final int fileSizeBytes;
  final String? thumbnailPath;
}

/// 선택된 오디오 정보 (파일 선택 결과)
class SelectedAudioInfo {
  const SelectedAudioInfo({
    required this.path,
    required this.fileName,
    required this.fileSizeBytes,
    required this.durationMs,
  });

  final String path;
  final String fileName;
  final int fileSizeBytes;
  final int durationMs;
}
