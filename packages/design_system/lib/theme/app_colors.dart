import 'package:flutter/material.dart';

/// StorySpark 앱 색상 팔레트
///
/// 게임 스타일의 밝고 따뜻한 색상 시스템
abstract final class AppColors {
  // ============================================
  // 배경 색상
  // ============================================

  /// 기본 배경색 (하늘색)
  static const sky = Color(0xFF87CEEB);

  /// 하단 장식 (잔디)
  static const grass = Color(0xFF8BC34A);

  /// 장식 요소 (태양)
  static const sun = Color(0xFFFFEB3B);

  // ============================================
  // 버튼 색상 - Orange (Primary Action)
  // ============================================

  /// 주요 액션 버튼 배경 (Play, 확인 등)
  static const buttonOrange = Color(0xFFF39C12);

  /// 주요 액션 버튼 다크/보더
  static const buttonOrangeDark = Color(0xFFE67E22);

  // ============================================
  // 버튼 색상 - Green (Secondary Action)
  // ============================================

  /// 보조 액션 버튼 배경 (My Stories 등)
  static const buttonGreen = Color(0xFF2ECC71);

  /// 보조 액션 버튼 다크/보더
  static const buttonGreenDark = Color(0xFF27AE60);

  // ============================================
  // 버튼 색상 - Blue (Tertiary Action)
  // ============================================

  /// 일반 액션 버튼 배경 (Settings 등)
  static const buttonBlue = Color(0xFF3498DB);

  /// 일반 액션 버튼 다크/보더
  static const buttonBlueDark = Color(0xFF2980B9);

  // ============================================
  // 텍스트 색상
  // ============================================

  /// 기본 텍스트 색상
  static const textPrimary = Colors.white;

  /// 텍스트 그림자 (50% opacity brown)
  static const textShadow = Color(0x805D4037);

  // ============================================
  // 오버레이 색상
  // ============================================

  /// 반투명 흰색 오버레이 (카드, 버튼 배경)
  static Color overlayLight = Colors.white.withValues(alpha: 0.2);

  /// 반투명 흰색 오버레이 (버튼 hover 등)
  static Color overlayMedium = Colors.white.withValues(alpha: 0.3);

  // ============================================
  // 헬퍼 메서드
  // ============================================

  /// 텍스트 그림자 색상 (커스텀 opacity)
  static Color textShadowWithOpacity(double opacity) {
    return const Color(0xFF5D4037).withValues(alpha: opacity);
  }
}
