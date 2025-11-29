import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/step3_scene_list/scene_card.dart';
import 'package:design_system/step3_scene_list/scene_list_ui_state.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// 장면 리스트 페이지 Template
class SceneListTemplate extends StatelessWidget {
  const SceneListTemplate({
    super.key,
    required this.uiState,
    this.onBackPressed,
    this.onAddScenePressed,
    this.onGenerateVideoPressed,
    this.onSceneTap,
    this.onSceneDelete,
  });

  final SceneListPageUiState uiState;
  final VoidCallback? onBackPressed;
  final VoidCallback? onAddScenePressed;
  final VoidCallback? onGenerateVideoPressed;
  final void Function(String sceneId)? onSceneTap;
  final void Function(String sceneId)? onSceneDelete;

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
                    const SizedBox(height: 60),

                    // 헤더
                    Text(
                      'My Scenes',
                      style: AppTypography.headlineLarge,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // 장면 그리드
                    Expanded(
                      child: uiState.scenes.isEmpty
                          ? _buildEmptyState()
                          : _buildSceneGrid(),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // 하단 버튼들
                    _buildBottomButtons(),

                    const SizedBox(height: 140),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.movie_creation_outlined,
            size: 80,
            color: Colors.white38,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No scenes yet',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Start creating your story!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSceneGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: uiState.scenes.length,
      itemBuilder: (context, index) {
        final scene = uiState.scenes[index];
        return SceneCard(
          scene: scene,
          onTap: () => onSceneTap?.call(scene.id),
          onDelete: () => onSceneDelete?.call(scene.id),
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        GameButton(
          onPressed: onAddScenePressed,
          style: GameButtonStyle.secondary,
          icon: Icons.add,
          label: 'Add Scene',
        ),
        const SizedBox(height: AppSpacing.buttonGap),
        GameButton(
          onPressed: uiState.canGenerateVideo ? onGenerateVideoPressed : null,
          style: GameButtonStyle.primary,
          icon: Icons.movie_creation,
          label: 'Create Video',
        ),
      ],
    );
  }
}
