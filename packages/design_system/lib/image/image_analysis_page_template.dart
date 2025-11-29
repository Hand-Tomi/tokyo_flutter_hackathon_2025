import 'dart:io';
import 'package:flutter/material.dart';
import 'image_analysis_page_ui_state.dart';

class ImageAnalysisPageTemplate extends StatelessWidget {
  const ImageAnalysisPageTemplate({
    super.key,
    required this.uiState,
    required this.onPickImage,
    required this.onAnalyzeImage,
    required this.onGenerateImage,
  });

  final ImageAnalysisPageUiState uiState;
  final VoidCallback onPickImage;
  final VoidCallback onAnalyzeImage;
  final VoidCallback onGenerateImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 분석 & 생성'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagePickerSection(),
            const SizedBox(height: 24),
            if (uiState.currentAnalysis != null) ...[
              _buildAnalysisResultSection(),
              const SizedBox(height: 24),
            ],
            if (uiState.generatedImage != null)
              _buildGeneratedImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerSection() {
    if (uiState.selectedImagePath == null) {
      return GestureDetector(
        onTap: onPickImage,
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_photo_alternate, size: 64, color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  '사진을 선택하세요',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(uiState.selectedImagePath!),
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        if (uiState.isAnalyzing)
          const Column(
            children: [
              LinearProgressIndicator(),
              SizedBox(height: 8),
              Text('이미지 분석 중...', style: TextStyle(color: Colors.grey)),
            ],
          )
        else
          ElevatedButton.icon(
            onPressed: onAnalyzeImage,
            icon: const Icon(Icons.analytics),
            label: const Text('이미지 분석하기'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
      ],
    );
  }

  Widget _buildAnalysisResultSection() {
    final analysis = uiState.currentAnalysis!;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.landscape, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  '풍경 타입: ${analysis.sceneType}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: analysis.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.blue.shade50,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            const Text(
              '분석 결과:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              analysis.analysisText,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 8),
            Text(
              '분석 시간: ${analysis.formattedDate}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (uiState.isGenerating)
              const Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 8),
                  Text('새 이미지 생성 중...', style: TextStyle(color: Colors.grey)),
                ],
              )
            else
              ElevatedButton.icon(
                onPressed: onGenerateImage,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('새 이미지 생성하기'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneratedImageSection() {
    final generated = uiState.generatedImage!;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.image, color: Colors.purple),
                const SizedBox(width: 8),
                const Text(
                  '생성된 이미지',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Chip(
                  label: Text(generated.statusLabel),
                  backgroundColor: Colors.green.shade50,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: generated.imagePath.startsWith('http')
                  ? Image.network(
                      generated.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                  : Image.file(
                      File(generated.imagePath),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 12),
            const Text(
              '프롬프트:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              generated.prompt,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              '생성 시간: ${generated.formattedDate}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
