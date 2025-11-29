import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// StorySpark 앱 타이포그래피
///
/// Fredoka: 제목, 버튼 (게임 느낌의 둥근 폰트)
/// Poppins: 부제목, 본문 (깔끔하고 읽기 쉬운 폰트)
abstract final class AppTypography {
  // ============================================
  // 타이틀 스타일 (Fredoka)
  // ============================================

  /// 메인 타이틀 (앱 로고)
  /// fontSize: 56, weight: 700
  static TextStyle get displayLarge => GoogleFonts.fredoka(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        shadows: [
          Shadow(
            offset: const Offset(4, 4),
            color: AppColors.textShadow,
            blurRadius: 0,
          ),
        ],
      );

  /// 페이지 헤더
  /// fontSize: 32, weight: 700
  static TextStyle get headlineLarge => GoogleFonts.fredoka(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        shadows: [
          Shadow(
            offset: const Offset(3, 3),
            color: AppColors.textShadow,
            blurRadius: 0,
          ),
        ],
      );

  /// 섹션 헤더
  /// fontSize: 24, weight: 600
  static TextStyle get headlineMedium => GoogleFonts.fredoka(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            color: AppColors.textShadow,
            blurRadius: 0,
          ),
        ],
      );

  /// 중간 디스플레이 타이틀
  /// fontSize: 40, weight: 700
  static TextStyle get displayMedium => GoogleFonts.fredoka(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        shadows: [
          Shadow(
            offset: const Offset(3, 3),
            color: AppColors.textShadow,
            blurRadius: 0,
          ),
        ],
      );

  // ============================================
  // 버튼 텍스트 스타일 (Fredoka)
  // ============================================

  /// 대형 버튼 텍스트 (PLAY 등)
  /// fontSize: 28, weight: 700, letterSpacing: 2
  static TextStyle get buttonLarge => GoogleFonts.fredoka(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 2,
      );

  /// 일반 버튼 텍스트
  /// fontSize: 22, weight: 700, letterSpacing: 1
  static TextStyle get buttonMedium => GoogleFonts.fredoka(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: 1,
      );

  /// 소형 버튼 텍스트
  /// fontSize: 18, weight: 600
  static TextStyle get buttonSmall => GoogleFonts.fredoka(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // ============================================
  // 라벨 스타일 (Fredoka)
  // ============================================

  /// 라벨 (중간)
  /// fontSize: 14, weight: 600
  static TextStyle get labelMedium => GoogleFonts.fredoka(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// 라벨 (큰)
  /// fontSize: 16, weight: 600
  static TextStyle get labelLarge => GoogleFonts.fredoka(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // ============================================
  // 본문 스타일 (Poppins)
  // ============================================

  /// 서브 타이틀
  /// fontSize: 20, weight: 500
  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary.withValues(alpha: 0.9),
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            color: AppColors.textShadowWithOpacity(0.3),
            blurRadius: 0,
          ),
        ],
      );

  /// 본문 텍스트 (큰)
  /// fontSize: 18, weight: 400
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// 본문 텍스트 (기본)
  /// fontSize: 16, weight: 400
  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// 본문 텍스트 (작은)
  /// fontSize: 14, weight: 400
  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  /// 캡션 텍스트
  /// fontSize: 12, weight: 400
  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary.withValues(alpha: 0.7),
      );

  // ============================================
  // 헬퍼 메서드
  // ============================================

  /// 그림자 없는 버전 반환
  static TextStyle withoutShadow(TextStyle style) {
    return style.copyWith(shadows: null);
  }

  /// 커스텀 색상 적용
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
}
