import 'package:design_system/step3_scene_list/scene_ui.dart';
import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// 장면 카드 위젯
class SceneCard extends StatelessWidget {
  const SceneCard({
    super.key,
    required this.scene,
    this.onTap,
    this.onDelete,
  });

  final SceneUi scene;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

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
            // 썸네일 또는 플레이스홀더
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard - 2),
              child: _buildThumbnail(),
            ),

            // 장면 번호
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${scene.sceneNumber}',
                  style: AppTypography.labelMedium,
                ),
              ),
            ),

            // 상태 인디케이터
            if (scene.status == SceneStatus.generating)
              const Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),

            // 에러 표시
            if (scene.status == SceneStatus.error)
              const Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
              ),

            // 삭제 버튼
            if (onDelete != null)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (scene.thumbnailPath != null) {
      // 실제 썸네일 이미지
      return Container(
        color: AppColors.overlayMedium,
        child: const Center(
          child: Icon(
            Icons.image,
            color: Colors.white54,
            size: 48,
          ),
        ),
      );
    }

    // 플레이스홀더
    return Container(
      color: AppColors.overlayLight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_stories,
              color: Colors.white38,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              scene.sttText.length > 30
                  ? '${scene.sttText.substring(0, 30)}...'
                  : scene.sttText,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
