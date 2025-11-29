import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/home/home_page_ui_state.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Home 페이지 Template
/// StorySpark 게임 스타일 홈 화면
class HomePageTemplate extends StatelessWidget {
  const HomePageTemplate({
    super.key,
    required this.uiState,
    this.onPlayPressed,
    this.onMyStoriesPressed,
    this.onSettingsPressed,
    this.onProfilePressed,
  });

  final HomePageUiState uiState;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onMyStoriesPressed;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onProfilePressed;

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
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),

                      // 로고 영역
                      _buildLogoSection(),

                      const SizedBox(height: 48),

                      // 버튼 영역
                      _buildButtonsSection(),

                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),

            // 프로필 버튼 (우측 상단)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child: CircleIconButton(
                onPressed: onProfilePressed,
                icon: Icons.account_circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Text(
          'StorySpark',
          style: AppTypography.displayLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          "Let's make a story!",
          style: AppTypography.titleMedium,
        ),
      ],
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      children: [
        // PLAY 버튼 (가장 큼)
        GameButton(
          onPressed: onPlayPressed,
          style: GameButtonStyle.primary,
          icon: Icons.play_circle,
          label: 'PLAY',
          isLarge: true,
        ),

        const SizedBox(height: AppSpacing.buttonGap),

        // My Stories 버튼
        GameButton(
          onPressed: onMyStoriesPressed,
          style: GameButtonStyle.secondary,
          icon: Icons.video_library,
          label: 'My Stories',
        ),

        const SizedBox(height: AppSpacing.buttonGap),

        // Settings 버튼
        GameButton(
          onPressed: onSettingsPressed,
          style: GameButtonStyle.tertiary,
          icon: Icons.settings,
          label: 'Settings',
        ),
      ],
    );
  }
}
