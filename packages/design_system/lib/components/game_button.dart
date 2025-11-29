import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:design_system/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// 게임 버튼 스타일 열거형
enum GameButtonStyle {
  /// 주요 액션 (Play 등) - 오렌지
  primary,

  /// 보조 액션 (My Stories 등) - 그린
  secondary,

  /// 일반 액션 (Settings 등) - 블루
  tertiary,
}

/// 3D 스타일 게임 버튼
///
/// 눌렸을 때 아래로 내려가는 애니메이션 효과가 있는 버튼
class GameButton extends StatefulWidget {
  const GameButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.style = GameButtonStyle.primary,
    this.isLarge = false,
    this.iconSize,
  });

  /// 버튼 탭 콜백
  final VoidCallback? onPressed;

  /// 버튼 아이콘
  final IconData icon;

  /// 버튼 라벨
  final String label;

  /// 버튼 스타일 (색상)
  final GameButtonStyle style;

  /// 대형 버튼 여부 (PLAY 버튼용)
  final bool isLarge;

  /// 아이콘 크기 (기본값: large=56, medium=32)
  final double? iconSize;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _isPressed = false;

  Color get _backgroundColor {
    return switch (widget.style) {
      GameButtonStyle.primary => AppColors.buttonOrange,
      GameButtonStyle.secondary => AppColors.buttonGreen,
      GameButtonStyle.tertiary => AppColors.buttonBlue,
    };
  }

  Color get _borderColor {
    return switch (widget.style) {
      GameButtonStyle.primary => AppColors.buttonOrangeDark,
      GameButtonStyle.secondary => AppColors.buttonGreenDark,
      GameButtonStyle.tertiary => AppColors.buttonBlueDark,
    };
  }

  double get _iconSize {
    return widget.iconSize ?? (widget.isLarge ? 56 : 32);
  }

  @override
  Widget build(BuildContext context) {
    final fixedHeight = widget.isLarge
        ? AppSpacing.buttonHeightLarge
        : AppSpacing.buttonHeightMedium;
    final padding = widget.isLarge
        ? AppSpacing.buttonPaddingLarge
        : AppSpacing.buttonPaddingMedium;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        height: fixedHeight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
          width: AppSpacing.buttonWidthLarge,
          padding: EdgeInsets.symmetric(vertical: padding),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border(
              bottom: BorderSide(
                color: _borderColor,
                width: _isPressed ? 4 : 8,
              ),
            ),
          ),
          child: widget.isLarge ? _buildLargeContent() : _buildMediumContent(),
        ),
      ),
    );
  }

  Widget _buildLargeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          size: _iconSize,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(widget.label, style: AppTypography.buttonLarge),
      ],
    );
  }

  Widget _buildMediumContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          size: _iconSize,
          color: AppColors.textPrimary,
        ),
        const SizedBox(width: AppSpacing.md),
        Text(widget.label, style: AppTypography.buttonMedium),
      ],
    );
  }
}

/// 원형 아이콘 버튼 (프로필, 뒤로가기 등)
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = AppSpacing.circleButtonLarge,
    this.iconSize = 40,
    this.backgroundColor,
    this.iconColor,
  });

  /// 버튼 탭 콜백
  final VoidCallback? onPressed;

  /// 버튼 아이콘
  final IconData icon;

  /// 버튼 크기
  final double size;

  /// 아이콘 크기
  final double iconSize;

  /// 배경색 (기본: 반투명 흰색)
  final Color? backgroundColor;

  /// 아이콘 색상 (기본: 흰색)
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? AppColors.overlayMedium,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}
