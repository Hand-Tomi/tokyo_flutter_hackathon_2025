import 'package:design_system/video_generation/file_image.dart';
import 'package:design_system/video_generation/video_generation_ui.dart';
import 'package:design_system/video_generation/video_generation_ui_state.dart';
import 'package:domain/video_generation.dart';
import 'package:flutter/material.dart';

/// 비디오 생성 페이지 Template
/// 순수 UI 레이아웃 (상태 관리 없음)
class VideoGenerationPageTemplate extends StatelessWidget {
  const VideoGenerationPageTemplate({
    super.key,
    required this.uiState,
    required this.onSelectImages,
    required this.onSelectAudio,
    required this.onRemoveImage,
    required this.onRemoveAudio,
    required this.onApiTypeChanged,
    required this.onOutputFormatChanged,
    required this.onPromptChanged,
    required this.onGeneratePressed,
    required this.onCancelGeneration,
    required this.onPreviewVideo,
    required this.onShareVideo,
  });

  final VideoGenerationPageUiState uiState;
  final VoidCallback onSelectImages;
  final VoidCallback onSelectAudio;
  final void Function(String id) onRemoveImage;
  final VoidCallback onRemoveAudio;
  final void Function(VideoApiType) onApiTypeChanged;
  final void Function(OutputFormat) onOutputFormatChanged;
  final void Function(String) onPromptChanged;
  final VoidCallback onGeneratePressed;
  final VoidCallback onCancelGeneration;
  final VoidCallback onPreviewVideo;
  final VoidCallback onShareVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 비디오 생성'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 이미지 선택 섹션
            _buildImageSection(context),
            const SizedBox(height: 24),

            // 오디오 선택 섹션
            _buildAudioSection(context),
            const SizedBox(height: 24),

            // API 및 출력 형식 선택
            _buildOptionsSection(context),
            const SizedBox(height: 24),

            // 프롬프트 입력
            _buildPromptSection(context),
            const SizedBox(height: 24),

            // 진행 상황 또는 생성 버튼
            if (uiState.isGenerating)
              _buildProgressSection(context)
            else
              _buildGenerateButton(context),
            const SizedBox(height: 24),

            // 생성된 비디오 미리보기
            if (uiState.generatedVideo != null) _buildResultSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🖼️ 이미지 선택',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: onSelectImages,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('추가'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '동영상에 사용할 이미지를 선택하세요 (최소 1장)',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (uiState.selectedImages.isEmpty)
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('이미지가 없습니다', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: uiState.selectedImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final image = uiState.selectedImages[index];
                    return _buildImageThumbnail(image);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(SelectedImageUi image) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildImageWidget(image),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemoveImage(image.id),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget(SelectedImageUi image) {
    final imagePath = image.thumbnailPath ?? image.path;

    return buildFileImage(
      path: imagePath,
      width: 100,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: () => _buildImagePlaceholder(image),
    );
  }

  Widget _buildImagePlaceholder(SelectedImageUi image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.image, color: Colors.grey),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            image.fileName,
            style: const TextStyle(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAudioSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🎵 오디오 선택',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: onSelectAudio,
                  icon: const Icon(Icons.audiotrack),
                  label: const Text('선택'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '배경 음악 또는 음성을 추가하세요 (선택 사항)',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (uiState.selectedAudio == null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_off, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('오디오 없음', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.audiotrack, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            uiState.selectedAudio!.fileName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${uiState.selectedAudio!.durationFormatted} • ${uiState.selectedAudio!.fileSizeFormatted}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onRemoveAudio,
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '⚙️ 옵션 설정',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // API 타입 선택
            const Text('API 엔진', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            DropdownButtonFormField<VideoApiType>(
              initialValue: uiState.selectedApiType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: VideoApiType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text('${type.emoji} ${type.displayName}'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) onApiTypeChanged(value);
              },
            ),
            const SizedBox(height: 8),
            Text(
              uiState.selectedApiType.description,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(height: 16),

            // 출력 형식 선택
            const Text('출력 형식', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            SegmentedButton<OutputFormat>(
              segments: OutputFormat.values.map((format) {
                return ButtonSegment(
                  value: format,
                  label: Text(format.displayName),
                  icon: Text(format.emoji),
                );
              }).toList(),
              selected: {uiState.selectedOutputFormat},
              onSelectionChanged: (selected) {
                onOutputFormatChanged(selected.first);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '✍️ 프롬프트 (선택 사항)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '생성할 동영상에 대한 설명을 입력하세요',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: '예: 부드러운 카메라 움직임으로 캐릭터가 걷는 애니메이션',
                border: OutlineInputBorder(),
              ),
              onChanged: onPromptChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final progress = uiState.progress;
    if (progress == null) return const SizedBox.shrink();

    return Card(
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  progress.status.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progress.status.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (progress.message != null)
                        Text(
                          progress.message!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  progress.progressPercentage,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress.progress,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onCancelGeneration,
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('취소', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    final canGenerate = uiState.selectedImages.isNotEmpty && !uiState.isLoading;

    return ElevatedButton.icon(
      onPressed: canGenerate ? onGeneratePressed : null,
      icon: uiState.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.movie_creation),
      label: Text(uiState.isLoading ? '준비 중...' : '🎬 비디오 생성'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildResultSection(BuildContext context) {
    final video = uiState.generatedVideo!;

    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '생성 완료!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: video.thumbnailPath != null
                    ? Image.asset(video.thumbnailPath!, fit: BoxFit.cover)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            size: 64,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video.format.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildVideoInfo(Icons.timer, video.durationFormatted),
                _buildVideoInfo(Icons.storage, video.fileSizeFormatted),
                _buildVideoInfo(Icons.video_file, video.format.displayName),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPreviewVideo,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('재생'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onShareVideo,
                    icon: const Icon(Icons.share),
                    label: const Text('공유'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
