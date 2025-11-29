/// StorySpark 앱 간격 시스템
///
/// 일관된 간격을 위한 상수 정의
abstract final class AppSpacing {
  // ============================================
  // 기본 간격
  // ============================================

  /// 4px - 아이콘과 텍스트 사이 등 최소 간격
  static const double xs = 4;

  /// 8px - 작은 요소 사이 간격
  static const double sm = 8;

  /// 16px - 기본 간격
  static const double md = 16;

  /// 24px - 버튼 사이, 섹션 내 요소 간격
  static const double lg = 24;

  /// 32px - 섹션 사이 간격
  static const double xl = 32;

  /// 48px - 큰 섹션 사이 간격
  static const double xxl = 48;

  // ============================================
  // 페이지 레이아웃
  // ============================================

  /// 페이지 좌우 패딩
  static const double pagePaddingHorizontal = 24;

  /// 페이지 상단 패딩
  static const double pagePaddingTop = 16;

  // ============================================
  // 버튼 관련
  // ============================================

  /// 버튼 사이 간격
  static const double buttonGap = 24;

  /// 대형 버튼 내부 세로 패딩
  static const double buttonPaddingLarge = 24;

  /// 일반 버튼 내부 세로 패딩
  static const double buttonPaddingMedium = 16;

  // ============================================
  // 컴포넌트 크기
  // ============================================

  /// 대형 버튼 너비
  static const double buttonWidthLarge = 320;

  /// 대형 버튼 높이
  static const double buttonHeightLarge = 160;

  /// 일반 버튼 높이
  static const double buttonHeightMedium = 80;

  /// 원형 아이콘 버튼 크기 (프로필 등)
  static const double circleButtonLarge = 64;

  /// 원형 아이콘 버튼 크기 (뒤로가기 등)
  static const double circleButtonMedium = 48;

  /// 잔디 wave 높이
  static const double grassWaveHeight = 128;

  // ============================================
  // Border Radius
  // ============================================

  /// 기본 둥근 모서리
  static const double radiusMd = 16;

  /// 작은 둥근 모서리
  static const double radiusSm = 8;

  /// 카드 둥근 모서리
  static const double radiusCard = 16;
}
