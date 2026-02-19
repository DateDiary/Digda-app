# 디그다 (DiGDa) - 디지털 그룹 다이어리

Flutter로 구현한 커플/그룹을 위한 공유 다이어리 앱입니다.

## 주요 기능

- **소셜 로그인**: 카카오, 네이버, Apple 로그인
- **다이어리 그룹**: 코드로 참여하거나 새 다이어리 생성
- **일정 관리**: 캘린더 기반 일정 추가/확인
- **공유 일기**: 그룹 멤버 모두가 같은 날 일기 작성
- **퀴즈**: 서로를 얼마나 아는지 테스트 (Coming Soon)
- **투두리스트**: 함께 해야 할 일 관리
- **알림**: 일정/일기/기념일 알림

## 기술 스택

- Flutter 3.41.1 / Dart SDK >=3.2.0
- `table_calendar: ^3.1.0` — 캘린더 UI
- `go_router: ^14.0.0` — 라우팅
- `intl: ^0.19.0` — 날짜/국제화
- Inter 폰트 (400, 700 weight)

## 프로젝트 구조

```
lib/
├── main.dart               # 앱 진입점
├── app.dart                # DigdaApp (MaterialApp)
├── app_router.dart         # 명명된 라우트 맵
├── theme/
│   ├── colors.dart         # AppColors (25개 색상)
│   ├── text_styles.dart    # AppTextStyles
│   └── dimensions.dart     # AppDimensions
├── widgets/                # 공통 위젯
│   ├── primary_button.dart
│   ├── outline_button.dart
│   ├── app_bottom_nav_bar.dart
│   ├── back_header.dart
│   ├── center_title_header.dart
│   ├── feature_card.dart
│   ├── group_list_tile.dart
│   ├── notification_item.dart
│   ├── todo_item.dart
│   └── diary_list_item.dart
└── screens/
    ├── splash/             # S1: 스플래시
    ├── auth/               # S2: 소셜로그인, 약관동의
    ├── onboarding/         # S3: 빈상태, 코드생성, 다이어리생성
    ├── group/              # S4: 그룹목록, 그룹홈
    ├── schedule/           # S5: 일정캘린더, 상세, 추가
    ├── diary/              # S6: 일기캘린더, 상세, 쓰기, 수정
    ├── game/               # S7: 퀴즈(준비중)
    ├── mypage/             # S8: 마이페이지, 프로필수정, 알림설정, 개인정보
    ├── notifications/      # S9: 알림목록
    └── todo/               # S10: 투두리스트
```

## 실행 방법

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run

# 분석
flutter analyze
```

## Git 브랜치 전략

```
main ← (배포)
  └── dev ← (개발 통합)
        └── feature/* ← (기능 개발)
```

- `feature/*` → PR → squash merge → `dev`
- `dev` → PR → merge → `main` (배포 시)

## 디자인 토큰

| 항목 | 값 |
|------|-----|
| Primary | `#FF6B6B` |
| Gray900 | `#191F28` |
| 기본 폰트 | Inter |
| 버튼 높이 | 52px, radius 26px |
| 바텀 네비게이션 높이 | 70px |
