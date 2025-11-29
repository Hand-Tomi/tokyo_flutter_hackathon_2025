import 'package:design_system/theme/app_colors.dart';
import 'package:design_system/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// 하늘 배경 컴포넌트
///
/// 하늘색 배경, 태양, 구름, 잔디 wave를 포함한 전체 배경
class SkyBackground extends StatelessWidget {
  const SkyBackground({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 하늘색
        Container(color: AppColors.sky),

        // 태양 (우측 상단)
        const Positioned(
          top: -64,
          right: -64,
          child: _Sun(),
        ),

        // 구름 1 (좌측)
        Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          left: -80,
          child: const _Cloud(size: 160),
        ),

        // 구름 2 (우측)
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.33,
          right: -48,
          child: const _Cloud(size: 96),
        ),

        // 자식 위젯
        if (child != null) child!,

        // 하단 잔디 wave
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GrassWave(),
        ),
      ],
    );
  }
}

/// 태양 장식 요소
class _Sun extends StatelessWidget {
  const _Sun();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 192,
      height: 192,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.sun.withValues(alpha: 0.8),
      ),
    );
  }
}

/// 구름 장식 요소
class _Cloud extends StatelessWidget {
  const _Cloud({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.2),
      ),
    );
  }
}

/// 잔디 wave 컴포넌트
class GrassWave extends StatelessWidget {
  const GrassWave({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.grassWaveHeight,
      child: CustomPaint(
        size: const Size(double.infinity, AppSpacing.grassWaveHeight),
        painter: _GrassWavePainter(),
      ),
    );
  }
}

/// 잔디 wave CustomPainter
class _GrassWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.grass
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.23);

    path.cubicTo(
      size.width * 0.27,
      size.height * 0.47,
      size.width * 0.41,
      size.height * 0.12,
      size.width * 0.62,
      size.height * 0.12,
    );

    path.cubicTo(
      size.width * 0.69,
      size.height * 0.26,
      size.width * 0.76,
      size.height * 0.6,
      size.width * 0.82,
      size.height * 0.77,
    );

    path.cubicTo(
      size.width * 0.88,
      size.height * 0.93,
      size.width * 0.94,
      size.height * 0.99,
      size.width,
      size.height * 0.025,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
