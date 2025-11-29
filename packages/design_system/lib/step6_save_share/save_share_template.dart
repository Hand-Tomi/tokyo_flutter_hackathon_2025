import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/step6_save_share/save_share_ui_state.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// 저장/공유 페이지 Template
class SaveShareTemplate extends StatelessWidget {
  const SaveShareTemplate({
    super.key,
    required this.uiState,
    this.onBackPressed,
    this.onDownloadPressed,
    this.onSharePressed,
    this.onHomePressed,
  });

  final SaveSharePageUiState uiState;
  final VoidCallback? onBackPressed;
  final VoidCallback? onDownloadPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onHomePressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: Stack(
          children: [
            // 축하 장식들
            ..._buildCelebrationDecorations(context),

            // 메인 컨텐츠
            SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(flex: 1),

                      // 축하 아이콘
                      _buildCelebrationIcon(),

                      const SizedBox(height: AppSpacing.lg),

                      // 축하 메시지
                      Text(
                        'Congratulations!',
                        style: AppTypography.displayMedium,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        'Your story is complete!',
                        style: AppTypography.titleMedium,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // 썸네일
                      _buildThumbnail(),

                      const Spacer(flex: 1),

                      // 버튼들
                      _buildButtons(),

                      const SizedBox(height: 140),
                    ],
                  ),
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

  List<Widget> _buildCelebrationDecorations(BuildContext context) {
    return [
      // 왼쪽 위 별
      Positioned(top: 100, left: 30, child: _buildStar(24)),
      // 오른쪽 위 별
      Positioned(top: 150, right: 40, child: _buildStar(32)),
      // 왼쪽 중간 별
      Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        left: 20,
        child: _buildStar(20),
      ),
      // 오른쪽 중간 별
      Positioned(
        top: MediaQuery.of(context).size.height * 0.35,
        right: 25,
        child: _buildStar(28),
      ),
    ];
  }

  Widget _buildStar(double size) {
    return Icon(
      Icons.star,
      size: size,
      color: AppColors.sun.withValues(alpha: 0.6),
    );
  }

  Widget _buildCelebrationIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.buttonGreen.withValues(alpha: 0.3),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGreen.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(Icons.celebration, size: 64, color: Colors.white),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.overlayLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard - 4),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.movie, size: 64, color: Colors.white54),
              SizedBox(height: 8),
              Text(
                'Story Thumbnail',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        // 다운로드 버튼
        GameButton(
          onPressed: uiState.saveStatus == SaveStatus.saving
              ? null
              : onDownloadPressed,
          style: GameButtonStyle.secondary,
          icon: uiState.saveStatus == SaveStatus.saved
              ? Icons.check_circle
              : Icons.download,
          label: uiState.saveStatus == SaveStatus.saving
              ? 'Saving...'
              : uiState.saveStatus == SaveStatus.saved
              ? 'Saved!'
              : 'Download',
        ),

        const SizedBox(height: AppSpacing.buttonGap),

        // 공유 버튼
        GameButton(
          onPressed: onSharePressed,
          style: GameButtonStyle.tertiary,
          icon: Icons.share,
          label: 'Share',
        ),

        const SizedBox(height: AppSpacing.buttonGap),

        // 홈 버튼
        GameButton(
          onPressed: onHomePressed,
          style: GameButtonStyle.primary,
          icon: Icons.home,
          label: 'Home',
        ),
      ],
    );
  }
}
