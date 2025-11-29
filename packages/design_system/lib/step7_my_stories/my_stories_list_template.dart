import 'package:design_system/components/game_button.dart';
import 'package:design_system/components/sky_background.dart';
import 'package:design_system/step7_my_stories/my_stories_list_ui_state.dart';
import 'package:design_system/step7_my_stories/my_story_card.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// My Stories 리스트 페이지 Template
class MyStoriesListTemplate extends StatelessWidget {
  const MyStoriesListTemplate({
    super.key,
    required this.uiState,
    this.onBackPressed,
    this.onStoryTap,
  });

  final MyStoriesListPageUiState uiState;
  final VoidCallback? onBackPressed;
  final void Function(int storyId)? onStoryTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SkyBackground(
        child: Stack(
          children: [
            // 메인 컨텐츠
            SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // 헤더
                      Text('My Stories', style: AppTypography.headlineLarge),

                      const SizedBox(height: AppSpacing.lg),

                      // 스토리 그리드 또는 빈 상태
                      Expanded(
                        child: uiState.stories.isEmpty
                            ? _buildEmptyState()
                            : _buildStoriesGrid(),
                      ),

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

  Widget _buildStoriesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: uiState.stories.length,
      itemBuilder: (context, index) {
        final story = uiState.stories[index];
        return MyStoryCard(
          story: story,
          onTap: () => onStoryTap?.call(story.id),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.video_library_outlined,
            size: 80,
            color: Colors.white38,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('No stories yet', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Create your first story!',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
