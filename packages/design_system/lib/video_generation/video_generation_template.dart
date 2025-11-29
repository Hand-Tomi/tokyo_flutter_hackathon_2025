import 'package:design_system/components/sky_background.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:design_system/video_generation/video_generation_ui_state.dart';
import 'package:flutter/material.dart';

/// 영상 생성 페이지 Template
class VideoGenerationTemplate extends StatelessWidget {
  const VideoGenerationTemplate({
    super.key,
    required this.uiState,
  });

  final VideoGenerationPageUiState uiState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // 마법 아이콘 / 완료 아이콘
                _buildIcon(),

                const SizedBox(height: AppSpacing.xl),

                // 타이틀
                Text(
                  _getTitle(),
                  style: AppTypography.headlineLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.md),

                // 상태 메시지
                Text(
                  uiState.statusMessage,
                  style: AppTypography.bodyLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),

                // 진행률 바
                if (uiState.step != VideoGenerationStep.completed &&
                    uiState.step != VideoGenerationStep.error)
                  _buildProgressBar(),

                // 장면 진행 표시
                if (uiState.totalScenes > 0 &&
                    uiState.step == VideoGenerationStep.combiningImages)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: Text(
                      'Scene ${uiState.currentScene} / ${uiState.totalScenes}',
                      style: AppTypography.bodyMedium,
                    ),
                  ),

                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (uiState.step == VideoGenerationStep.completed) {
      return Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.buttonGreen.withValues(alpha: 0.3),
        ),
        child: const Icon(
          Icons.check_circle,
          size: 100,
          color: Colors.white,
        ),
      );
    }

    if (uiState.step == VideoGenerationStep.error) {
      return Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withValues(alpha: 0.3),
        ),
        child: const Icon(
          Icons.error_outline,
          size: 100,
          color: Colors.white,
        ),
      );
    }

    // 생성 중 애니메이션
    return const _MagicWandAnimation();
  }

  String _getTitle() {
    switch (uiState.step) {
      case VideoGenerationStep.preparing:
        return 'Preparing Magic...';
      case VideoGenerationStep.combiningImages:
        return 'Creating Story...';
      case VideoGenerationStep.addingAudio:
        return 'Adding Voice...';
      case VideoGenerationStep.finalizing:
        return 'Final Touches...';
      case VideoGenerationStep.completed:
        return 'Your Story is Ready!';
      case VideoGenerationStep.error:
        return 'Oops!';
    }
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        // 진행률 바
        Container(
          width: 280,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.overlayMedium,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 280 * uiState.progress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.buttonOrange,
                      AppColors.buttonOrangeDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // 퍼센트 표시
        Text(
          '${(uiState.progress * 100).toInt()}%',
          style: AppTypography.labelLarge,
        ),
      ],
    );
  }
}

/// 마법 지팡이 애니메이션
class _MagicWandAnimation extends StatefulWidget {
  const _MagicWandAnimation();

  @override
  State<_MagicWandAnimation> createState() => _MagicWandAnimationState();
}

class _MagicWandAnimationState extends State<_MagicWandAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
        return Stack(
          alignment: Alignment.center,
          children: [
            // 회전하는 별들
            ...List.generate(3, (index) {
              final angle = (_controller.value * 2 * 3.14159) + (index * 2.094);
              final radius = 60.0;
              return Positioned(
                left: 80 + radius * (angle.cos()),
                top: 80 + radius * (angle.sin()),
                child: Icon(
                  Icons.star,
                  color: AppColors.sun.withValues(alpha: 0.8),
                  size: 24 + (index * 4),
                ),
              );
            }),
            // 마법 지팡이
            const Icon(
              Icons.auto_fix_high,
              size: 80,
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }
}

extension on double {
  double cos() => _cos(this);
  double sin() => _sin(this);
}

double _cos(double x) {
  // Simple cos approximation
  x = x % (2 * 3.14159);
  return 1 -
      (x * x) / 2 +
      (x * x * x * x) / 24 -
      (x * x * x * x * x * x) / 720;
}

double _sin(double x) {
  // Simple sin approximation
  x = x % (2 * 3.14159);
  return x -
      (x * x * x) / 6 +
      (x * x * x * x * x) / 120 -
      (x * x * x * x * x * x * x) / 5040;
}
