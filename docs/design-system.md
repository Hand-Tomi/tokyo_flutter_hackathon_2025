# StorySpark Design System

StorySpark 앱의 디자인 컨셉과 UI 가이드라인입니다. 모든 화면은 이 문서의 규칙을 따라 일관된 게임 스타일 UI를 구현합니다.

## 디자인 컨셉

**키워드**: 어린이 친화적, 게임 스타일, 밝고 따뜻한, 3D 느낌

StorySpark는 어린이를 위한 스토리 생성 앱으로, 모바일 게임에서 영감을 받은 친근하고 재미있는 UI를 사용합니다.

## 색상 팔레트

### 배경 색상
| 이름 | Hex | 용도 |
|------|-----|------|
| Sky Blue | `#87CEEB` | 기본 배경색 |
| Grass Green | `#8BC34A` | 하단 장식 (잔디 wave) |
| Sun Yellow | `#FFEB3B` | 장식 요소 (태양) |

### 버튼 색상 (Primary Action)
| 이름 | Hex (메인) | Hex (다크/보더) | 용도 |
|------|-----------|----------------|------|
| Orange | `#F39C12` | `#E67E22` | 주요 액션 (Play, 확인 등) |
| Green | `#2ECC71` | `#27AE60` | 보조 액션 (My Stories 등) |
| Blue | `#3498DB` | `#2980B9` | 일반 액션 (Settings 등) |

### 텍스트 색상
| 이름 | Hex | 용도 |
|------|-----|------|
| White | `#FFFFFF` | 기본 텍스트 |
| Text Shadow | `#805D4037` | 텍스트 그림자 (50% opacity) |

## 타이포그래피

### 폰트 패밀리
- **Fredoka**: 제목, 버튼 텍스트 (게임 느낌의 둥근 폰트)
- **Poppins**: 부제목, 본문 텍스트 (깔끔하고 읽기 쉬운 폰트)

### 텍스트 스타일

```dart
// 메인 타이틀 (앱 로고)
GoogleFonts.fredoka(
  fontSize: 56,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  shadows: [
    Shadow(
      offset: Offset(4, 4),
      color: Color(0x805D4037),
      blurRadius: 0,
    ),
  ],
)

// 서브 타이틀
GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.white.withOpacity(0.9),
  shadows: [
    Shadow(
      offset: Offset(2, 2),
      color: Color(0x805D4037).withOpacity(0.6),
      blurRadius: 0,
    ),
  ],
)

// 페이지 헤더
GoogleFonts.fredoka(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  color: Colors.white,
)

// 버튼 텍스트 (대형)
GoogleFonts.fredoka(
  fontSize: 28,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 2,
)

// 버튼 텍스트 (일반)
GoogleFonts.fredoka(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  letterSpacing: 1,
)

// 본문 텍스트
GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
)
```

## 컴포넌트

### 3D 게임 버튼

버튼은 눌렀을 때 "눌림" 효과를 주는 3D 스타일을 사용합니다.

**구조:**
- 메인 색상 배경
- 하단에 더 어두운 색상의 border (8px, 눌렀을 때 4px)
- 눌렀을 때 4px 아래로 이동 (transform)
- 둥근 모서리 (borderRadius: 16)

**크기:**
- 대형 버튼: 너비 320px, 높이 160px (PLAY 등 주요 액션)
- 일반 버튼: 너비 320px, 높이 80px

```dart
// 3D 버튼 효과 핵심 코드
AnimatedContainer(
  duration: Duration(milliseconds: 50),
  transform: Matrix4.translationValues(0, isPressed ? 4 : 0, 0),
  decoration: BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(16),
    border: Border(
      bottom: BorderSide(
        color: borderColorDark,
        width: isPressed ? 4 : 8,
      ),
    ),
  ),
)
```

### 원형 아이콘 버튼

프로필, 뒤로가기 등에 사용되는 반투명 원형 버튼입니다.

```dart
Container(
  width: 64,
  height: 64,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.white.withOpacity(0.3),
  ),
  child: Icon(Icons.account_circle, size: 40, color: Colors.white),
)
```

### 카드

콘텐츠를 담는 카드 컴포넌트입니다.

```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.white.withOpacity(0.3),
      width: 2,
    ),
  ),
)
```

## 레이아웃 패턴

### 기본 페이지 구조

모든 페이지는 Stack 기반의 레이어 구조를 사용합니다:

```
Stack
├── Layer 1: 배경색 (Sky Blue)
├── Layer 2: 장식 요소 (태양, 구름 등)
├── Layer 3: 메인 콘텐츠 (SafeArea)
├── Layer 4: 고정 UI (헤더, 뒤로가기 버튼)
└── Layer 5: 하단 장식 (잔디 wave)
```

### 장식 요소

**태양 (우측 상단)**
```dart
Positioned(
  top: -64,
  right: -64,
  child: Container(
    width: 192,
    height: 192,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFFFEB3B).withOpacity(0.8),
    ),
  ),
)
```

**구름 (반투명 원형)**
```dart
Positioned(
  top: MediaQuery.of(context).size.height * 0.25,
  left: -80,
  child: Container(
    width: 160,
    height: 160,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.2),
    ),
  ),
)
```

**잔디 Wave (하단)**
- 높이: 128px
- CustomPainter로 곡선 형태 구현
- 색상: Grass Green (#8BC34A)

### 간격 (Spacing)

| 용도 | 값 |
|------|-----|
| 페이지 좌우 패딩 | 24px |
| 버튼 사이 간격 | 24px |
| 섹션 사이 간격 | 48px |
| 아이콘과 텍스트 간격 | 8px (세로), 16px (가로) |

## 화면별 가이드

### 홈 화면 (Home)
- 중앙에 로고와 버튼 배치
- Spacer를 사용한 유동적 레이아웃
- 우측 상단 프로필 버튼

### 콘텐츠 목록 화면 (My Stories 등)
- 상단: 뒤로가기 버튼 + 페이지 제목
- 중앙: 스크롤 가능한 카드 리스트
- 하단: 잔디 wave 유지

### 설정 화면 (Settings)
- 상단: 뒤로가기 버튼 + 페이지 제목
- 중앙: 설정 항목 리스트 (카드 스타일)
- 하단: 잔디 wave 유지

### 플레이/생성 화면 (Play)
- 전체 화면 활용
- 단계별 진행 UI
- 하단에 주요 액션 버튼

## 애니메이션

### 버튼 눌림 효과
- Duration: 50ms
- Transform: Y축 4px 이동
- Border 변화: 8px → 4px

### 화면 전환
- 기본 Flutter 페이지 전환 사용
- 필요시 fade 또는 slide 애니메이션 추가

## 접근성

- 모든 아이콘에 텍스트 라벨 함께 표시
- 충분한 터치 영역 (최소 48x48)
- 높은 색상 대비 (흰색 텍스트 + 진한 배경)
- 큰 폰트 사이즈 (어린이 사용자 고려)

## 코드 예시: 새 페이지 템플릿

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameColors {
  static const sky = Color(0xFF87CEEB);
  static const grass = Color(0xFF8BC34A);
  static const sun = Color(0xFFFFEB3B);
  static const buttonOrange = Color(0xFFF39C12);
  static const buttonOrangeDark = Color(0xFFE67E22);
  static const buttonGreen = Color(0xFF2ECC71);
  static const buttonGreenDark = Color(0xFF27AE60);
  static const buttonBlue = Color(0xFF3498DB);
  static const buttonBlueDark = Color(0xFF2980B9);
  static const textShadow = Color(0x805D4037);
}

class NewPageTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경
          Container(color: GameColors.sky),

          // 태양
          Positioned(
            top: -64,
            right: -64,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: GameColors.sun.withOpacity(0.8),
              ),
            ),
          ),

          // 메인 콘텐츠
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // 헤더
                  _buildHeader(context),

                  // 콘텐츠
                  Expanded(
                    child: _buildContent(),
                  ),
                ],
              ),
            ),
          ),

          // 뒤로가기 버튼
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: _buildBackButton(context),
          ),

          // 잔디 wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildGrassWave(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Text(
        'Page Title',
        style: GoogleFonts.fredoka(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(3, 3),
              color: GameColors.textShadow,
              blurRadius: 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.3),
        ),
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  Widget _buildContent() {
    // 페이지별 콘텐츠 구현
    return Container();
  }

  Widget _buildGrassWave() {
    return SizedBox(
      height: 128,
      child: CustomPaint(
        size: Size(double.infinity, 128),
        painter: GrassWavePainter(),
      ),
    );
  }
}
```
