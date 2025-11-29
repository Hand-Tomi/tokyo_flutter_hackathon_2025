import 'package:design_system/video_generation/video_generation_ui.dart';
import 'package:domain/video_generation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_generation_ui_state.freezed.dart';

/// 비디오 생성 페이지의 UI 상태
/// 화면에 표시하는 데이터를 보유
@freezed
class VideoGenerationPageUiState with _$VideoGenerationPageUiState {
  const factory VideoGenerationPageUiState({
    /// 선택된 이미지 목록
    @Default([]) List<SelectedImageUi> selectedImages,

    /// 선택된 오디오 파일
    SelectedAudioUi? selectedAudio,

    /// 선택된 API 타입
    @Default(VideoApiType.kling) VideoApiType selectedApiType,

    /// 선택된 출력 형식
    @Default(OutputFormat.mp4) OutputFormat selectedOutputFormat,

    /// 프롬프트 텍스트
    @Default('') String prompt,

    /// 비디오 생성 진행 상황
    VideoGenerationProgressUi? progress,

    /// 생성된 비디오
    GeneratedVideoUi? generatedVideo,

    /// 로딩 상태
    @Default(false) bool isLoading,

    /// 비디오 생성 중 여부
    @Default(false) bool isGenerating,
  }) = _VideoGenerationPageUiState;
}

/// 비디오 생성 페이지의 액션
/// 일회성 이벤트 (다이얼로그 표시, 화면 전환 등)
@freezed
class VideoGenerationPageAction with _$VideoGenerationPageAction {
  /// 아무 액션 없음
  factory VideoGenerationPageAction.none() = _None;

  /// 이미지 선택 다이얼로그 표시
  factory VideoGenerationPageAction.showImagePicker() = _ShowImagePicker;

  /// 오디오 선택 다이얼로그 표시
  factory VideoGenerationPageAction.showAudioPicker() = _ShowAudioPicker;

  /// 비디오 생성 완료
  factory VideoGenerationPageAction.showGenerationComplete(String videoPath) =
      _ShowGenerationComplete;

  /// 비디오 미리보기 표시
  factory VideoGenerationPageAction.showVideoPreview(String videoPath) =
      _ShowVideoPreview;

  /// 에러 표시
  factory VideoGenerationPageAction.showError(String message) = _ShowError;

  /// 비디오 공유
  factory VideoGenerationPageAction.shareVideo(String videoPath) = _ShareVideo;
}
