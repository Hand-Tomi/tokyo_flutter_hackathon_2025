import 'package:design_system/video_generation/video_generation_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/video_generation/video_generation_page_view_model.dart';

/// 비디오 생성 페이지
///
/// Presentation층: 라우팅, 상태 감시, 액션 처리를 담당
class VideoGenerationPage extends ConsumerWidget {
  const VideoGenerationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoGenerationPageViewModelProvider);

    // 액션 감시
    ref.listen(
      videoGenerationPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          showImagePicker: () {
            _showImagePicker(context, ref);
          },
          showAudioPicker: () {
            _showAudioPicker(context, ref);
          },
          showGenerationComplete: (videoPath) {
            _showGenerationCompleteDialog(context, videoPath);
          },
          showVideoPreview: (videoPath) {
            _showVideoPreview(context, videoPath);
          },
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          },
          shareVideo: (videoPath) {
            _shareVideo(context, videoPath);
          },
        );

        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onFinishedAction();
      },
    );

    // Template에 데이터와 콜백을 전달
    return VideoGenerationPageTemplate(
      uiState: state.uiState,
      onSelectImages: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onSelectImagesPressed();
      },
      onSelectAudio: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onSelectAudioPressed();
      },
      onRemoveImage: (id) {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onRemoveImage(id);
      },
      onRemoveAudio: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onRemoveAudio();
      },
      onApiTypeChanged: (apiType) {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onApiTypeChanged(apiType);
      },
      onOutputFormatChanged: (format) {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onOutputFormatChanged(format);
      },
      onPromptChanged: (prompt) {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onPromptChanged(prompt);
      },
      onGeneratePressed: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onGeneratePressed();
      },
      onCancelGeneration: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onCancelGeneration();
      },
      onPreviewVideo: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onPreviewVideo();
      },
      onShareVideo: () {
        ref
            .read(videoGenerationPageViewModelProvider.notifier)
            .onShareVideo();
      },
    );
  }

  /// 이미지 선택 다이얼로그 표시 (실제 구현 시 image_picker 사용)
  void _showImagePicker(BuildContext context, WidgetRef ref) {
    // 데모용: 실제로는 image_picker 패키지 사용
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🖼️ 이미지 선택'),
        content: const Text(
          '실제 구현에서는 image_picker 또는 file_picker를 사용하여\n'
          '갤러리에서 이미지를 선택합니다.\n\n'
          '데모를 위해 샘플 이미지를 추가합니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 샘플 이미지 추가
              ref
                  .read(videoGenerationPageViewModelProvider.notifier)
                  .onImagesSelected([
                const SelectedImageInfo(
                  path: '/sample/image1.jpg',
                  fileName: 'sample_image_1.jpg',
                  fileSizeBytes: 1024 * 500, // 500KB
                ),
                const SelectedImageInfo(
                  path: '/sample/image2.jpg',
                  fileName: 'sample_image_2.jpg',
                  fileSizeBytes: 1024 * 750, // 750KB
                ),
              ]);
              Navigator.of(context).pop();
            },
            child: const Text('샘플 추가'),
          ),
        ],
      ),
    );
  }

  /// 오디오 선택 다이얼로그 표시 (실제 구현 시 file_picker 사용)
  void _showAudioPicker(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎵 오디오 선택'),
        content: const Text(
          '실제 구현에서는 file_picker를 사용하여\n'
          '오디오 파일을 선택합니다.\n\n'
          '데모를 위해 샘플 오디오를 추가합니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 샘플 오디오 추가
              ref
                  .read(videoGenerationPageViewModelProvider.notifier)
                  .onAudioSelected(
                const SelectedAudioInfo(
                  path: '/sample/audio.mp3',
                  fileName: 'background_music.mp3',
                  fileSizeBytes: 1024 * 1024 * 3, // 3MB
                  durationMs: 120000, // 2분
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Text('샘플 추가'),
          ),
        ],
      ),
    );
  }

  /// 비디오 생성 완료 다이얼로그
  void _showGenerationCompleteDialog(BuildContext context, String videoPath) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('생성 완료!'),
          ],
        ),
        content: Text('비디오가 성공적으로 생성되었습니다.\n\n경로: $videoPath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  /// 비디오 미리보기 (실제 구현 시 video_player 사용)
  void _showVideoPreview(BuildContext context, String videoPath) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎬 비디오 미리보기'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '실제 구현에서는 video_player를 사용합니다.\n\n경로: $videoPath',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  /// 비디오 공유 (실제 구현 시 share_plus 사용)
  void _shareVideo(BuildContext context, String videoPath) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('공유 기능: $videoPath\n(share_plus 패키지로 구현)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
