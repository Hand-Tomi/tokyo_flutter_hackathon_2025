import 'dart:typed_data';

import 'package:design_system/video_generation/video_generation_ui.dart';
import 'package:design_system/video_generation/video_generation_ui_state.dart';
import 'package:domain/video_generation.dart';
import 'package:logger/logger.dart';
import 'package:presentation/page_state.dart';
import 'package:presentation/services/fal_video_generation_service.dart';
import 'package:presentation/services/kling_video_generation_service.dart';
import 'package:presentation/services/service_providers.dart';
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
  // 이미지 바이트 저장소 (ID → bytes)
  final Map<String, Uint8List> _imageBytes = {};

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  PageState<VideoGenerationPageUiState, VideoGenerationPageAction> build() {
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
      final id = const Uuid().v4();
      // 바이트 데이터 저장
      _imageBytes[id] = info.bytes;

      return FileInfoMapper.createImageUi(
        id: id,
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
    // 바이트 데이터도 제거
    _imageBytes.remove(id);

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
    _logger.i('═══════════════════════════════════════════');
    _logger.i('🎬 [ViewModel] Video Generation Started');
    _logger.i('═══════════════════════════════════════════');

    // 이미지가 없으면 에러
    if (state.uiState.selectedImages.isEmpty) {
      _logger.w('⚠️ [ViewModel] No images selected');
      state = state.copyWith(
        action: VideoGenerationPageAction.showError('이미지를 선택해주세요'),
      );
      return;
    }

    _logger.d('📸 Selected images: ${state.uiState.selectedImages.length}');
    _logger.d('📝 Prompt: ${state.uiState.prompt.isEmpty ? "(empty)" : state.uiState.prompt}');
    _logger.d('🎞️ Output format: ${state.uiState.selectedOutputFormat}');

    // 로딩 시작
    _logger.i('🔄 [ViewModel] Starting generation process...');
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
      // Provider에 따라 적절한 서비스 사용
      final provider = ref.read(videoGenProviderProvider);
      _logger.i('🔧 [ViewModel] Using provider: ${provider.name}');

      if (provider == VideoGenProvider.fal) {
        await _generateVideoWithFalApi();
      } else {
        await _generateVideoWithKlingApi();
      }
    } on FalApiException catch (e) {
      _logger.e('❌ [ViewModel] fal.ai error: ${e.message}');
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isLoading: false,
          isGenerating: false,
          progress: null,
        ),
        action: VideoGenerationPageAction.showError('fal.ai 오류: ${e.message}'),
      );
    } on KlingApiException catch (e) {
      _logger.e('❌ [ViewModel] Kling API error: ${e.message}');
      state = state.copyWith(
        uiState: state.uiState.copyWith(
          isLoading: false,
          isGenerating: false,
          progress: null,
        ),
        action: VideoGenerationPageAction.showError('Kling API 오류: ${e.message}'),
      );
    } on Object catch (e) {
      _logger.e('❌ [ViewModel] Unexpected error: $e');
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

  /// fal.ai API를 사용한 비디오 생성 (추천)
  Future<void> _generateVideoWithFalApi() async {
    _logger.i('───────────────────────────────────────────');
    _logger.i('🚀 [ViewModel] Starting fal.ai generation');
    _logger.i('───────────────────────────────────────────');

    final falService = ref.read(falVideoGenerationServiceProvider);
    final firstImage = state.uiState.selectedImages.first;

    _logger.d('📷 First image ID: ${firstImage.id}');
    _logger.d('📁 File name: ${firstImage.fileName}');

    // 저장된 바이트 데이터 가져오기
    final imageBytes = _imageBytes[firstImage.id];
    if (imageBytes == null || imageBytes.isEmpty) {
      _logger.e('❌ [ViewModel] Image bytes not found for ID: ${firstImage.id}');
      throw FalApiException('이미지 데이터를 찾을 수 없습니다');
    }

    _logger.d('📏 Image bytes size: ${imageBytes.length} bytes');

    // Step 1: 이미지 처리 시작
    _logger.i('📤 [Step 1/4] Processing image...');
    await _updateProgress(
      VideoGenerationStatus.processingImages,
      0.1,
      '이미지 업로드 중...',
    );

    // Step 2: fal.ai API에 태스크 생성
    _logger.i('📤 [Step 2/4] Sending request to fal.ai...');
    await _updateProgress(
      VideoGenerationStatus.processingImages,
      0.2,
      'fal.ai에 요청 전송 중...',
    );

    final taskResult = await falService.createImageToVideoTask(
      imageBytes: imageBytes,
      fileName: firstImage.fileName,
      prompt: state.uiState.prompt.isNotEmpty ? state.uiState.prompt : null,
      duration: '5',
    );

    _logger.i('✅ [ViewModel] Task created: ${taskResult.requestId}');

    // Step 3: 비디오 생성 진행 상황 폴링
    _logger.i('🔄 [Step 3/4] Polling for completion...');
    await _updateProgress(
      VideoGenerationStatus.generatingVideo,
      0.3,
      '비디오 생성 중... (Request ID: ${taskResult.requestId})',
    );

    final videoResult = await falService.pollForCompletion(
      requestId: taskResult.requestId,
      onProgress: (status) {
        final progress = 0.3 + (status.progressPercentage * 0.6);
        final message = _getFalStatusMessage(status.status);
        _logger.d('📊 [ViewModel] Progress: ${(progress * 100).toInt()}% - $message');
        _updateProgressSync(
          VideoGenerationStatus.generatingVideo,
          progress,
          message,
        );
      },
    );

    // Step 4: 완료
    _logger.i('✅ [Step 4/4] Generation completed!');
    await _updateProgress(
      VideoGenerationStatus.completed,
      1.0,
      '완료!',
    );

    // 결과 생성
    final generatedVideo = GeneratedVideoUi(
      id: const Uuid().v4(),
      outputPath: videoResult.url,
      format: state.uiState.selectedOutputFormat,
      durationFormatted: '00:05',
      fileSizeFormatted: videoResult.fileSize != null
          ? '${(videoResult.fileSize! / 1024 / 1024).toStringAsFixed(1)} MB'
          : '-',
      thumbnailPath: null,
      createdAtFormatted: Formatters.formatDateTime(DateTime.now()),
    );

    _logger.i('═══════════════════════════════════════════');
    _logger.i('🎉 [ViewModel] Video Generation Complete!');
    _logger.i('═══════════════════════════════════════════');
    _logger.i('🔗 Video URL: ${videoResult.url}');

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

  /// Kling AI API를 사용한 비디오 생성 (Direct API)
  Future<void> _generateVideoWithKlingApi() async {
    final klingService = ref.read(klingVideoGenerationServiceProvider);
    final firstImage = state.uiState.selectedImages.first;

    // 저장된 바이트 데이터 가져오기
    final imageBytes = _imageBytes[firstImage.id];
    if (imageBytes == null || imageBytes.isEmpty) {
      throw KlingApiException('이미지 데이터를 찾을 수 없습니다');
    }

    // Step 1: 이미지 처리 시작
    await _updateProgress(
      VideoGenerationStatus.processingImages,
      0.1,
      '이미지 업로드 중...',
    );

    // Step 2: Kling API에 태스크 생성
    await _updateProgress(
      VideoGenerationStatus.processingImages,
      0.2,
      'Kling AI에 요청 전송 중...',
    );

    final taskResult = await klingService.createImageToVideoTask(
      imageBytes: imageBytes,
      fileName: firstImage.fileName,
      prompt: state.uiState.prompt.isNotEmpty ? state.uiState.prompt : null,
      duration: '5',
      mode: 'std',
    );

    // Step 3: 비디오 생성 진행 상황 폴링
    await _updateProgress(
      VideoGenerationStatus.generatingVideo,
      0.3,
      '비디오 생성 중... (태스크 ID: ${taskResult.taskId})',
    );

    final videoResult = await klingService.pollForCompletion(
      taskId: taskResult.taskId,
      onProgress: (status) {
        final progress = 0.3 + (status.progressPercentage * 0.6);
        final message = _getKlingStatusMessage(status.taskStatus);
        _updateProgressSync(
          VideoGenerationStatus.generatingVideo,
          progress,
          message,
        );
      },
    );

    // Step 4: 완료
    await _updateProgress(
      VideoGenerationStatus.completed,
      1.0,
      '완료!',
    );

    // 결과 생성
    final generatedVideo = GeneratedVideoUi(
      id: videoResult.id.isNotEmpty ? videoResult.id : const Uuid().v4(),
      outputPath: videoResult.url,
      format: state.uiState.selectedOutputFormat,
      durationFormatted: videoResult.duration.isNotEmpty
          ? videoResult.duration
          : '00:05',
      fileSizeFormatted: '-',
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

  String _getFalStatusMessage(String status) {
    switch (status) {
      case 'IN_QUEUE':
        return '대기열에서 대기 중...';
      case 'IN_PROGRESS':
        return 'AI가 비디오를 생성하고 있습니다...';
      case 'COMPLETED':
        return '비디오 생성 완료!';
      case 'FAILED':
        return '비디오 생성 실패';
      default:
        return '처리 중...';
    }
  }

  String _getKlingStatusMessage(String taskStatus) {
    switch (taskStatus) {
      case 'submitted':
        return '태스크가 제출되었습니다...';
      case 'processing':
        return 'AI가 비디오를 생성하고 있습니다...';
      case 'completed':
        return '비디오 생성 완료!';
      case 'failed':
        return '비디오 생성 실패';
      default:
        return '처리 중...';
    }
  }

  void _updateProgressSync(
    VideoGenerationStatus status,
    double progress,
    String message,
  ) {
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

  /// 비디오 다운로드
  void onDownloadVideo() {
    final video = state.uiState.generatedVideo;
    if (video != null) {
      _logger.i('📥 [ViewModel] Download requested: ${video.outputPath}');
      state = state.copyWith(
        action: VideoGenerationPageAction.downloadVideo(video.outputPath),
      );
    }
  }

  /// 브라우저에서 열기
  void onOpenInBrowser() {
    final video = state.uiState.generatedVideo;
    if (video != null) {
      _logger.i('🌐 [ViewModel] Open in browser: ${video.outputPath}');
      state = state.copyWith(
        action: VideoGenerationPageAction.openInBrowser(video.outputPath),
      );
    }
  }

  /// 링크 공유
  void onShareLink() {
    final video = state.uiState.generatedVideo;
    if (video != null) {
      _logger.i('🔗 [ViewModel] Share link: ${video.outputPath}');
      state = state.copyWith(
        action: VideoGenerationPageAction.shareLink(video.outputPath),
      );
    }
  }

  /// 다운로드 완료 알림
  void onDownloadComplete(String localPath) {
    _logger.i('✅ [ViewModel] Download complete: $localPath');
    state = state.copyWith(
      action: VideoGenerationPageAction.showDownloadComplete(localPath),
    );
  }

}

/// 선택된 이미지 정보 (파일 선택 결과)
class SelectedImageInfo {
  const SelectedImageInfo({
    required this.path,
    required this.fileName,
    required this.fileSizeBytes,
    required this.bytes,
    this.thumbnailPath,
  });

  final String path;
  final String fileName;
  final int fileSizeBytes;
  final Uint8List bytes; // 이미지 바이트 데이터 (웹/모바일 호환)
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
