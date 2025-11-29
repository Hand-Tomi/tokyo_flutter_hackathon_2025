import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'sketch_test_ui_state.dart';

/// 스케치 테스트 페이지 템플릿
///
/// 스케치 이미지 선택, 텍스트 입력, 변환 결과 표시
class SketchTestPageTemplate extends StatelessWidget {
  final SketchTestPageUiState uiState;
  final VoidCallback onPickImage;
  final ValueChanged<String> onStoryTextChanged;
  final VoidCallback onGenerate;
  final VoidCallback onClear;

  const SketchTestPageTemplate({
    super.key,
    required this.uiState,
    required this.onPickImage,
    required this.onStoryTextChanged,
    required this.onGenerate,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스케치 → 동화 이미지'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onClear,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상태 메시지
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    if (uiState.isLoading)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        uiState.statusMessage,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 스케치 이미지 선택/표시
            _buildSketchSection(context),
            const SizedBox(height: 16),

            // 동화 텍스트 입력
            _buildStoryTextSection(context),
            const SizedBox(height: 16),

            // 변환 버튼
            ElevatedButton.icon(
              onPressed: uiState.isLoading || uiState.sketchBytes == null
                  ? null
                  : onGenerate,
              icon: const Icon(Icons.auto_fix_high),
              label: const Text('동화풍 이미지로 변환'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),

            // 생성된 이미지 표시
            if (uiState.generatedImagePath != null)
              _buildGeneratedImageSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSketchSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '스케치 이미지',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: uiState.isLoading ? null : onPickImage,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: uiState.sketchBytes != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      uiState.sketchBytes!,
                      fit: BoxFit.contain,
                    ),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate,
                            size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('탭하여 스케치 이미지 선택',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryTextSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '동화 텍스트 (선택사항)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onStoryTextChanged,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: '예: 옛날 옛적에 작은 토끼가 숲속을 걸어가다가...',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedImageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '생성된 동화풍 이미지',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(uiState.generatedImagePath!),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
