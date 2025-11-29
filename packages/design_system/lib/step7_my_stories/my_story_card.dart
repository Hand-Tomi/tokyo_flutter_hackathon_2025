import 'dart:io';

import 'package:design_system/step7_my_stories/my_story_ui.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// My Story 카드 위젯
class MyStoryCard extends StatelessWidget {
  const MyStoryCard({
    super.key,
    required this.story,
    this.onTap,
  });

  final MyStoryUi story;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.overlayLight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          border: Border.all(
            color: AppColors.overlayMedium,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            // 썸네일 플레이스홀더
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard - 2),
              child: _buildThumbnail(),
            ),

            // 재생 아이콘 오버레이
            const Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white70,
                  size: 48,
                ),
              ),
            ),

            // 하단 타이틀 오버레이
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppSpacing.radiusCard - 2),
                    bottomRight: Radius.circular(AppSpacing.radiusCard - 2),
                  ),
                ),
                child: Text(
                  story.title.isNotEmpty
                      ? (story.title.length > 30
                          ? '${story.title.substring(0, 30)}...'
                          : story.title)
                      : 'Story #${story.id}',
                  style: AppTypography.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (story.thumbnailPath != null) {
      return SizedBox.expand(
        child: Image.file(
          File(story.thumbnailPath!),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.overlayMedium,
      child: const Center(
        child: Icon(
          Icons.movie_outlined,
          color: Colors.white38,
          size: 64,
        ),
      ),
    );
  }
}
