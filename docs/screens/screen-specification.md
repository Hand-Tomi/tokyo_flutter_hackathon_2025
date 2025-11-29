# 화면 구성 명세서

StorySpark 앱의 화면 구성을 정의합니다.

---

## 화면 흐름

```text
홈 → 장면 생성 (반복) → 장면 리스트 → 영상 생성 → 영상 재생 → 저장/공유 → 홈
```

---

## 디자인 컨셉

- **스타일**: 아이들을 위한 밝고 따뜻한 게임 스타일
- **배경**: 하늘색 + 태양 + 구름 + 잔디 (SkyBackground 컴포넌트 사용)
- **버튼**: 3D 스타일 GameButton (눌렀을 때 내려가는 효과)
- **색상**: AppColors 팔레트 (Orange/Green/Blue 버튼, 하늘색 배경)

---

## 화면 목록

### 1. 홈 화면 (Home) ✅ 구현됨

- 앱 로고 "StorySpark"
- PLAY 버튼 → 장면 생성으로 이동
- My Stories 버튼 → 장면 리스트로 이동
- Settings 버튼

### 2. 장면 생성 화면 (SceneCreation)

**핵심 기능**: 부모 음성 + 아이 스크리블로 장면 만들기

**단계별 흐름**:
1. **음성 녹음** - 마이크 버튼으로 부모가 이야기 녹음
2. **STT 확인** - 변환된 텍스트 표시 (수정 불가, 재녹음만 가능)
3. **Air Scribble** - 카메라로 아이가 허공에 그림 그리기
4. **장면 확정** - "다음 장면" 또는 "완료" 선택

**UI 상태**:
- 현재 단계 (recording/sttResult/airScribble/confirmation)
- 장면 번호
- 녹음 상태
- STT 텍스트
- 스크리블 라인들
- 이미지 생성 중 여부

### 3. 장면 리스트 화면 (SceneList)

**핵심 기능**: 생성된 장면들 관리

**구성**:
- 장면 썸네일 그리드 (생성 중이면 로딩 표시)
- 장면 추가 버튼
- 장면 삭제 기능 (선택)
- "영상 만들기" 버튼

**UI 상태**:
- 장면 목록 (id, 번호, STT텍스트, 상태, 썸네일경로, 오디오경로)
- 영상 생성 가능 여부 (모든 장면 완료 시)

### 4. 영상 생성 화면 (VideoGeneration)

**핵심 기능**: 장면들을 합쳐 MP4 영상 생성

**구성**:
- 로딩 애니메이션
- 진행률 바
- 상태 메시지 ("장면 3/5 합성 중...")

**UI 상태**:
- 생성 단계 (preparing/combiningImages/addingAudio/finalizing/completed/error)
- 진행률 (0.0~1.0)
- 현재/전체 장면 수

### 5. 영상 재생 화면 (VideoPlayback)

**핵심 기능**: 완성된 동화 영상 재생

**구성**:
- 비디오 플레이어
- 재생/일시정지 버튼
- 시간 표시 바
- "저장 & 공유" 버튼

**UI 상태**:
- 비디오 경로
- 재생 상태 (loading/playing/paused/completed)
- 현재 위치, 전체 길이

### 6. 저장/공유 화면 (SaveShare)

**핵심 기능**: 완성된 영상 저장 및 공유

**구성**:
- 영상 썸네일
- 완성 축하 메시지
- 다운로드 버튼
- 공유하기 버튼
- 홈으로 버튼

**UI 상태**:
- 비디오/썸네일 경로
- 저장 상태

---

## 파일 구조

```text
design_system/lib/
├── scene_creation/     # 장면 생성
├── scene_list/         # 장면 리스트
├── video_generation/   # 영상 생성
├── video_playback/     # 영상 재생
└── save_share/         # 저장/공유

presentation/lib/
├── scene_creation/
├── scene_list/
├── video_generation/
├── video_playback/
└── save_share/

domain/lib/
├── scene.dart          # 장면 엔티티
└── story.dart          # 동화 엔티티
```

---

## 구현 순서

1. 장면 생성 화면 → 장면 리스트 화면
2. 영상 생성 화면 → 영상 재생 화면
3. 저장/공유 화면 → 홈 네비게이션 연결
