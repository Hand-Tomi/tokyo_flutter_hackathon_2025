# Flutter Clean Architecture Sample (Melos Monorepo)

Flutter Clean Architecture를 적용한 모노레포 프로젝트입니다. Melos를 사용하여 여러 패키지를 관리하며, 관심사의 명확한 분리를 갖춘 3계층 아키텍처 패턴을 보여줍니다.

## 주요 특징

- **Clean Architecture**: 엄격한 의존성 규칙을 가진 계층형 아키텍처
- **Melos Monorepo**: 여러 패키지를 효율적으로 관리
- **PageState 패턴**: 영속적인 UI 상태와 일회성 액션의 명확한 분리
- **코드 생성**: Freezed와 Riverpod을 활용한 자동 코드 생성
- **FVM**: Flutter 버전 관리로 팀 간 일관성 유지

## 기술 스택

- **Flutter**: 3.35.1 (FVM으로 관리)
- **모노레포**: Melos
- **상태 관리**: Riverpod (riverpod_annotation, riverpod_generator)
- **불변성**: Freezed
- **코드 생성**: build_runner

## 아키텍처 개요

프로젝트는 Clean Architecture를 따르며, 다음과 같은 의존성 방향을 가집니다:

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

| 계층 | 위치 | 책임 |
|------|------|------|
| **Domain** | `packages/domain/` | 순수한 비즈니스 엔티티와 규칙 (Flutter 의존성 없음) |
| **Design System** | `packages/design_system/` | 순수 UI 컴포넌트, 페이지 템플릿, UI 모델 |
| **Presentation** | `packages/presentation/` | Riverpod 상태 관리, ViewModel, Mapper |
| **Mobile App** | `apps/mobile/` | 앱 진입점 및 설정 |

## 시작하기

### 사전 요구사항

- [FVM](https://fvm.app/) 설치
- Make 명령어 사용 가능한 환경

### 초기 설정

```bash
# FVM Flutter 설치, 워크스페이스 bootstrap, 코드 생성을 한 번에 실행
make setup
```

이 명령어는 다음을 수행합니다:
1. FVM을 사용하여 Flutter 3.35.1 설치
2. Melos 워크스페이스 초기화 및 모든 패키지 의존성 설치
3. build_runner를 실행하여 필요한 코드 생성

### 앱 실행

```bash
make run
```

## 개발 명령어

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

### 개별 패키지 작업

```bash
# 특정 패키지만 빌드
make build-presentation        # presentation 패키지만 빌드
make watch-presentation        # presentation 패키지 watch 모드
make build-mobile              # mobile 앱 빌드
```

## 프로젝트 구조

```
tokyo_flutter_hackathon_2025/
├── apps/
│   └── mobile/              # 모바일 앱 진입점
├── packages/
│   ├── domain/              # 비즈니스 엔티티 (예: Todo)
│   ├── design_system/       # UI 컴포넌트와 템플릿
│   └── presentation/        # ViewModel, Page, Mapper
├── docs/                    # 문서
├── Makefile                 # 루트 레벨 개발 명령어
├── pubspec.yaml            # Melos 워크스페이스 설정
└── .fvmrc                  # Flutter 버전 지정 (3.35.1)
```

## 핵심 패턴

### PageState 패턴

이 프로젝트는 `PageState` 래퍼를 사용하여 **영속적인 UI 상태**와 **일회성 액션**을 명확하게 분리합니다:

```dart
PageState<TodoListPageUiState, TodoListPageAction>(
  uiState: TodoListPageUiState(...),  // 영속 상태 (화면에 표시되는 데이터)
  action: TodoListPageAction.none(),   // 일회성 이벤트 (다이얼로그, 화면 전환 등)
)
```

### Domain ↔ UI 모델 분리

- **Domain 모델**: 비즈니스 로직, UI 비의존적 (예: `Todo`)
- **UI 모델**: 표시 준비 완료, 포맷된 데이터 (예: `TodoUi`)
- **Mapper**: extension 메서드로 변환 (예: `Todo.toUi()`)

## 코드 생성

다음의 경우 반드시 `build_runner` 실행이 필요합니다:
- Freezed 클래스 생성/수정 (`@freezed` 어노테이션)
- Riverpod 프로바이더 생성/수정 (`@riverpod` 어노테이션)
- 도메인 모델, UI 모델, 또는 ViewModel 변경

생성 파일:
- `*.freezed.dart` - Freezed 클래스
- `*.g.dart` - Riverpod 프로바이더 및 JSON 직렬화

## 참고 문서

- [CLAUDE.md](CLAUDE.md) - Claude Code를 위한 상세한 프로젝트 가이드
- [Page 아키텍처](docs/page-architecture.md) - PageState 패턴 및 데이터 플로우 상세 문서

## 라이선스

이 프로젝트는 샘플 프로젝트로, 학습 및 참고 목적으로 사용됩니다.
