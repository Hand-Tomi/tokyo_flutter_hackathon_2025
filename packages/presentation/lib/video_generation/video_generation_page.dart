import 'dart:io';

import 'package:design_system/video_generation/video_generation_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation/video_generation/video_generation_page_view_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
            _showGenerationCompleteDialog(context, ref, videoPath);
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
          downloadVideo: (videoUrl) {
            _downloadVideo(context, ref, videoUrl);
          },
          openInBrowser: (videoUrl) {
            _openInBrowser(context, videoUrl);
          },
          shareLink: (videoUrl) {
            _shareLink(context, videoUrl);
          },
          showDownloadComplete: (localPath) {
            _showDownloadCompleteDialog(context, localPath);
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

  /// 이미지 선택 다이얼로그 표시
  Future<void> _showImagePicker(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();

    // 선택 방법 다이얼로그
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🖼️ 이미지 선택'),
        content: const Text('이미지를 가져올 방법을 선택하세요'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: const Text('📷 카메라'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: const Text('🖼️ 갤러리'),
          ),
        ],
      ),
    );

    if (source == null) return;

    try {
      final List<XFile> pickedFiles;

      if (source == ImageSource.gallery) {
        // 갤러리에서 여러 이미지 선택
        pickedFiles = await picker.pickMultiImage(
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
      } else {
        // 카메라로 단일 이미지 촬영
        final file = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        pickedFiles = file != null ? [file] : [];
      }

      if (pickedFiles.isEmpty) return;

      // 선택된 이미지 정보 생성
      final selectedImages = <SelectedImageInfo>[];
      for (final xFile in pickedFiles) {
        // XFile API는 웹과 모바일 모두에서 작동
        final fileSize = await xFile.length();
        final bytes = await xFile.readAsBytes();

        selectedImages.add(SelectedImageInfo(
          path: xFile.path,
          fileName: xFile.name,
          fileSizeBytes: fileSize,
          bytes: bytes,
          thumbnailPath: xFile.path, // 실제 이미지 경로를 썸네일로 사용
        ));
      }

      ref
          .read(videoGenerationPageViewModelProvider.notifier)
          .onImagesSelected(selectedImages);
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('이미지 선택 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
  void _showGenerationCompleteDialog(
    BuildContext context,
    WidgetRef ref,
    String videoPath,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('🎉 생성 완료!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '비디오가 성공적으로 생성되었습니다.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, size: 20, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      videoPath,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 액션 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.download,
                  label: '다운로드',
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    ref
                        .read(videoGenerationPageViewModelProvider.notifier)
                        .onDownloadVideo();
                  },
                ),
                _buildActionButton(
                  icon: Icons.open_in_browser,
                  label: '브라우저',
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    ref
                        .read(videoGenerationPageViewModelProvider.notifier)
                        .onOpenInBrowser();
                  },
                ),
                _buildActionButton(
                  icon: Icons.share,
                  label: '링크 공유',
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    ref
                        .read(videoGenerationPageViewModelProvider.notifier)
                        .onShareLink();
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: Colors.blue),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ],
        ),
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

  /// 비디오 다운로드
  Future<void> _downloadVideo(
    BuildContext context,
    WidgetRef ref,
    String videoUrl,
  ) async {
    // 다운로드 시작 알림
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text('비디오 다운로드 중...'),
          ],
        ),
        duration: Duration(seconds: 30),
      ),
    );

    try {
      // HTTP로 비디오 다운로드
      final response = await http.get(Uri.parse(videoUrl));

      if (response.statusCode == 200) {
        // 저장 경로 결정
        final directory = await getApplicationDocumentsDirectory();
        final fileName =
            'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
        final filePath = '${directory.path}/$fileName';

        // 파일 저장
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        if (context.mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ref
              .read(videoGenerationPageViewModelProvider.notifier)
              .onDownloadComplete(filePath);
        }
      } else {
        throw Exception('다운로드 실패: ${response.statusCode}');
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('다운로드 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 브라우저에서 열기
  Future<void> _openInBrowser(BuildContext context, String videoUrl) async {
    final uri = Uri.parse(videoUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('브라우저를 열 수 없습니다'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 링크 공유
  Future<void> _shareLink(BuildContext context, String videoUrl) async {
    try {
      await Share.share(
        '🎬 AI로 생성한 비디오를 확인해보세요!\n\n$videoUrl',
        subject: 'AI 생성 비디오',
      );
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('공유 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 다운로드 완료 다이얼로그
  void _showDownloadCompleteDialog(BuildContext context, String localPath) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.download_done, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('다운로드 완료!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('비디오가 저장되었습니다.'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder, size: 20, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localPath,
                      style: const TextStyle(fontSize: 11),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
