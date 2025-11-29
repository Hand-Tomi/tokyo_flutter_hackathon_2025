import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/scene_creation/scene_creation_ui_state.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// 장면 생성 페이지 Template
/// 4단계 흐름: 녹음 → STT 확인 → Air Scribble → 확정
class SceneCreationTemplate extends StatelessWidget {
  const SceneCreationTemplate({
    super.key,
    required this.uiState,
    this.onBackPressed,
    this.onRecordPressed,
    this.onStopRecordPressed,
    this.onReRecordPressed,
    this.onNextStepPressed,
    this.onClearDrawingPressed,
    this.onConfirmScenePressed,
    this.onAddMoreScenePressed,
    this.onFinishPressed,
  });

  final SceneCreationPageUiState uiState;
  final VoidCallback? onBackPressed;
  final VoidCallback? onRecordPressed;
  final VoidCallback? onStopRecordPressed;
  final VoidCallback? onReRecordPressed;
  final VoidCallback? onNextStepPressed;
  final VoidCallback? onClearDrawingPressed;
  final VoidCallback? onConfirmScenePressed;
  final VoidCallback? onAddMoreScenePressed;
  final VoidCallback? onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: Stack(
          children: [
            // 메인 컨텐츠
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 60), // 뒤로가기 버튼 공간

                    // 헤더
                    _buildHeader(),

                    const SizedBox(height: AppSpacing.lg),

                    // 단계 인디케이터
                    _buildStepIndicator(),

                    const SizedBox(height: AppSpacing.xl),

                    // 단계별 컨텐츠
                    Expanded(
                      child: _buildStepContent(),
                    ),

                    // 하단 버튼 영역
                    _buildBottomButtons(),

                    const SizedBox(height: 140), // 잔디 공간
                  ],
                ),
              ),
            ),

            // 뒤로가기 버튼
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: CircleIconButton(
                onPressed: onBackPressed,
                icon: Icons.arrow_back,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Scene ${uiState.sceneNumber}',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          _getStepTitle(),
          style: AppTypography.titleMedium,
        ),
      ],
    );
  }

  String _getStepTitle() {
    switch (uiState.currentStep) {
      case SceneCreationStep.recording:
        return 'Record your story';
      case SceneCreationStep.sttResult:
        return 'Check your story';
      case SceneCreationStep.airScribble:
        return 'Draw in the air!';
      case SceneCreationStep.confirmation:
        return 'Scene ready!';
    }
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepDot(0, SceneCreationStep.recording),
        _buildStepLine(0),
        _buildStepDot(1, SceneCreationStep.sttResult),
        _buildStepLine(1),
        _buildStepDot(2, SceneCreationStep.airScribble),
        _buildStepLine(2),
        _buildStepDot(3, SceneCreationStep.confirmation),
      ],
    );
  }

  Widget _buildStepDot(int index, SceneCreationStep step) {
    final isActive = uiState.currentStep.index >= step.index;
    final isCurrent = uiState.currentStep == step;

    return Container(
      width: isCurrent ? 20 : 16,
      height: isCurrent ? 20 : 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.buttonOrange : AppColors.overlayMedium,
        border: isCurrent
            ? Border.all(color: Colors.white, width: 3)
            : null,
      ),
    );
  }

  Widget _buildStepLine(int index) {
    final isActive = uiState.currentStep.index > index;

    return Container(
      width: 40,
      height: 4,
      color: isActive ? AppColors.buttonOrange : AppColors.overlayMedium,
    );
  }

  Widget _buildStepContent() {
    switch (uiState.currentStep) {
      case SceneCreationStep.recording:
        return _buildRecordingContent();
      case SceneCreationStep.sttResult:
        return _buildSttResultContent();
      case SceneCreationStep.airScribble:
        return _buildAirScribbleContent();
      case SceneCreationStep.confirmation:
        return _buildConfirmationContent();
    }
  }

  Widget _buildRecordingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 마이크 버튼
        GestureDetector(
          onTap: uiState.isRecording ? onStopRecordPressed : onRecordPressed,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: uiState.isRecording
                  ? AppColors.buttonOrange
                  : AppColors.overlayMedium,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              uiState.isRecording ? Icons.stop : Icons.mic,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          uiState.isRecording ? 'Tap to stop' : 'Tap to record',
          style: AppTypography.bodyLarge,
        ),
        if (uiState.isRecording) ...[
          const SizedBox(height: AppSpacing.md),
          const _RecordingIndicator(),
        ],
      ],
    );
  }

  Widget _buildSttResultContent() {
    return Column(
      children: [
        const Spacer(),
        // STT 결과 카드
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.overlayLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            border: Border.all(
              color: AppColors.overlayMedium,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.format_quote,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                uiState.sttText.isEmpty
                    ? 'Your story will appear here...'
                    : uiState.sttText,
                style: AppTypography.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        // 재녹음 버튼
        GameButton(
          onPressed: onReRecordPressed,
          style: GameButtonStyle.tertiary,
          icon: Icons.refresh,
          label: 'Re-record',
        ),
      ],
    );
  }

  Widget _buildAirScribbleContent() {
    return Column(
      children: [
        // 드로잉 캔버스 영역
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.overlayLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              border: Border.all(
                color: AppColors.overlayMedium,
                width: 2,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gesture,
                    size: 80,
                    color: Colors.white54,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    'Camera preview here',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Draw with your finger!',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Clear 버튼
        GameButton(
          onPressed: onClearDrawingPressed,
          style: GameButtonStyle.tertiary,
          icon: Icons.delete_outline,
          label: 'Clear',
        ),
      ],
    );
  }

  Widget _buildConfirmationContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 성공 아이콘
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.buttonGreen.withValues(alpha: 0.3),
          ),
          child: const Icon(
            Icons.check_circle,
            size: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Scene ${uiState.sceneNumber} created!',
          style: AppTypography.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          uiState.isGeneratingImage
              ? 'Generating image...'
              : 'Your scene is ready',
          style: AppTypography.bodyLarge,
        ),
        if (uiState.isGeneratingImage) ...[
          const SizedBox(height: AppSpacing.md),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ],
    );
  }

  Widget _buildBottomButtons() {
    switch (uiState.currentStep) {
      case SceneCreationStep.recording:
        return const SizedBox.shrink();
      case SceneCreationStep.sttResult:
      case SceneCreationStep.airScribble:
        return GameButton(
          onPressed: onNextStepPressed,
          style: GameButtonStyle.primary,
          icon: Icons.arrow_forward,
          label: 'Next',
        );
      case SceneCreationStep.confirmation:
        return Column(
          children: [
            GameButton(
              onPressed: onAddMoreScenePressed,
              style: GameButtonStyle.secondary,
              icon: Icons.add,
              label: 'Add Scene',
            ),
            const SizedBox(height: AppSpacing.buttonGap),
            GameButton(
              onPressed: onFinishPressed,
              style: GameButtonStyle.primary,
              icon: Icons.check,
              label: 'Finish',
            ),
          ],
        );
    }
  }
}

/// 녹음 중 애니메이션 인디케이터
class _RecordingIndicator extends StatefulWidget {
  const _RecordingIndicator();

  @override
  State<_RecordingIndicator> createState() => _RecordingIndicatorState();
}

class _RecordingIndicatorState extends State<_RecordingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final value =
                (((_controller.value + delay) % 1.0) * 2 - 1).abs();
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8 + (value * 16),
              decoration: BoxDecoration(
                color: AppColors.buttonOrange,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}
