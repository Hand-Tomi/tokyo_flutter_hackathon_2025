# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

Melos로 관리되는 Flutter Clean Architecture 모노레포입니다. 관심사의 명확한 분리를 갖춘 3계층 아키텍처 패턴을 보여줍니다.

**Flutter 버전:** 3.35.1 (FVM으로 관리 - `.fvmrc` 참조)

## 아키텍처

코드베이스는 엄격한 의존성 규칙을 가진 **Clean Architecture**를 따릅니다:

```
domain (의존성 없음)
   ↑
design_system (의존성 없음)
   ↑
presentation (domain + design_system에 의존)
   ↑
apps/mobile (presentation에 의존)
```

### 계층별 책임

**1. Domain 계층** (`packages/domain/`)
- 순수한 비즈니스 엔티티와 규칙
- Flutter나 다른 패키지에 대한 의존성 없음
- Freezed를 사용한 불변 객체
- 예시: `Todo` 엔티티

**2. Design System 계층** (`packages/design_system/`)
- 순수 UI 컴포넌트 (상태 관리 없음)
- UI 모델 (예: `TodoUi` - 도메인 모델의 표시용 포맷 버전)
- 페이지 템플릿과 재사용 가능한 위젯
- UI 상태 정의 (`*_ui_state.dart`)와 액션 (`*PageAction`)

**3. Presentation 계층** (`packages/presentation/`)
- Riverpod를 사용한 상태 관리
- ViewModel (`riverpod_annotation` 사용)
- ViewModel을 Template에 연결하는 Page
- Mapper: Domain 모델 → UI 모델 (extension으로 구현, 예: `TodoMapper`)
- `PageState<TUiState, TAction>` 래퍼 정의

**4. Mobile App** (`apps/mobile/`)
- 진입점과 앱 설정
- 최소한의 로직 - 주로 조합

> **더 자세한 페이지 아키텍처 패턴은 [docs/page-architecture.md](docs/page-architecture.md)를 참조하세요.**

## 핵심 패턴

### PageState 패턴

코드베이스는 `PageState` 래퍼를 사용하여 **영속적인 UI 상태**와 **일회성 액션**을 분리합니다:

```dart
PageState<TodoListPageUiState, TodoListPageAction>(
  uiState: TodoListPageUiState(...),  // 영속 상태 (표시되는 데이터)
  action: TodoListPageAction.none(),   // 일회성 이벤트 (다이얼로그, 화면 전환)
)
```

**Page의 책임**:
- 렌더링을 위해 `uiState`를 watch
- 부수 효과(다이얼로그, 스낵바, 화면 전환)를 위해 `ref.listen`으로 `action` 감지
- 각 액션 처리 후 `onFinishedAction()` 호출하여 리셋

**ViewModel의 책임**:
- 모든 public 메서드는 `on*` 명명 규칙 사용 (예: `onAddPressed()`, `onToggleTodo(id)`)
- 영속 상태 변경을 위해 `uiState` 업데이트
- 일회성 이벤트를 위해 `action` 설정

> **PageState 패턴의 상세한 설명과 데이터 플로우는 [docs/page-architecture.md](docs/page-architecture.md)를 참조하세요.**

### Domain ↔ UI 모델 분리

- **Domain 모델** (예: `Todo`): 비즈니스 로직, UI 비의존적
- **UI 모델** (예: `TodoUi`): 표시 준비 완료, 포맷된 데이터
- **Mapper**: 변환을 위한 extension 메서드 (예: `extension TodoMapper on Todo`)

## 개발 명령어

### 초기 설정

```bash
make setup              # FVM Flutter 설치, 워크스페이스 bootstrap, build_runner 실행
```

### 일반적인 작업 흐름

```bash
make bootstrap          # Melos 워크스페이스 초기화 및 의존성 설치
make get                # 모든 패키지의 의존성 가져오기
make build-runner       # 워크스페이스 전체에서 코드 생성 (Freezed, Riverpod)
make watch              # 자동 코드 생성을 위한 watch 모드
make clean              # 빌드 캐시와 생성된 파일 정리
make test               # 모든 테스트 실행
make format             # 코드 포맷
make lint               # analyzer 실행
make run                # 모바일 앱 실행
```

### 개별 패키지 명령어

각 패키지는 자체 Makefile을 가지고 있습니다. 타겟 작업에는 다음을 사용하세요:

```bash
make build-presentation        # presentation 패키지만 빌드
make watch-presentation        # presentation 패키지 watch
make build-mobile              # mobile 앱 빌드
```

또는 패키지 디렉토리에서 직접 작업:

```bash
cd packages/presentation
fvm dart run build_runner build --delete-conflicting-outputs
fvm dart run build_runner watch --delete-conflicting-outputs
```

### 코드 생성 요구사항

**다음의 경우 반드시 `build_runner` 실행:**
- Freezed 클래스 생성/수정 (`@freezed`로 어노테이션된 클래스)
- Riverpod 프로바이더 생성/수정 (`@riverpod`로 어노테이션된 클래스)
- 도메인 모델, UI 모델, 또는 ViewModel 변경

**생성 파일 패턴:**
- `*.freezed.dart` - Freezed 클래스
- `*.g.dart` - Riverpod 프로바이더 및 JSON 직렬화

## 명명 규칙

- **ViewModel 메서드**: 모든 public 메서드는 `on*`로 시작 (예: `onButtonPressed()`)
- **UI 모델**: `Ui` 접미사 사용 (예: `TodoUi`)
- **UI 상태 클래스**: `UiState` 접미사 사용 (예: `TodoListPageUiState`)
- **액션 클래스**: `Action` 접미사 사용 (예: `TodoListPageAction`)
- **Mapper**: `to*` 이름의 extension 메서드 (예: `toUi()`)

## 워크스페이스 구조

```
tokyo_flutter_hackathon_2025/
├── apps/mobile/              # 모바일 앱 진입점
├── packages/
│   ├── domain/              # 비즈니스 엔티티 (Todo)
│   ├── design_system/       # UI 컴포넌트와 템플릿
│   └── presentation/        # ViewModel, Page, Mapper
├── Makefile                 # 루트 레벨 명령어
├── pubspec.yaml            # Melos 워크스페이스 설정
└── .fvmrc                  # Flutter 버전: 3.35.1
```

## 기술 스택

- **모노레포**: Melos
- **상태 관리**: Riverpod (`riverpod_annotation`, `riverpod_generator`)
- **불변성**: Freezed
- **코드 생성**: build_runner
- **버전 관리**: FVM

## 중요 사항

- `fvm flutter`와 `fvm dart` 명령어를 사용하세요 (Makefile에서 `FLUTTER`와 `DART`로 alias됨)
- 모든 패키지는 Melos 워크스페이스 지원을 위해 pubspec.yaml에서 `resolution: workspace` 사용
- 워크스페이스는 FVM 통합을 위해 pubspec.yaml에서 `sdkPath: .fvm/flutter_sdk`로 설정됨
- 생성된 파일 (`*.freezed.dart`, `*.g.dart`)은 수동으로 편집하지 말 것

## 참고 문서

- [Page 아키텍처 상세 문서](docs/page-architecture.md) - PageState 패턴, 데이터 플로우, 구현 예시 등 상세한 아키텍처 가이드
