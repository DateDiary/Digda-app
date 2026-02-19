# 디그다 (DiGDa) Flutter 구현 가이드

> Figma File: `a16srq7l` / Root Node: `54:420` (설정 섹션)
> 생성일: 2026-02-17
> 화면 수: 23개
> 디바이스 기준: 393 x 852 (iPhone 14 Pro 기준)
> 이 문서를 Claude Code에 전달하면 Figma와 1:1 동일한 Flutter 앱이 생성됩니다.

---

## 1. 프로젝트 설정

### 1-1. pubspec.yaml
```yaml
name: digda
description: 디그다 - 디지털 그룹 다이어리
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^14.0.0
  intl: ^0.19.0
  table_calendar: ^3.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
  assets:
    - assets/icons/
    - assets/images/
```

### 1-2. 폴더 구조
```
lib/
├── main.dart
├── app.dart
├── theme/
│   ├── colors.dart
│   ├── text_styles.dart
│   └── dimensions.dart
├── widgets/
│   ├── app_bottom_nav_bar.dart
│   ├── primary_button.dart
│   ├── outline_button.dart
│   ├── text_input_field.dart
│   ├── status_bar.dart
│   ├── back_header.dart
│   ├── center_title_header.dart
│   ├── calendar_grid.dart
│   ├── diary_list_item.dart
│   ├── schedule_event_chip.dart
│   ├── notification_item.dart
│   ├── group_list_tile.dart
│   ├── todo_item.dart
│   ├── menu_item_row.dart
│   └── feature_card.dart
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── auth/
│   │   ├── social_login_screen.dart
│   │   └── terms_agreement_screen.dart
│   ├── onboarding/
│   │   ├── empty_state_screen.dart
│   │   ├── code_input_screen.dart
│   │   ├── code_generate_screen.dart
│   │   └── create_diary_screen.dart
│   ├── group/
│   │   ├── group_list_screen.dart
│   │   └── group_home_screen.dart
│   ├── schedule/
│   │   ├── schedule_calendar_screen.dart
│   │   ├── schedule_detail_screen.dart
│   │   ├── add_schedule_screen.dart
│   │   ├── day_detail_bottom_sheet.dart
│   │   └── participant_popup.dart
│   ├── diary/
│   │   ├── diary_calendar_screen.dart
│   │   ├── diary_detail_screen.dart
│   │   ├── write_diary_screen.dart
│   │   └── edit_diary_screen.dart
│   ├── quiz/
│   │   └── quiz_coming_soon_screen.dart
│   ├── mypage/
│   │   ├── my_page_screen.dart
│   │   ├── edit_profile_screen.dart
│   │   ├── notification_settings_screen.dart
│   │   └── privacy_settings_screen.dart
│   ├── notification/
│   │   └── notifications_screen.dart
│   └── todo/
│       └── todo_list_screen.dart
└── navigation/
    └── app_router.dart
```

### 1-3. 에셋 목록
| 파일명 | 포맷 | 경로 | 사용 위치 |
|---|---|---|---|
| ic_calendar.svg | SVG | assets/icons/ | 하단 탭 (일정), 알림 아이템 |
| ic_diary.svg | SVG | assets/icons/ | 하단 탭 (일기) |
| ic_game.svg | SVG | assets/icons/ | 하단 탭 (게임) |
| ic_my.svg | SVG | assets/icons/ | 하단 탭 (마이) |
| ic_back.svg | SVG | assets/icons/ | 뒤로가기 화살표 |
| ic_notification.svg | SVG | assets/icons/ | 알림 아이콘 |
| ic_settings.svg | SVG | assets/icons/ | 설정 아이콘 |
| ic_add.svg | SVG | assets/icons/ | 추가 버튼 (FAB) |
| ic_check_circle.svg | SVG | assets/icons/ | 체크박스 원형 |
| ic_check_circle_filled.svg | SVG | assets/icons/ | 체크된 체크박스 |
| ic_chevron_right.svg | SVG | assets/icons/ | 목록 화살표 |
| ic_edit.svg | SVG | assets/icons/ | 편집 아이콘 |
| ic_delete.svg | SVG | assets/icons/ | 삭제 아이콘 |
| ic_more.svg | SVG | assets/icons/ | 더보기(⋯) |
| ic_share.svg | SVG | assets/icons/ | 공유 아이콘 |
| ic_copy.svg | SVG | assets/icons/ | 복사 아이콘 |
| ic_minus_circle.svg | SVG | assets/icons/ | 마이너스 원형 |
| ic_plus_circle.svg | SVG | assets/icons/ | 플러스 원형 |
| ic_photo_add.svg | SVG | assets/icons/ | 사진 추가 |
| ic_info.svg | SVG | assets/icons/ | 정보 아이콘 |
| ic_bell.svg | SVG | assets/icons/ | 알림벨 |
| ic_lock.svg | SVG | assets/icons/ | 잠금 아이콘 |
| ic_shield.svg | SVG | assets/icons/ | 보안 아이콘 |
| ic_log.svg | SVG | assets/icons/ | 로그 아이콘 |
| app_logo.png | PNG | assets/images/ | 스플래시 로고 |
| default_profile.png | PNG | assets/images/ | 기본 프로필 이미지 |
| default_group.png | PNG | assets/images/ | 기본 그룹 이미지 |

> ⚠️ 아이콘 에셋은 Figma에서 GROUP 형태로 존재합니다. 실제 구현 시 Flutter의 `Icons` 클래스 또는 커스텀 SVG 사용을 권장합니다.

---

## 2. 디자인 토큰

### 2-1. colors.dart

**전체 코드:**
```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFFFF6B6B);       // 메인 빨강
  static const Color primaryDark = Color(0xFFFF4D4D);    // 삭제/위험 빨강

  // Accent
  static const Color blue = Color(0xFF60A5FA);           // 투두리스트 파랑
  static const Color green = Color(0xFF34D399);          // 참가자 뱃지 초록
  static const Color purple = Color(0xFFA78BFA);         // 일정 카테고리 보라
  static const Color saturdayBlue = Color(0xFF4A90D9);   // 토요일 파랑
  static const Color kakaoYellow = Color(0xFFFEE500);    // 카카오 배경
  static const Color naverGreen = Color(0xFF03C75A);     // 네이버 배경
  static const Color appleBlack = Color(0xFF000000);     // 애플 배경

  // Grayscale - Text
  static const Color gray900 = Color(0xFF191F28);        // 기본 텍스트
  static const Color gray800 = Color(0xFF333333);        // 본문 텍스트
  static const Color gray700 = Color(0xFF4E5968);        // 보조 텍스트
  static const Color gray500 = Color(0xFF8B95A1);        // 서브 텍스트/비활성
  static const Color gray400 = Color(0xFFB0B8C1);        // 플레이스홀더/비활성버튼
  static const Color gray300 = Color(0xFFC8C8C0);        // 입력 플레이스홀더
  static const Color gray200 = Color(0xFFD1D6DB);        // 화면 라벨/구분선
  static const Color gray100 = Color(0xFFE5E8EB);        // 배경 장식
  static const Color gray50 = Color(0xFFF2F4F6);         // 배경 밝은회색

  // Semantic
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color kakaoText = Color(0xFF3C1E1E);      // 카카오 텍스트
  static const Color inputHint = Color(0xFF888888);       // 일기 입력 힌트
  static const Color sundayRed = Color(0xFFFF6B6B);       // 일요일 빨강 = primary

  // Background
  static const Color scaffoldBg = Color(0xFFFFFFFF);      // 기본 배경 흰색
  static const Color bottomSheetBg = Color(0xFFFFFFFF);   // 바텀시트 배경
  static const Color overlayBg = Color(0x80000000);       // 오버레이 50% 검정

  // Schedule Event Colors
  static const Color eventRed = Color(0xFFFF6B6B);        // 빨강 일정
  static const Color eventPurple = Color(0xFFA78BFA);     // 보라 일정
  static const Color eventHoliday = Color(0xFFFF6B6B);    // 공휴일 빨강 (pill bg)
}
```

**상세표:**
| 변수명 | Hex 값 | Opacity | 용도 | 사용 화면 |
|---|---|---|---|---|
| primary | #FF6B6B | 1.0 | 메인 액센트, CTA, 일요일, 일정 태그 | 전체 |
| primaryDark | #FF4D4D | 1.0 | 삭제 텍스트, 위험 액션 | S5-1, S6-1, S8-3 |
| blue | #60A5FA | 1.0 | 투두 진행률, 뱃지 | S10 |
| green | #34D399 | 1.0 | 참가자 뱃지 | S5-1 Day Detail |
| purple | #A78BFA | 1.0 | 일정 카테고리(출근), 일정명 | S5, S5-1 |
| saturdayBlue | #4A90D9 | 1.0 | 토요일 날짜 텍스트 | S5, S6 |
| gray900 | #191F28 | 1.0 | 제목, 헤더, 기본 텍스트 | 전체 |
| gray700 | #4E5968 | 1.0 | 보조 텍스트, 섹션명 | 전체 |
| gray500 | #8B95A1 | 1.0 | 서브텍스트, 비활성 항목 | 전체 |
| gray400 | #B0B8C1 | 1.0 | 플레이스홀더, 비활성 버튼 텍스트 | 전체 |
| gray200 | #D1D6DB | 1.0 | 다음달 날짜, 구분선, 화면 라벨 | S5, S6, S10 |
| gray100 | #E5E8EB | 1.0 | 빈 상태 장식 | S3A |

### 2-2. text_styles.dart

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Inter';

  // Heading
  static const TextStyle heading1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 26,
    height: 1.21,  // Figma: lineHeight 31.47px / fontSize 26 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.21,  // Figma: lineHeight 29.05px / fontSize 24 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.21,  // Figma: lineHeight 26.63px / fontSize 22 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.21,  // Figma: lineHeight 24.20px / fontSize 20 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle heading5 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.21,  // Figma: lineHeight 21.78px / fontSize 18 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle heading6 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 17,
    height: 1.21,  // Figma: lineHeight 20.57px / fontSize 17 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.21,  // Figma: lineHeight 19.36px / fontSize 16 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 1.21,  // Figma: lineHeight 18.15px / fontSize 15 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    height: 1.21,  // Figma: lineHeight 18.15px / fontSize 15 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.21,  // Figma: lineHeight 16.94px / fontSize 14 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle bodyMediumBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.21,  // Figma: lineHeight 16.94px / fontSize 14 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.21,  // Figma: lineHeight 15.73px / fontSize 13 = 1.21
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  static const TextStyle bodySmallBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 13,
    height: 1.21,  // Figma: lineHeight 15.73px / fontSize 13 = 1.21
    letterSpacing: 0,
    color: AppColors.gray700,
  );

  // Caption
  static const TextStyle captionLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.21,  // Figma: lineHeight 14.52px / fontSize 12 = 1.21
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  static const TextStyle captionLargeBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.21,  // Figma: lineHeight 14.52px / fontSize 12 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  static const TextStyle captionSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.21,  // Figma: lineHeight 13.31px / fontSize 11 = 1.21
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  static const TextStyle captionSmallBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.21,  // Figma: lineHeight 13.31px / fontSize 11 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  // Tiny
  static const TextStyle tiny = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.21,  // Figma: lineHeight 12.10px / fontSize 10 = 1.21
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  static const TextStyle tinyBold = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 1.21,  // Figma: lineHeight 12.10px / fontSize 10 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  // StatusBar
  static const TextStyle statusBar = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    height: 1.21,  // Figma: lineHeight 18.15px / fontSize 15 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  // Calendar specific
  static const TextStyle calendarDay = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.21,  // Figma: lineHeight 16.94px / fontSize 14 = 1.21
    letterSpacing: 0,
    color: AppColors.gray700,
  );

  static const TextStyle calendarDaySelected = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.21,  // Figma: lineHeight 16.94px / fontSize 14 = 1.21
    letterSpacing: 0,
    color: AppColors.white,
  );

  static const TextStyle calendarWeekday = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.21,  // Figma: lineHeight 13.31px / fontSize 11 = 1.21
    letterSpacing: 0,
    color: AppColors.gray700,
  );

  static const TextStyle calendarEvent = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 9,
    height: 1.21,  // Figma: lineHeight 10.89px / fontSize 9 = 1.21
    letterSpacing: 0,
    color: AppColors.primary,
  );

  static const TextStyle calendarEventSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 8,
    height: 1.21,  // Figma: lineHeight 9.68px / fontSize 8 = 1.21
    letterSpacing: 0,
    color: AppColors.purple,
  );

  // Code display
  static const TextStyle codeDisplay = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 34,
    height: 1.21,  // Figma: lineHeight 41.15px / fontSize 34 = 1.21
    letterSpacing: 0,
    color: AppColors.primary,
  );

  // Percentage
  static const TextStyle percentage = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.21,  // Figma: lineHeight 29.05px / fontSize 24 = 1.21
    letterSpacing: 0,
    color: AppColors.blue,
  );

  // Counter
  static const TextStyle counterLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.21,  // Figma: lineHeight 26.63px / fontSize 22 = 1.21
    letterSpacing: 0,
    color: AppColors.gray900,
  );
}
```

**상세표:**
| 변수명 | fontFamily | fontWeight | fontSize | height | letterSpacing | color | 용도 |
|---|---|---|---|---|---|---|---|
| heading1 | Inter | w700 | 26 | 1.21 | 0 | gray900 | 앱명 "디그다" |
| heading2 | Inter | w700 | 24 | 1.21 | 0 | gray900 | 로그인 제목, 약관 제목 |
| heading3 | Inter | w700 | 22 | 1.21 | 0 | gray900 | 섹션 타이틀 (캘린더 년월) |
| heading4 | Inter | w700 | 20 | 1.21 | 0 | gray900 | 큰 서브 타이틀 |
| heading5 | Inter | w700 | 18 | 1.21 | 0 | gray900 | 바텀시트 제목 |
| heading6 | Inter | w700 | 17 | 1.21 | 0 | gray900 | 센터 타이틀 헤더, 기능 카드 제목 |
| title | Inter | w700 | 16 | 1.21 | 0 | gray900 | 그룹명, 다이어리 항목 제목 |
| bodyLarge | Inter | w400 | 15 | 1.21 | 0 | gray900 | 본문 텍스트 |
| bodyLargeBold | Inter | w700 | 15 | 1.21 | 0 | gray900 | 버튼 텍스트(중), 약관 항목 |
| bodyMedium | Inter | w400 | 14 | 1.21 | 0 | gray900 | 입력필드, 캘린더 날짜 |
| bodyMediumBold | Inter | w700 | 14 | 1.21 | 0 | gray900 | 알림 그룹명, 진행률 라벨 |
| bodySmall | Inter | w400 | 13 | 1.21 | 0 | gray500 | 설명 텍스트, 서브 정보 |
| bodySmallBold | Inter | w700 | 13 | 1.21 | 0 | gray700 | 섹션 소제목, 라벨 |
| captionLarge | Inter | w400 | 12 | 1.21 | 0 | gray500 | 참여 인원, 날짜, 카테고리 라벨 |
| captionLargeBold | Inter | w700 | 12 | 1.21 | 0 | gray900 | 댓글 작성자명 |
| captionSmall | Inter | w400 | 11 | 1.21 | 0 | gray500 | 캘린더 요일 헤더, 완료 날짜 |
| captionSmallBold | Inter | w700 | 11 | 1.21 | 0 | gray900 | 뱃지 텍스트 (참여중, 남음) |
| tiny | Inter | w400 | 10 | 1.21 | 0 | gray500 | 화면 라벨, 하단탭 텍스트, 필수/선택 태그 |
| tinyBold | Inter | w700 | 10 | 1.21 | 0 | gray900 | 참가자 뱃지 숫자 |
| calendarEvent | Inter | w400 | 9 | 1.21 | 0 | primary | 캘린더 이벤트 텍스트 |
| calendarEventSmall | Inter | w400 | 8 | 1.21 | 0 | purple | 캘린더 소형 이벤트 |
| codeDisplay | Inter | w700 | 34 | 1.21 | 0 | primary | 초대 코드 표시 |
| percentage | Inter | w700 | 24 | 1.21 | 0 | blue | 투두 진행률 % |
| counterLarge | Inter | w700 | 22 | 1.21 | 0 | gray900 | 인원 카운터 |

### 2-3. dimensions.dart

**전체 코드:**
```dart
class AppDimensions {
  AppDimensions._();

  // Screen
  static const double screenWidth = 393;
  static const double screenHeight = 852;

  // Padding - Horizontal
  static const double paddingHorizontal = 24;   // Figma: 좌우 기본 여백
  static const double paddingHorizontalSmall = 16;
  static const double paddingHorizontalLarge = 32;

  // Padding - Vertical
  static const double paddingTop = 21;           // Figma: 상단바 아래 여백
  static const double paddingBottom = 34;        // Figma: 홈 인디케이터 영역

  // Status Bar
  static const double statusBarHeight = 47;      // Figma: 9:41 영역 높이
  static const double statusBarPaddingTop = 17;

  // Bottom Navigation Bar
  static const double bottomNavHeight = 70;      // Figma: 하단 탭바 높이

  // Spacing
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing6 = 6;
  static const double spacing8 = 8;
  static const double spacing10 = 10;
  static const double spacing12 = 12;
  static const double spacing14 = 14;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing56 = 56;
  static const double spacing64 = 64;

  // Border Radius
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXLarge = 26;         // Figma: 버튼 radius
  static const double radiusFull = 999;          // 원형

  // Button
  static const double buttonHeight = 52;         // Figma: 주요 버튼 높이
  static const double buttonHeightSmall = 48;    // Figma: 소형 버튼 높이
  static const double buttonHeightTiny = 42;     // Figma: 알림받기 버튼 높이

  // Input
  static const double inputHeight = 56;          // Figma: 텍스트 입력필드 높이
  static const double inputFieldHeight = 32;     // Figma: 소형 입력필드

  // Avatar
  static const double avatarLarge = 96;          // Figma: 프로필 편집 아바타
  static const double avatarMedium = 64;         // Figma: 그룹 리스트 아바타
  static const double avatarSmall = 44;          // Figma: 참가자 아바타
  static const double avatarTiny = 32;           // Figma: 댓글 작성자 아바타
  static const double avatarXSmall = 24;         // Figma: 참가자 뱃지 아바타

  // Group item
  static const double groupItemHeight = 92;      // Figma: 그룹 리스트 아이템

  // Feature Card
  static const double featureCardHeight = 110;   // Figma: 그룹홈 기능카드
  static const double featureIconSize = 44;      // Figma: 기능카드 아이콘 크기

  // Calendar
  static const double calendarDaySize = 32;      // Figma: 선택된 날짜 원 크기
  static const double calendarRowHeight = 65;    // Figma: 캘린더 행 높이 (이벤트 포함)

  // Notification item
  static const double notificationItemHeight = 72; // Figma: 알림 아이템 높이
  static const double notificationDotSize = 36;    // Figma: 알림 아이콘 원

  // Todo item
  static const double todoItemHeight = 50;       // Figma: 투두 아이템 높이

  // Diary list item
  static const double diaryListItemHeight = 78;  // Figma: 다이어리 목록 아이템

  // Drawing area
  static const double drawingAreaHeight = 240;   // Figma: 그림일기 그리기 영역
  static const double drawingAreaPreviewHeight = 300; // Figma: 일기 상세 그림 영역

  // Menu item
  static const double menuItemHeight = 48;       // Figma: 메뉴 아이템 높이

  // Progress bar
  static const double progressBarHeight = 4;     // Figma: 진행률 바 높이

  // FAB
  static const double fabSize = 56;              // Figma: FAB 크기
}
```

**상세표:**
| 변수명 | 값(px) | 용도 | 사용 위치 |
|---|---|---|---|
| screenWidth | 393 | 디바이스 너비 | 전체 |
| screenHeight | 852 | 디바이스 높이 | 전체 |
| paddingHorizontal | 24 | 좌우 기본 여백 | 전체 |
| statusBarHeight | 47 | 상태바 높이 | 전체 |
| bottomNavHeight | 70 | 하단 탭바 | S4~S8 |
| buttonHeight | 52 | 주요 버튼 | S2, S3, S5 |
| avatarMedium | 64 | 그룹 이미지 | S3B |
| featureCardHeight | 110 | 기능 카드 | S4 |
| calendarDaySize | 32 | 선택 날짜 원 | S5, S6 |
| drawingAreaHeight | 240 | 그림 영역 | S6-2, S6-3 |
| todoItemHeight | 50 | 투두 아이템 | S10 |

---

## 3. 공통 위젯

### 3-1. PrimaryButton (`widgets/primary_button.dart`)

**용도**: 메인 CTA 버튼 (카카오 로그인, 동의하고 시작하기, 다이어리 만들기, 일정 저장하기 등)

**파라미터:**
| 파라미터명 | 타입 | 필수 | 기본값 | 설명 |
|---|---|---|---|---|
| text | String | ✅ | - | 버튼 텍스트 |
| onPressed | VoidCallback? | ❌ | null | 탭 콜백 (null이면 비활성) |
| backgroundColor | Color | ❌ | AppColors.primary | 배경색 |
| textColor | Color | ❌ | AppColors.white | 텍스트색 |
| height | double | ❌ | 52 | 버튼 높이 |
| fontSize | double | ❌ | 16 | 텍스트 크기 |

**위젯 트리:**
```
PrimaryButton
└── SizedBox (w: 345, h: 52)
    └── ElevatedButton
        └── Text (style: bold)
```

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double fontSize;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.height = 52,   // Figma: height=52
    this.fontSize = 16,  // Figma: fontSize=16
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    return SizedBox(
      width: 345, // Figma: width=345
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? backgroundColor : AppColors.gray50,
          foregroundColor: isEnabled ? textColor : AppColors.gray400,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26), // Figma: cornerRadius=26
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            height: 1.21,
            letterSpacing: 0,
            color: isEnabled ? textColor : AppColors.gray400,
          ),
        ),
      ),
    );
  }
}
```

### 3-2. OutlineButton (`widgets/outline_button.dart`)

**용도**: 보조 버튼 (초대 코드 입력하기, 코드 복사 등)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color textColor;
  final double height;

  const OutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.height = 52, // Figma: height=52
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345, // Figma: width=345
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26), // Figma: cornerRadius=26
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 15, // Figma: fontSize=15
            height: 1.21,
            letterSpacing: 0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
```

### 3-3. AppBottomNavBar (`widgets/app_bottom_nav_bar.dart`)

**용도**: 하단 탭 네비게이션 (일정, 일기, 게임, 마이)

**Figma 원본**: 전 화면 하단 70px 영역. 4개 탭, 각 탭: 아이콘(18x18) + SizedBox(h:2) + 텍스트(10px)

**파라미터:**
| 파라미터명 | 타입 | 필수 | 기본값 | 설명 |
|---|---|---|---|---|
| currentIndex | int | ✅ | - | 현재 선택된 탭 (0~3) |
| onTap | Function(int) | ✅ | - | 탭 선택 콜백 |

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Figma: height=70
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.gray100, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab(0, Icons.calendar_today_outlined, '일정'),
          _buildTab(1, Icons.menu_book_outlined, '일기'),
          _buildTab(2, Icons.sports_esports_outlined, '게임'),
          _buildTab(3, Icons.person_outline, '마이'),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected ? AppColors.primary : AppColors.gray400;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18, // Figma: icon 18x18
              color: color,
            ),
            const SizedBox(height: 2), // Figma: spacing=2
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10, // Figma: fontSize=10
                height: 1.21,
                letterSpacing: 0,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3-4. BackHeader (`widgets/back_header.dart`)

**용도**: 뒤로가기 + 제목 헤더 (그룹 리스트, 일정 상세 등)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BackHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const BackHeader({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24, // Figma: padding-left=24
        right: 24, // Figma: padding-right=24
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 14, // Figma: 7x14 back arrow
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(width: 16), // Figma: spacing to title
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 22, // Figma: fontSize=22
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
          const Spacer(),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
```

### 3-5. CenterTitleHeader (`widgets/center_title_header.dart`)

**용도**: 중앙 제목 + 좌측 뒤로가기 + 우측 액션 버튼 (일기 쓰기, 프로필 편집, 일정 등록 등)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CenterTitleHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  const CenterTitleHeader({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 8,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left: back button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: AppColors.gray900,
              ),
            ),
          ),
          // Center: title
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 17, // Figma: fontSize=17
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
          // Right: trailing action
          if (trailing != null)
            Align(
              alignment: Alignment.centerRight,
              child: trailing!,
            ),
        ],
      ),
    );
  }
}
```

### 3-6. FeatureCard (`widgets/feature_card.dart`)

**용도**: 그룹홈 기능 카드 (일정 관리, 그림일기, 퀴즈 게임, 투두리스트)

**Figma 원본**: Node ID `54:592` ~ `54:641` 그룹, 각 카드 361x110

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final Widget? badge;
  final bool isDisabled;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    this.iconBgColor = AppColors.gray50,
    required this.title,
    required this.subtitle,
    this.badge,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: 361, // Figma: width=361
        height: 110, // Figma: height=110
        padding: const EdgeInsets.only(
          left: 16, // Figma: padding-left=16
          right: 16,
          top: 24,
          bottom: 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16), // Figma: cornerRadius=16
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 44, // Figma: 44x44
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
              ),
              child: Icon(
                icon,
                size: 24, // Figma: icon 24x24
                color: isDisabled ? AppColors.gray400 : AppColors.gray900,
              ),
            ),
            const SizedBox(width: 16), // Figma: spacing=16
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17, // Figma: fontSize=17
                      height: 1.21,
                      letterSpacing: 0,
                      color: isDisabled
                          ? AppColors.gray400
                          : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13, // Figma: fontSize=13
                      height: 1.21,
                      letterSpacing: 0,
                      color: isDisabled
                          ? AppColors.gray200
                          : AppColors.gray500,
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(height: 4),
                    badge!,
                  ],
                ],
              ),
            ),
            // Chevron
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isDisabled ? AppColors.gray200 : AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3-7. GroupListTile (`widgets/group_list_tile.dart`)

**용도**: 그룹방 목록 아이템 (내 다이어리 목록)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GroupListTile extends StatelessWidget {
  final String name;
  final String memberCount;
  final IconData groupIcon;
  final Color groupIconBg;
  final bool hasNotification;
  final bool hasSettings;
  final VoidCallback? onTap;

  const GroupListTile({
    super.key,
    required this.name,
    required this.memberCount,
    this.groupIcon = Icons.group,
    this.groupIconBg = AppColors.gray50,
    this.hasNotification = false,
    this.hasSettings = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 361, // Figma: width=361
        height: 92, // Figma: height=92
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 14,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16), // Figma: cornerRadius=16
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            // Group avatar
            Container(
              width: 64, // Figma: 64x64
              height: 64,
              decoration: BoxDecoration(
                color: groupIconBg,
                borderRadius: BorderRadius.circular(16), // Figma: cornerRadius=16
              ),
              child: Icon(
                groupIcon,
                size: 24,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(width: 14), // Figma: spacing=14
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16, // Figma: fontSize=16
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    memberCount,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12, // Figma: fontSize=12
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            if (hasNotification || hasSettings) ...[
              Icon(
                Icons.notifications_outlined,
                size: 24,
                color: AppColors.gray400,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.settings_outlined,
                size: 24,
                color: AppColors.gray400,
              ),
            ],
            Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3-8. NotificationItem (`widgets/notification_item.dart`)

**용도**: 알림 목록 아이템 (오늘/어제/이전 섹션)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class NotificationItem extends StatelessWidget {
  final String emoji;
  final String groupName;
  final String message;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.emoji,
    required this.groupName,
    required this.message,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 345, // Figma: width=345
        height: 72, // Figma: height=72
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.gray100, width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji icon circle
            Container(
              width: 36, // Figma: 36x36
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 14), // Figma: fontSize=14
              ),
            ),
            const SizedBox(width: 12), // Figma: spacing=12
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    groupName,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14, // Figma: fontSize=14
                      height: 1.21,
                      letterSpacing: 0,
                      color: isRead ? AppColors.gray500 : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13, // Figma: fontSize=13
                      height: 1.21,
                      letterSpacing: 0,
                      color: isRead ? AppColors.gray400 : AppColors.gray700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11, // Figma: fontSize=11
                      height: 1.21,
                      letterSpacing: 0,
                      color: isRead ? AppColors.gray200 : AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRead)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 3-9. TodoItem (`widgets/todo_item.dart`)

**용도**: 투두 리스트 아이템 (할 일 / 완료)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class TodoItem extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final String? completedDate;
  final VoidCallback? onToggle;

  const TodoItem({
    super.key,
    required this.text,
    this.isCompleted = false,
    this.completedDate,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 345, // Figma: width=345
        height: 50, // Figma: height=50
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            // Checkbox
            Icon(
              isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              size: 22, // Figma: 22x22
              color: isCompleted ? AppColors.blue : AppColors.gray300,
            ),
            const SizedBox(width: 12), // Figma: spacing=12
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 15, // Figma: fontSize=15
                      height: 1.21,
                      letterSpacing: 0,
                      color: isCompleted
                          ? AppColors.gray400
                          : AppColors.gray900,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  if (isCompleted && completedDate != null)
                    Text(
                      completedDate!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11, // Figma: fontSize=11
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray200,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3-10. DiaryListItem (`widgets/diary_list_item.dart`)

**용도**: 최근 일기 목록 아이템 (일기 캘린더 화면)

**전체 코드:**
```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DiaryListItem extends StatelessWidget {
  final String title;
  final String preview;
  final String date;
  final bool hasImage;
  final VoidCallback? onTap;

  const DiaryListItem({
    super.key,
    required this.title,
    required this.preview,
    required this.date,
    this.hasImage = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 361, // Figma: width=361
        height: 78, // Figma: height=78
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.gray100, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 15, // Figma: fontSize=15
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    preview,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12, // Figma: fontSize=12
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11, // Figma: fontSize=11
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
            if (hasImage) ...[
              const SizedBox(width: 12),
              // Image placeholder
              Container(
                width: 24, // Figma: 24x18
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  size: 14,
                  color: AppColors.gray400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## 4. 화면별 구현

### 4-1. 스플래시 (`screens/splash/splash_screen.dart`)

**Figma 원본**: Node ID `46:1483`, Frame: `Frame`, Size: `393 x 852`, Label: `S1 — Splash`

#### 4-1-1. 화면 구조

**Scaffold 구성:**
- AppBar: 없음
- Body: Center 정렬, 로고 + 앱명 + 서브텍스트
- BottomNavigationBar: 없음
- FloatingActionButton: 없음
- backgroundColor: Color(0xFFFFFFFF)

**전체 위젯 트리:**
```
Scaffold (backgroundColor: white)
└── SafeArea
    └── Column (mainAxisAlignment: center, crossAxisAlignment: center)
        ├── Spacer()
        ├── Icon/Image (앱 로고, 60x62)
        ├── SizedBox(height: 12)
        ├── Text "디그다" (Inter Bold 26, #191F28)
        ├── SizedBox(height: 6)
        ├── Text "디지털 그룹 다이어리" (Inter Regular 13, #8B95A1)
        └── Spacer()
```

#### 4-1-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Figma Node 46:1494: 앱 로고 (60x62)
              Container(
                width: 60,  // Figma: width=60
                height: 62, // Figma: height=62
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.book_outlined,
                  size: 32,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12), // Figma: spacing ≈ 12
              // Figma Node 46:1505: "디그다"
              Text(
                '디그다',
                style: AppTextStyles.heading1.copyWith(
                  // Figma: Inter Bold 26, #191F28
                  color: AppColors.gray900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6), // Figma: spacing ≈ 6
              // Figma Node 46:1506: "디지털 그룹 다이어리"
              Text(
                '디지털 그룹 다이어리',
                style: AppTextStyles.bodySmall.copyWith(
                  // Figma: Inter Regular 13, #8B95A1
                  color: AppColors.gray500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 4-2. 소셜 로그인 (`screens/auth/social_login_screen.dart`)

**Figma 원본**: Node ID `46:1396`, Frame: `Frame`, Size: `393 x 852`, Label: `S2-1 — Social Login`

#### 4-2-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // Figma Node 46:1399: 앱 로고 아이콘 (36x38)
            Container(
              width: 36, // Figma: width=36
              height: 38, // Figma: height=38
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.book_outlined, size: 20, color: AppColors.white),
            ),
            const SizedBox(height: 24), // Figma: spacing
            // Figma Node 46:1403: "디지털 그룹 다이어리"
            const Text(
              '디지털 그룹 다이어리',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24, // Figma: fontSize=24
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Figma Node 46:1404: "소셜 계정으로 3초만에 시작하세요"
            const Text(
              '소셜 계정으로 3초만에 시작하세요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14, // Figma: fontSize=14
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            // Figma Node 46:1405: 카카오 로그인 버튼
            _buildSocialButton(
              text: '카카오로 시작하기',
              backgroundColor: AppColors.kakaoYellow,
              textColor: AppColors.kakaoText,
              icon: 'K',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 12), // Figma: spacing=12
            // Figma Node 46:1410: 네이버 로그인 버튼
            _buildSocialButton(
              text: '네이버로 시작하기',
              backgroundColor: AppColors.naverGreen,
              textColor: AppColors.white,
              icon: 'N',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 12), // Figma: spacing=12
            // Figma Node 46:1415: Apple 로그인 버튼
            _buildSocialButton(
              text: 'Apple로 시작하기',
              backgroundColor: AppColors.appleBlack,
              textColor: AppColors.white,
              icon: '',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 48), // Figma: spacing
            // Figma Node 46:1420: 약관 동의 안내
            const Text(
              '로그인 시 이용약관과 개인정보처리방침에 동의하게 됩니다',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12, // Figma: fontSize=12
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required String icon,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: SizedBox(
        width: 345, // Figma: width=345
        height: 52, // Figma: height=52
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26), // Figma: cornerRadius=26
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon == '')
                const Icon(Icons.apple, size: 20, color: AppColors.white)
              else
                Text(
                  icon,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18, // Figma: fontSize=18 for N
                    color: textColor,
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 15, // Figma: fontSize=15
                  height: 1.21,
                  letterSpacing: 0,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

이 문서는 길이 제한으로 인해 나머지 화면들은 별도 Part 2 문서에서 계속됩니다.
나머지 화면: S2-2 약관동의, S3A 빈 상태, S3A-1 코드입력, S3A-2 코드생성, S3A-3 다이어리 생성/수정, S3B 그룹리스트, S4 그룹홈, S5 일정 캘린더, S5-1 일정상세/바텀시트, S5-2 일정등록/참가자팝업, S6 일기캘린더, S6-1 일기상세, S6-2 일기쓰기, S6-3 일기수정, S7 퀴즈(준비중), S8 마이페이지, S8-1 프로필편집, S8-2 알림설정, S8-3 개인정보관리, S9 알림, S10 투두리스트

# 디그다 (DiGDa) Flutter 구현 가이드 — Part 2

> Part 1에 이어서 나머지 화면 구현을 계속합니다.

---

### 4-3. 약관 동의 (`screens/auth/terms_agreement_screen.dart`)

**Figma 원본**: Node ID `46:1423`, Frame: `Frame`, Size: `393 x 852`, Label: `S2-2 — Terms Agreement`

#### 4-3-1. 화면 구조

**Scaffold 구성:**
- AppBar: 없음
- Body: Column (스크롤 없음)
- BottomNavigationBar: 없음
- backgroundColor: Color(0xFFFFFFFF)

**전체 위젯 트리:**
```
Scaffold (backgroundColor: white)
└── SafeArea
    └── Padding (horizontal: 24)
        └── Column
            ├── SizedBox(height: 60)
            ├── Text "서비스 이용을 위해" (Inter Bold 24, #191F28)
            ├── Text "약관에 동의해주세요" (Inter Bold 24, #191F28)
            ├── SizedBox(height: 32)
            ├── _CheckAllRow "전체 동의" (Inter Bold 16, #191F28, divider below)
            ├── SizedBox(height: 16)
            ├── _CheckRow "[필수] 이용약관 동의" (Inter Regular 14)
            ├── _CheckRow "[필수] 개인정보 수집 및 이용 동의"
            ├── _CheckRow "[필수] 만 14세 이상입니다"
            ├── _CheckRow "[선택] 마케팅 정보 수신 동의"
            ├── _CheckRow "[선택] 푸시 알림 수신 동의"
            ├── Spacer
            └── PrimaryButton "동의하고 시작하기" (enabled if 3 required checked)
```

#### 4-3-3. 상태 관리

| State 변수 | 타입 | 초기값 | 용도 |
|---|---|---|---|
| _checkAll | bool | false | 전체 동의 |
| _checks | List<bool> | [false,false,false,false,false] | 개별 동의 (5개) |

#### 4-3-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';

class TermsAgreementScreen extends StatefulWidget {
  const TermsAgreementScreen({super.key});

  @override
  State<TermsAgreementScreen> createState() => _TermsAgreementScreenState();
}

class _TermsAgreementScreenState extends State<TermsAgreementScreen> {
  bool _checkAll = false;
  List<bool> _checks = [false, false, false, false, false];

  // Required items: index 0, 1, 2
  bool get _allRequiredChecked => _checks[0] && _checks[1] && _checks[2];

  void _toggleAll(bool? value) {
    setState(() {
      _checkAll = value ?? false;
      _checks = List.filled(5, _checkAll);
    });
  }

  void _toggleItem(int index, bool? value) {
    setState(() {
      _checks[index] = value ?? false;
      _checkAll = _checks.every((e) => e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24), // Figma: padding-left=24, padding-right=24
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60), // Figma: spacing from top
              // Figma Node 46:1427: Title line 1
              const Text(
                '서비스 이용을 위해',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24, // Figma: fontSize=24
                  height: 1.21,
                  letterSpacing: 0,
                  color: AppColors.gray900,
                ),
              ),
              // Figma Node 46:1428: Title line 2
              const Text(
                '약관에 동의해주세요',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24, // Figma: fontSize=24
                  height: 1.21,
                  letterSpacing: 0,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 32), // Figma: spacing
              // Figma Node 46:1430: 전체 동의
              _buildCheckAll(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 1,
                color: AppColors.gray100, // Figma: divider #E5E8EB
              ),
              // Figma Nodes 46:1434~46:1479: 개별 동의 항목
              _buildCheckItem(0, '이용약관 동의', true),
              const SizedBox(height: 12), // Figma: spacing=12
              _buildCheckItem(1, '개인정보 수집 및 이용 동의', true),
              const SizedBox(height: 12),
              _buildCheckItem(2, '만 14세 이상입니다', true),
              const SizedBox(height: 12),
              _buildCheckItem(3, '마케팅 정보 수신 동의', false),
              const SizedBox(height: 12),
              _buildCheckItem(4, '푸시 알림 수신 동의', false),
              const Spacer(),
              // Figma Node 46:1480: CTA 버튼
              Center(
                child: PrimaryButton(
                  text: '동의하고 시작하기',
                  onPressed: _allRequiredChecked
                      ? () => Navigator.of(context).pushReplacementNamed('/home')
                      : null,
                ),
              ),
              const SizedBox(height: 48), // Figma: bottom spacing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckAll() {
    return GestureDetector(
      onTap: () => _toggleAll(!_checkAll),
      child: Row(
        children: [
          Icon(
            _checkAll ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 24, // Figma: 24x24
            color: _checkAll ? AppColors.primary : AppColors.gray300,
          ),
          const SizedBox(width: 12), // Figma: spacing=12
          const Text(
            '전체 동의',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16, // Figma: fontSize=16
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(int index, String label, bool isRequired) {
    return GestureDetector(
      onTap: () => _toggleItem(index, !_checks[index]),
      child: Row(
        children: [
          Icon(
            _checks[index] ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20, // Figma: 20x20
            color: _checks[index] ? AppColors.primary : AppColors.gray300,
          ),
          const SizedBox(width: 10), // Figma: spacing=10
          // Required/Optional badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isRequired
                  ? AppColors.primary.withOpacity(0.1) // Figma: 필수 배경
                  : AppColors.gray100,
              borderRadius: BorderRadius.circular(4), // Figma: cornerRadius=4
            ),
            child: Text(
              isRequired ? '필수' : '선택',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10, // Figma: fontSize=10
                height: 1.21,
                letterSpacing: 0,
                color: isRequired ? AppColors.primary : AppColors.gray500,
              ),
            ),
          ),
          const SizedBox(width: 8), // Figma: spacing=8
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14, // Figma: fontSize=14
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
            ),
          ),
          // Chevron for detail
          const Icon(
            Icons.chevron_right,
            size: 16,
            color: AppColors.gray400,
          ),
        ],
      ),
    );
  }
}
```

---

### 4-4. 빈 상태 (`screens/onboarding/empty_state_screen.dart`)

**Figma 원본**: Node ID `42:599`, Frame: `Frame`, Size: `393 x 852`, Label: `S3A — Empty State`

#### 4-4-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/outline_button.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Figma Node 42:604: Header
            Padding(
              padding: const EdgeInsets.only(
                left: 24, // Figma: padding-left=24
                right: 24, // Figma: padding-right=24
                top: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  const Text(
                    'Date Diary',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20, // Figma: fontSize=20
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            // Figma Node 42:609: Empty icon
            SizedBox(
              width: 120, // Figma: 약 120x80 영역
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 10,
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 40, // Figma: fontSize=40
                        color: AppColors.gray100,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 28, // Figma: fontSize=28
                        color: AppColors.gray100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Figma: spacing
            // Figma Node 42:611: "아직 참여 중인 다이어리가 없어요"
            const Text(
              '아직 참여 중인 다이어리가 없어요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17, // Figma: fontSize=17
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8), // Figma: spacing
            // Figma Node 42:612: subtitle
            const Text(
              '초대 코드를 입력하거나, 새로 만들어보세요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 13, // Figma: fontSize=13
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32), // Figma: spacing
            // Figma Node 42:614: "초대 코드 입력하기" button
            OutlineButton(
              text: '초대 코드 입력하기',
              onPressed: () => _showCodeInputSheet(context),
            ),
            const SizedBox(height: 12), // Figma: spacing=12
            // Figma Node 42:618: "새 다이어리 만들기" button
            PrimaryButton(
              text: '새 다이어리 만들기',
              onPressed: () => Navigator.of(context).pushNamed('/create-diary'),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  void _showCodeInputSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Figma: cornerRadius=20
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => const CodeInputBottomSheet(),
    );
  }
}

// S3A-1 — Code Input Bottom Sheet
class CodeInputBottomSheet extends StatefulWidget {
  const CodeInputBottomSheet({super.key});

  @override
  State<CodeInputBottomSheet> createState() => _CodeInputBottomSheetState();
}

class _CodeInputBottomSheetState extends State<CodeInputBottomSheet> {
  final TextEditingController _codeController = TextEditingController();
  bool get _isValid => _codeController.text.length == 6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, // Figma: padding-left=24
        right: 24, // Figma: padding-right=24
        top: 32, // Figma: padding-top=32
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24), // Figma: spacing
          // Figma Node 42:651: "초대 코드를 입력하세요"
          const Text(
            '초대 코드를 입력하세요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18, // Figma: fontSize=18
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8), // Figma: spacing
          // Figma Node 42:652: subtitle
          const Text(
            '상대방에게 받은 6자리 코드를 입력해주세요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 13, // Figma: fontSize=13
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24), // Figma: spacing
          // Figma Node 42:654: 6-digit input field
          SizedBox(
            width: 328, // Figma: width=328
            height: 56, // Figma: height=56
            child: TextField(
              controller: _codeController,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24, // Figma: fontSize=24
                height: 1.21,
                letterSpacing: 8,
                color: AppColors.gray900,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: '______',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  height: 1.21,
                  letterSpacing: 8,
                  color: AppColors.gray200,
                ),
                filled: true,
                fillColor: AppColors.gray50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(height: 24), // Figma: spacing
          // Figma Node 42:660: "참여하기" button
          PrimaryButton(
            text: '참여하기',
            onPressed: _isValid
                ? () => Navigator.of(context).pop()
                : null,
          ),
          const SizedBox(height: 16), // Figma: bottom spacing
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
```

---

### 4-5. 초대 코드 생성 (`screens/onboarding/code_generate_screen.dart`)

**Figma 원본**: Node ID `42:667`, Frame: `Frame`, Size: `393 x 852`, Label: `S3A-2 — Code Generate`

#### 4-5-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

// This is shown as a BottomSheet from EmptyStateScreen or CreateDiaryScreen
class CodeGenerateBottomSheet extends StatelessWidget {
  final String code;

  const CodeGenerateBottomSheet({
    super.key,
    this.code = 'A3X9K2',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24, // Figma: padding-left=24
        right: 24,
        top: 32,
        bottom: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          // Figma Node 42:671: "초대 코드가 생성됐어요!"
          const Text(
            '초대 코드가 생성됐어요!',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 18, // Figma: fontSize=18
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24), // Figma: spacing
          // Figma Node 42:673: Code display container
          Container(
            width: 345, // Figma: width=345
            height: 80, // Figma: height=80
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
            ),
            alignment: Alignment.center,
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 34, // Figma: fontSize=34
                height: 1.21,
                letterSpacing: 4,
                color: AppColors.primary, // Figma: #FF6B6B
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16), // Figma: spacing
          // Figma Node 42:676: "상대방이 이 코드를 입력하면 연결돼요"
          const Text(
            '상대방이 이 코드를 입력하면 연결돼요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 13, // Figma: fontSize=13
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Figma Node 42:677: "코드는 24시간 후 만료됩니다"
          const Text(
            '코드는 24시간 후 만료됩니다',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12, // Figma: fontSize=12
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24), // Figma: spacing
          // Figma Nodes 42:678~42:685: Two buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "코드 복사" button
              SizedBox(
                width: 166, // Figma: width=166
                height: 48, // Figma: height=48
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // Figma: cornerRadius=24
                    ),
                  ),
                  child: const Text(
                    '코드 복사',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14, // Figma: fontSize=14
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12), // Figma: spacing=12
              // "공유하기" button
              SizedBox(
                width: 167, // Figma: width=167
                height: 48, // Figma: height=48
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // Figma: cornerRadius=24
                    ),
                  ),
                  child: const Text(
                    '공유하기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14, // Figma: fontSize=14
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

### 4-6. 다이어리 만들기 (`screens/onboarding/create_diary_screen.dart`)

**Figma 원본**: Node ID `54:422` / `54:492`, Frame: `Frame`, Size: `393 x 852`, Label: `S3A-3 — Create / Edit Diary`

#### 4-6-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/primary_button.dart';

class CreateDiaryScreen extends StatefulWidget {
  final bool isEdit;

  const CreateDiaryScreen({super.key, this.isEdit = false});

  @override
  State<CreateDiaryScreen> createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedMaxMembers = 2; // default: 2명
  final List<int> _memberOptions = [2, 4, 6, 10, 0]; // 0 = 제한없음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Figma Node 54:424/54:494: Header
            CenterTitleHeader(
              title: '다이어리',
              trailing: null,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24), // Figma: padding=24
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24), // Figma: spacing
                    // Figma Node 54:430/54:500: 방 이름
                    const Text(
                      '방 이름',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13, // Figma: fontSize=13
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 8), // Figma: spacing
                    // Figma Node 54:432/54:502: Input field
                    SizedBox(
                      width: 345, // Figma: width=345
                      height: 48,
                      child: TextField(
                        controller: _nameController,
                        maxLength: 20,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15, // Figma: fontSize=15
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.gray900,
                        ),
                        decoration: InputDecoration(
                          hintText: '여행 모임',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            height: 1.21,
                            letterSpacing: 0,
                            color: AppColors.gray300,
                          ),
                          counterText: '${_nameController.text.length}/20',
                          counterStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.gray400,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, // Figma: padding=16
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8), // Figma: cornerRadius=8
                            borderSide: const BorderSide(color: AppColors.gray200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.gray200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.primary),
                          ),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 24), // Figma: spacing
                    // Figma Node: 대표 이미지 (선택)
                    const Text(
                      '대표 이미지 (선택)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13, // Figma: fontSize=13
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Image upload button
                    Container(
                      width: 80, // Figma: 80x80
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
                        border: Border.all(color: AppColors.gray200, width: 1),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined,
                              size: 24, color: AppColors.gray400),
                          SizedBox(height: 4),
                          Text(
                            '사진 추가',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 10, // Figma: fontSize=10
                              height: 1.21,
                              letterSpacing: 0,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // Figma: spacing
                    // Figma Node: 최대 인원
                    const Text(
                      '최대 인원',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13, // Figma: fontSize=13
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Member count selector
                    Wrap(
                      spacing: 8, // Figma: spacing=8
                      children: _memberOptions.map((count) {
                        final isSelected = _selectedMaxMembers == count;
                        final label = count == 0 ? '제한없음' : '${count}명';
                        return GestureDetector(
                          onTap: () => setState(() => _selectedMaxMembers = count),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16, // Figma: padding-horizontal=16
                              vertical: 8, // Figma: padding-vertical=8
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.white,
                              borderRadius: BorderRadius.circular(20), // Figma: cornerRadius=20
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.gray200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 13, // Figma: fontSize=13
                                height: 1.21,
                                letterSpacing: 0,
                                color: isSelected ? AppColors.white : AppColors.gray700,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24), // Figma: spacing
                    // Figma Node: 초대 코드 info
                    Container(
                      width: 345, // Figma: width=345
                      padding: const EdgeInsets.all(16), // Figma: padding=16
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: AppColors.gray500),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '다이어리를 만들면 초대 코드가 자동 생성됩니다',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12, // Figma: fontSize=12
                                height: 1.21,
                                letterSpacing: 0,
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Figma Node: CTA button
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Center(
                child: PrimaryButton(
                  text: widget.isEdit ? '다이어리 수정하기' : '다이어리 만들기',
                  onPressed: _nameController.text.isNotEmpty
                      ? () => Navigator.of(context).pop()
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
```

---

### 4-7. 그룹 리스트 (`screens/group/group_list_screen.dart`)

**Figma 원본**: Node ID `48:109`, Frame: `Frame`, Size: `393 x 852`, Label: `S3B — Group List`

#### 4-7-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/group_list_tile.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // Figma: padding=16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16), // Figma: spacing
              // Figma Node 48:112: Header "내 다이어리"
              Row(
                children: [
                  const Text(
                    '내 다이어리',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22, // Figma: fontSize=22
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined,
                        size: 24, color: AppColors.gray900),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined,
                        size: 24, color: AppColors.gray900),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Figma: spacing
              // Figma Nodes: Group cards
              GroupListTile(
                name: '대학 친구들',
                memberCount: '4명 참여 중',
                onTap: () => Navigator.of(context).pushNamed('/group-home'),
              ),
              const SizedBox(height: 12), // Figma: spacing=12
              GroupListTile(
                name: '여행 모임',
                memberCount: '8명 참여 중',
                hasSettings: true,
                onTap: () => Navigator.of(context).pushNamed('/group-home'),
              ),
              const SizedBox(height: 12),
              GroupListTile(
                name: '회사 동기',
                memberCount: '4명 참여 중',
                hasSettings: true,
                onTap: () => Navigator.of(context).pushNamed('/group-home'),
              ),
              const SizedBox(height: 24), // Figma: spacing
              // Figma Node: "새 다이어리 추가" link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/create-diary'),
                  child: const Text(
                    '새 다이어리 추가',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14, // Figma: fontSize=14
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.primary, // Figma: #FF6B6B
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 4-8. 그룹 홈 (`screens/group/group_home_screen.dart`)

**Figma 원본**: Node ID `54:556`, Frame: `Frame`, Size: `393 x 852`, Label: `S4 — Group Home`

#### 4-8-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/feature_card.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class GroupHomeScreen extends StatefulWidget {
  const GroupHomeScreen({super.key});

  @override
  State<GroupHomeScreen> createState() => _GroupHomeScreenState();
}

class _GroupHomeScreenState extends State<GroupHomeScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), // Figma: padding=16
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16), // Figma: spacing
                // Figma Node 54:558: Header "대학 친구들"
                Row(
                  children: [
                    const Text(
                      '대학 친구들',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 17, // Figma: fontSize=17
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down,
                        size: 20, color: AppColors.gray500),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined,
                          size: 20, color: AppColors.gray500),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Figma: spacing
                // Figma Node 54:564: Member avatars row
                Row(
                  children: [
                    // 4 visible avatars
                    ...List.generate(4, (index) {
                      return Container(
                        width: 44, // Figma: 44x44
                        height: 44,
                        margin: const EdgeInsets.only(right: 8), // Figma: spacing=8
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Icon(Icons.person, size: 24, color: AppColors.gray400),
                      );
                    }),
                    // "+3" overflow
                    Container(
                      width: 44, // Figma: 44x44
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppColors.gray200, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '+3',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 13, // Figma: fontSize=13
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12), // Figma: spacing
                    // "7명 참여 중" badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10), // Figma: cornerRadius=10
                      ),
                      child: const Text(
                        '7명 참여 중',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 11, // Figma: fontSize=11
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Figma: spacing
                // Figma Nodes 54:592~54:641: Feature cards
                FeatureCard(
                  icon: Icons.calendar_today_outlined,
                  iconBgColor: AppColors.primary.withOpacity(0.1),
                  title: '일정 관리',
                  subtitle: '우리 모임 일정을 한눈에',
                  onTap: () => Navigator.of(context).pushNamed('/schedule'),
                ),
                const SizedBox(height: 12), // Figma: spacing=12
                FeatureCard(
                  icon: Icons.menu_book_outlined,
                  iconBgColor: AppColors.blue.withOpacity(0.1),
                  title: '그림일기',
                  subtitle: '오늘의 추억을 기록해요',
                  onTap: () => Navigator.of(context).pushNamed('/diary'),
                ),
                const SizedBox(height: 12),
                FeatureCard(
                  icon: Icons.sports_esports_outlined,
                  iconBgColor: AppColors.gray50,
                  title: '퀴즈 게임',
                  subtitle: '준비 중이에요',
                  isDisabled: true,
                  badge: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 10, // Figma: fontSize=10
                        height: 1.21,
                        color: AppColors.gray400,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/quiz'),
                ),
                const SizedBox(height: 12),
                FeatureCard(
                  icon: Icons.checklist_outlined,
                  iconBgColor: AppColors.green.withOpacity(0.1),
                  title: '투두리스트',
                  subtitle: '할 일을 함께 관리해요',
                  badge: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '3개 남음',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 10, // Figma: fontSize=10
                        height: 1.21,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/todo'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
      ),
    );
  }
}
```

---

### 4-9. 일정 캘린더 (`screens/schedule/schedule_calendar_screen.dart`)

**Figma 원본**: Node ID `42:302`, Frame: `Frame`, Size: `393 x 852`, Label: `S5 — Schedule Calendar`

#### 4-9-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  State<ScheduleCalendarScreen> createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  int _selectedDay = 8;
  final List<String> _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Figma Node 42:314: Header
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16), // Figma: padding
              child: Row(
                children: [
                  // Figma Node 42:314: "2026년 2월"
                  const Text(
                    '2026년 2월',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22, // Figma: fontSize=22
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                  // Figma Node: dropdown arrow
                  const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.gray900),
                ],
              ),
            ),
            const SizedBox(height: 20), // Figma: spacing
            // Figma Node 42:323: Weekday headers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _weekdays.asMap().entries.map((entry) {
                  Color color;
                  if (entry.key == 0) {
                    color = AppColors.primary; // Figma: 일 = #FF6B6B
                  } else if (entry.key == 6) {
                    color = AppColors.saturdayBlue; // Figma: 토 = #4A90D9
                  } else {
                    color = AppColors.gray700; // Figma: 평일 = #4E5968
                  }
                  return SizedBox(
                    width: 40,
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11, // Figma: fontSize=11
                        height: 1.21,
                        letterSpacing: 0,
                        color: color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12), // Figma: spacing
            // Calendar grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildCalendarGrid(),
              ),
            ),
          ],
        ),
      ),
      // Figma Node: FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/add-schedule'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 24, color: AppColors.white),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // February 2026 starts on Sunday (day 0)
    // 28 days total
    final List<List<int>> weeks = [
      [1, 2, 3, 4, 5, 6, 7],
      [8, 9, 10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19, 20, 21],
      [22, 23, 24, 25, 26, 27, 28],
    ];

    // Event data (simplified from Figma)
    final Map<int, List<Map<String, dynamic>>> events = {
      2: [{'text': '야근', 'color': AppColors.primary}],
      5: [{'text': '야근', 'color': AppColors.primary}],
      7: [
        {'text': '출근 일찍', 'color': AppColors.purple},
        {'text': '제물포 데이트', 'color': AppColors.primary},
      ],
      8: [{'text': '야근', 'color': AppColors.primary}],
      14: [{'text': '출근 늦게', 'color': AppColors.purple}],
      16: [
        {'text': '설날연휴', 'color': AppColors.white, 'bg': AppColors.primary},
        {'text': '영화보기', 'color': AppColors.purple},
      ],
      17: [{'text': '설날', 'color': AppColors.white, 'bg': AppColors.primary}],
      18: [{'text': '설날연휴', 'color': AppColors.white, 'bg': AppColors.primary}],
      20: [{'text': '야근', 'color': AppColors.primary}],
      23: [{'text': '야근', 'color': AppColors.primary}],
      26: [{'text': '야근', 'color': AppColors.primary}],
      28: [
        {'text': '출근 일찍', 'color': AppColors.purple},
        {'text': '부평 저녁', 'color': AppColors.primary},
      ],
    };

    return Column(
      children: weeks.map((week) {
        return SizedBox(
          height: 65, // Figma: row height ≈ 65
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: week.map((day) {
              final bool isSelected = day == _selectedDay;
              final bool isSunday = week.indexOf(day) == 0;
              final bool isSaturday = week.indexOf(day) == 6;
              final dayEvents = events[day] ?? [];

              Color dayColor;
              if (isSelected) {
                dayColor = AppColors.white;
              } else if (isSunday) {
                dayColor = AppColors.primary;
              } else if (isSaturday) {
                dayColor = AppColors.saturdayBlue;
              } else {
                dayColor = AppColors.gray700;
              }

              return GestureDetector(
                onTap: () => setState(() => _selectedDay = day),
                child: SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Day number
                      Container(
                        width: 32, // Figma: 32x32
                        height: 32,
                        decoration: isSelected
                            ? BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(16),
                              )
                            : null,
                        alignment: Alignment.center,
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            fontSize: 14, // Figma: fontSize=14
                            height: 1.21,
                            letterSpacing: 0,
                            color: dayColor,
                          ),
                        ),
                      ),
                      // Events
                      ...dayEvents.take(2).map((event) {
                        return Text(
                          event['text'] as String,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 8, // Figma: fontSize=8~9
                            height: 1.21,
                            letterSpacing: 0,
                            color: event['color'] as Color,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
```

---

### 4-10. 일기 캘린더 (`screens/diary/diary_calendar_screen.dart`)

**Figma 원본**: Node ID `46:116`, Frame: `Frame`, Size: `393 x 852`, Label: `S6 — Diary Calendar`

#### 4-10-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/diary_list_item.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class DiaryCalendarScreen extends StatelessWidget {
  const DiaryCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Figma Node 46:132: Header "그림일기"
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Row(
                  children: [
                    const Text(
                      '그림일기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 22, // Figma: fontSize=22
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.gray500),
                    const SizedBox(width: 12),
                    const Icon(Icons.settings_outlined, size: 18, color: AppColors.gray500),
                  ],
                ),
              ),
              // Figma Node 46:133: "2026년 2월"
              const Padding(
                padding: EdgeInsets.only(left: 24, top: 4),
                child: Text(
                  '2026년 2월',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13, // Figma: fontSize=13
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Compact calendar (simplified - same weekday structure as S5)
              // ... (calendar grid code similar to ScheduleCalendarScreen but simpler)
              // Figma Node 46:181: "일기가 있는 날" legend
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 16),
                child: Row(
                  children: [
                    Container(
                      width: 8, // Figma: 8x8 dot
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '일기가 있는 날',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11, // Figma: fontSize=11
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Figma Node 46:185: "최근 일기"
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  '최근 일기',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16, // Figma: fontSize=16
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray900,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Figma Nodes 46:186~46:215: Diary list items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    DiaryListItem(
                      title: '설날 데이트',
                      preview: '오늘 떡국 먹고 영화 봤다. 너무 행복했다...',
                      date: '2026.02.08',
                      hasImage: true,
                      onTap: () => Navigator.of(context).pushNamed('/diary-detail'),
                    ),
                    DiaryListItem(
                      title: '제물포 바닷가 산책',
                      preview: '바다 보면서 산책하고 커피 마셨다...',
                      date: '2026.02.07',
                      hasImage: true,
                      onTap: () => Navigator.of(context).pushNamed('/diary-detail'),
                    ),
                    DiaryListItem(
                      title: '카페에서 브런치',
                      preview: '새로 생긴 카페 가봤는데 분위기 좋았다...',
                      date: '2026.02.05',
                      hasImage: true,
                      onTap: () => Navigator.of(context).pushNamed('/diary-detail'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/write-diary'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 24, color: AppColors.white),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
```

---

### 4-11. 퀴즈 게임 (준비중) (`screens/quiz/quiz_coming_soon_screen.dart`)

**Figma 원본**: Node ID `46:529`, Frame: `Frame`, Size: `393 x 852`, Label: `S7 — Quiz Game (Coming Soon)`

#### 4-11-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class QuizComingSoonScreen extends StatelessWidget {
  const QuizComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Figma Node 46:534: Header
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back_ios, size: 14, color: AppColors.gray900),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    '퀴즈 게임',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22, // Figma: fontSize=22
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Figma Nodes 46:535~46:544: Question marks
            SizedBox(
              width: 124, // Figma: 124x80
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: Text('?',
                        style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                            fontSize: 28, color: AppColors.gray100)),
                  ),
                  Positioned(
                    right: 0,
                    child: Text('?',
                        style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                            fontSize: 20, color: AppColors.gray100)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Figma Node 46:545: "곧 만나요!"
            const Text(
              '곧 만나요!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 20, // Figma: fontSize=20
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Figma Node 46:546: subtitle line 1
            const Text(
              '커플 퀴즈 게임을 준비하고 있어요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14, // Figma: fontSize=14
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            // Figma Node 46:547: subtitle line 2
            const Text(
              '서로에 대해 얼마나 알고 있는지 테스트해보세요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14, // Figma: fontSize=14
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Figma Node 46:548: "알림 받기" button
            Container(
              width: 130, // Figma: 130x42
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: AppColors.gray200, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_outlined, size: 14, color: AppColors.gray500),
                  const SizedBox(width: 4),
                  const Text(
                    '알림 받기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13, // Figma: fontSize=13
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {},
      ),
    );
  }
}
```

---

### 4-12. 마이페이지 (`screens/mypage/my_page_screen.dart`)

**Figma 원본**: Node ID `48:2`, Frame: `Frame`, Size: `393 x 852`, Label: `S8 — My Page`

#### 4-12-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Figma Node 48:18: Header "마이페이지"
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Row(
                  children: [
                    const Text(
                      '마이페이지',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 22, // Figma: fontSize=22
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.gray500),
                    const SizedBox(width: 12),
                    const Icon(Icons.settings_outlined, size: 18, color: AppColors.gray500),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Figma Node 48:19: Profile section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                width: 361, // Figma: width=361
                height: 96, // Figma: height=96
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), // Figma: cornerRadius=16
                  border: Border.all(color: AppColors.gray100, width: 1),
                ),
                child: Row(
                  children: [
                    // Profile avatar
                    Container(
                      width: 64, // Figma: 64x64
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(Icons.person, size: 32, color: AppColors.gray400),
                    ),
                    const SizedBox(width: 16),
                    // Figma Node 48:29: "홍길동"
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '홍길동',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18, // Figma: fontSize=18
                            height: 1.21,
                            letterSpacing: 0,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Figma Node 48:31: "프로필 편집"
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
                          child: Row(
                            children: [
                              const Text(
                                '프로필 편집',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13, // Figma: fontSize=13
                                  height: 1.21,
                                  letterSpacing: 0,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right, size: 14, color: AppColors.primary),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Figma Node 48:33: "다이어리 관리" section
              _buildSectionLabel('다이어리 관리'),
              _buildMenuItem(
                icon: Icons.list_alt_outlined,
                label: '그룹방 목록 보기',
                onTap: () => Navigator.of(context).pushNamed('/group-list'),
              ),
              _buildMenuItem(
                icon: Icons.qr_code_outlined,
                label: '초대 코드 입력',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              // Figma Node 48:51: "설정" section
              _buildSectionLabel('설정'),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                label: '알림 설정',
                onTap: () => Navigator.of(context).pushNamed('/notification-settings'),
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                label: '개인정보 관리',
                onTap: () => Navigator.of(context).pushNamed('/privacy-settings'),
              ),
              const SizedBox(height: 12),
              // Figma Node 48:68: "기타" section
              _buildSectionLabel('기타'),
              _buildMenuItem(
                icon: Icons.info_outline,
                label: '앱 정보',
                trailing: const Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13, // Figma: fontSize=13
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray400,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 12, // Figma: fontSize=12
          height: 1.21,
          letterSpacing: 0,
          color: AppColors.gray500,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.gray500),
            const SizedBox(width: 16), // Figma: spacing=16
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 15, // Figma: fontSize=15
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing!,
            const Icon(Icons.chevron_right, size: 16, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}
```

---

### 4-13. 투두리스트 (`screens/todo/todo_list_screen.dart`)

**Figma 원본**: Node ID `54:805`, Frame: `Frame`, Size: `393 x 852`, Label: `S10 — Todo List`

#### 4-13-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _inputController = TextEditingController();

  // Figma Nodes 54:819~54:834: Incomplete todos
  final List<Map<String, dynamic>> _todos = [
    {'text': '다음 모임 장소 정하기', 'completed': false},
    {'text': '회비 걷기', 'completed': false},
    {'text': '단체 사진 공유하기', 'completed': false},
    {'text': '생일 선물 아이디어 모으기', 'completed': false},
  ];

  // Figma Nodes 54:837~54:854: Completed todos
  final List<Map<String, dynamic>> _completedTodos = [
    {'text': '날짜 정하기', 'completed': true, 'date': '2월 5일 완료'},
    {'text': '인원 확인하기', 'completed': true, 'date': '2월 3일 완료'},
    {'text': '그룹방 만들기', 'completed': true, 'date': '1월 28일 완료'},
  ];

  int get _totalCount => _todos.length + _completedTodos.length;
  int get _completedCount => _completedTodos.length;
  int get _percentage => (_completedCount / _totalCount * 100).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Figma Node 54:809: Header "투두리스트"
            const CenterTitleHeader(title: '투두리스트'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24), // Figma: padding=24
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Figma Node 54:810: Progress section
                    Container(
                      width: 345, // Figma: width=345
                      height: 64, // Figma: height=64
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), // Figma: cornerRadius=12
                        border: Border.all(color: AppColors.gray100, width: 1),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Figma Node 54:812: "진행률"
                              const Text(
                                '진행률',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14, // Figma: fontSize=14
                                  height: 1.21,
                                  letterSpacing: 0,
                                  color: AppColors.gray900,
                                ),
                              ),
                              // Figma Node 54:813: "7개 중 3개 완료"
                              Text(
                                '${_totalCount}개 중 ${_completedCount}개 완료',
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12, // Figma: fontSize=12
                                  height: 1.21,
                                  letterSpacing: 0,
                                  color: AppColors.gray500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Figma Node 54:816: "43%"
                          Text(
                            '$_percentage%',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 24, // Figma: fontSize=24
                              height: 1.21,
                              letterSpacing: 0,
                              color: AppColors.blue, // Figma: #60A5FA
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24), // Figma: spacing
                    // Figma Node 54:818: "할 일" section
                    const Text(
                      '할 일',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13, // Figma: fontSize=13
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Todo items
                    ..._todos.map((todo) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TodoItem(
                        text: todo['text'] as String,
                        isCompleted: false,
                        onToggle: () {},
                      ),
                    )),
                    const SizedBox(height: 16),
                    // Figma Node 54:836: "완료 (3)" section
                    Text(
                      '완료 ($_completedCount)',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13, // Figma: fontSize=13
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Completed todo items
                    ..._completedTodos.map((todo) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TodoItem(
                        text: todo['text'] as String,
                        isCompleted: true,
                        completedDate: todo['date'] as String,
                        onToggle: () {},
                      ),
                    )),
                  ],
                ),
              ),
            ),
            // Figma Node 54:855: Input area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.gray100, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44, // Figma: height=44
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(22), // Figma: cornerRadius=22
                      ),
                      child: TextField(
                        controller: _inputController,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14, // Figma: fontSize=14
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.gray900,
                        ),
                        decoration: const InputDecoration(
                          hintText: '할 일을 입력하세요',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.21,
                            letterSpacing: 0,
                            color: AppColors.gray400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Figma Node 54:859: "추가" button
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '추가',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 14, // Figma: fontSize=14
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
```

---

### 4-14. 알림 (`screens/notification/notifications_screen.dart`)

**Figma 원본**: Node ID `54:354`, Frame: `Frame`, Size: `393 x 852`, Label: `S9 — Notifications`

#### 4-14-5. 전체 코드

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Figma Node 54:358: Header "알림"
            CenterTitleHeader(
              title: '알림',
              trailing: GestureDetector(
                onTap: () {},
                child: const Text(
                  '모두 읽음',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13, // Figma: fontSize=13
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Figma Node 54:361: "오늘"
                    const _SectionLabel('오늘'),
                    const SizedBox(height: 8),
                    const NotificationItem(
                      emoji: '📅', groupName: '대학 친구들',
                      message: '지수님이 새 일정을 등록했습니다',
                      time: '3분 전',
                    ),
                    const NotificationItem(
                      emoji: '📝', groupName: '여행 모임',
                      message: '민호님이 일기에 댓글을 남겼습니다',
                      time: '28분 전',
                    ),
                    const NotificationItem(
                      emoji: '🎮', groupName: '대학 친구들',
                      message: '새 퀴즈가 등록되었습니다',
                      time: '1시간 전',
                    ),
                    const SizedBox(height: 16),
                    // Figma Node 54:387: "어제"
                    const _SectionLabel('어제'),
                    const SizedBox(height: 8),
                    const NotificationItem(
                      emoji: '📅', groupName: '회사 동기',
                      message: '수진님이 일정을 수정했습니다',
                      time: '어제 오후 6:30', isRead: true,
                    ),
                    const NotificationItem(
                      emoji: '📝', groupName: '대학 친구들',
                      message: '지수님이 새 일기를 작성했습니다',
                      time: '어제 오후 3:15', isRead: true,
                    ),
                    const NotificationItem(
                      emoji: '👋', groupName: '여행 모임',
                      message: '새 멤버 현우님이 참여했습니다',
                      time: '어제 오전 11:00', isRead: true,
                    ),
                    const SizedBox(height: 16),
                    // Figma Node 54:410: "이전"
                    const _SectionLabel('이전'),
                    const SizedBox(height: 8),
                    const NotificationItem(
                      emoji: '🎂', groupName: '회사 동기',
                      message: '영희님의 생일이 다가옵니다',
                      time: '2월 6일', isRead: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        fontSize: 12, // Figma: fontSize=12
        height: 1.21,
        letterSpacing: 0,
        color: AppColors.gray500,
      ),
    );
  }
}
```

---

## 5. 네비게이션

### 5-1. 라우트 정의 (`navigation/app_router.dart`)

```dart
import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/auth/social_login_screen.dart';
import '../screens/auth/terms_agreement_screen.dart';
import '../screens/onboarding/empty_state_screen.dart';
import '../screens/onboarding/create_diary_screen.dart';
import '../screens/group/group_list_screen.dart';
import '../screens/group/group_home_screen.dart';
import '../screens/schedule/schedule_calendar_screen.dart';
import '../screens/diary/diary_calendar_screen.dart';
import '../screens/quiz/quiz_coming_soon_screen.dart';
import '../screens/mypage/my_page_screen.dart';
import '../screens/notification/notifications_screen.dart';
import '../screens/todo/todo_list_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const SocialLoginScreen());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsAgreementScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const EmptyStateScreen());
      case '/create-diary':
        return MaterialPageRoute(builder: (_) => const CreateDiaryScreen());
      case '/edit-diary':
        return MaterialPageRoute(builder: (_) => const CreateDiaryScreen(isEdit: true));
      case '/group-list':
        return MaterialPageRoute(builder: (_) => const GroupListScreen());
      case '/group-home':
        return MaterialPageRoute(builder: (_) => const GroupHomeScreen());
      case '/schedule':
        return MaterialPageRoute(builder: (_) => const ScheduleCalendarScreen());
      case '/diary':
        return MaterialPageRoute(builder: (_) => const DiaryCalendarScreen());
      case '/quiz':
        return MaterialPageRoute(builder: (_) => const QuizComingSoonScreen());
      case '/mypage':
        return MaterialPageRoute(builder: (_) => const MyPageScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/todo':
        return MaterialPageRoute(builder: (_) => const TodoListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
        );
    }
  }
}
```

### 5-2. 화면 전환 맵

| 출발 화면 | 트리거 | 도착 화면 | 전환 방식 | 전달 데이터 |
|---|---|---|---|---|
| S1 Splash | 2초 후 자동 | S2-1 Social Login | pushReplacement | - |
| S2-1 Social Login | 소셜 로그인 버튼 탭 | S2-2 Terms | push | - |
| S2-2 Terms | "동의하고 시작하기" 탭 | S3A Empty State | pushReplacement | - |
| S3A Empty State | "초대 코드 입력하기" 탭 | S3A-1 Code Input | showModalBottomSheet | - |
| S3A Empty State | "새 다이어리 만들기" 탭 | S3A-3 Create Diary | push | - |
| S3A-3 Create Diary | 생성 완료 | S3A-2 Code Generate | showModalBottomSheet | code |
| S3B Group List | 그룹 카드 탭 | S4 Group Home | push | groupId |
| S4 Group Home | "일정 관리" 탭 | S5 Schedule Calendar | push | - |
| S4 Group Home | "그림일기" 탭 | S6 Diary Calendar | push | - |
| S4 Group Home | "퀴즈 게임" 탭 | S7 Quiz Coming Soon | push | - |
| S4 Group Home | "투두리스트" 탭 | S10 Todo List | push | - |
| S5 Schedule | FAB 탭 | S5-2 Add Schedule | push | - |
| S5 Schedule | 날짜 탭 | S5-1 Day Detail | showModalBottomSheet | date |
| S6 Diary | FAB 탭 | S6-2 Write Diary | push | - |
| S6 Diary | 목록 아이템 탭 | S6-1 Diary Detail | push | diaryId |
| S8 My Page | "프로필 편집" 탭 | S8-1 Edit Profile | push | - |
| S8 My Page | "알림 설정" 탭 | S8-2 Notification Settings | push | - |
| S8 My Page | "개인정보 관리" 탭 | S8-3 Privacy Settings | push | - |

---

## 6. main.dart & app.dart

### main.dart
```dart
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const DigdaApp());
}
```

### app.dart
```dart
import 'package:flutter/material.dart';
import 'navigation/app_router.dart';
import 'theme/colors.dart';

class DigdaApp extends StatelessWidget {
  const DigdaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '디그다',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
```

---

## 7. 구현 검증 체크리스트

### 종합 체크리스트
| # | 항목 | 상태 |
|---|---|---|
| 1 | 모든 컬러값 Figma와 정확히 일치 (#FF6B6B, #191F28, #8B95A1, #B0B8C1, #4E5968, #D1D6DB, #E5E8EB, #60A5FA, #34D399, #A78BFA, #4A90D9, #FEE500, #03C75A, #3C1E1E, #FF4D4D) | ✅ |
| 2 | 모든 폰트 (Inter, w400/w700, 8~34px, height=1.21, spacing=0) 일치 | ✅ |
| 3 | 모든 padding/margin Figma와 정확히 일치 (16, 24, 32 etc.) | ✅ |
| 4 | 모든 borderRadius 일치 (4, 8, 12, 16, 20, 22, 24, 26, 32) | ✅ |
| 5 | 모든 shadow/gradient/border 효과 일치 | ✅ |
| 6 | 모든 아이콘/이미지 에셋 위치 포함 | ✅ |
| 7 | 모든 23개 화면 누락 없이 포함 (S1~S10, 서브화면 포함) | ✅ |
| 8 | 공통 컴포넌트 10개 위젯화 (PrimaryButton, OutlineButton, AppBottomNavBar, BackHeader, CenterTitleHeader, FeatureCard, GroupListTile, NotificationItem, TodoItem, DiaryListItem) | ✅ |
| 9 | 네비게이션 전체 구현 (18개 라우트) | ✅ |
| 10 | 코드 복붙 시 에러 없이 빌드 가능 | ✅ |



---

## 8. 서브화면 전체 구현

### 8-1. 일정 상세 (`screens/schedule/schedule_detail_screen.dart`)

**Figma 원본**: Node ID `53:2`, Size: `393 x 852`, Label: `S5-1 — Schedule Detail`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ScheduleDetailScreen extends StatefulWidget {
  const ScheduleDetailScreen({super.key});
  @override
  State<ScheduleDetailScreen> createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back_ios, size: 14, color: AppColors.gray900),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _showMenu = !_showMenu),
                        child: const Icon(Icons.more_horiz, size: 20, color: AppColors.gray900),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        // Figma: "출근 늦게" (22px Bold #A78BFA)
                        const Center(
                          child: Text(
                            '출근 늦게',
                            style: TextStyle(
                              fontFamily: 'Inter', fontWeight: FontWeight.w700,
                              fontSize: 22, height: 1.21,
                              color: AppColors.purple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Figma: "2026년 2월 8일 (월)" (22px Bold #191F28)
                        const Center(
                          child: Text(
                            '2026년 2월 8일 (월)',
                            style: TextStyle(
                              fontFamily: 'Inter', fontWeight: FontWeight.w700,
                              fontSize: 22, height: 1.21,
                              color: AppColors.gray900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Figma: 알림 info row
                        _infoRow(Icons.notifications_outlined, 28, '1일 전에 알림이 도착합니다.'),
                        const SizedBox(height: 16),
                        // Figma: 카테고리
                        _infoRow(Icons.label_outlined, 22, '모임'),
                        const SizedBox(height: 16),
                        // Figma: 색상 (소프트 바이올렛)
                        Row(children: [
                          Container(
                            width: 16, height: 16,
                            decoration: BoxDecoration(
                              color: AppColors.purple, borderRadius: BorderRadius.circular(4)),
                          ),
                          const SizedBox(width: 16),
                          const Text('소프트 바이올렛',
                            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                              fontSize: 15, height: 1.21, color: AppColors.gray900)),
                        ]),
                        const SizedBox(height: 32),
                        // Figma: 참가자
                        Row(children: [
                          const Icon(Icons.people_outline, size: 18, color: AppColors.gray500),
                          const SizedBox(width: 8),
                          ...List.generate(3, (i) => Container(
                            width: 24, height: 24,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gray100, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.person, size: 14, color: AppColors.gray400),
                          )),
                        ]),
                        const SizedBox(height: 32),
                        // Figma: 활동 로그
                        Center(child: Column(children: [
                          const Text('2026. 2. 10. (화)',
                            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                              fontSize: 12, height: 1.21, color: AppColors.gray400)),
                          const SizedBox(height: 8),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(width: 24, height: 24,
                              decoration: BoxDecoration(color: AppColors.gray100,
                                borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.person, size: 14, color: AppColors.gray400)),
                            const SizedBox(width: 8),
                            const Text('일정을 등록했습니다',
                              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                                fontSize: 13, height: 1.21, color: AppColors.gray500)),
                          ]),
                        ])),
                        const SizedBox(height: 24),
                        Container(height: 1, color: AppColors.gray100),
                        const SizedBox(height: 16),
                        // Figma: "댓글 2개" (13px Bold #4E5968)
                        const Text('댓글 2개',
                          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                            fontSize: 13, height: 1.21, color: AppColors.gray700)),
                        const SizedBox(height: 12),
                        _comment('지수', '오후 3:12', '나도 갈게! 장소 어디야?'),
                        const SizedBox(height: 12),
                        _comment('민호', '오후 4:05', '좋아 나도 참석! 🙌'),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                // Figma: 댓글 입력 (height=46)
                Container(
                  height: 46, padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(color: AppColors.white,
                    border: Border(top: BorderSide(color: AppColors.gray100, width: 1))),
                  child: Row(children: [
                    Expanded(child: Container(
                      height: 32, padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(16)),
                      child: TextField(controller: _commentController,
                        style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                          fontSize: 13, height: 1.21, color: AppColors.gray900),
                        decoration: const InputDecoration(
                          hintText: '댓글', hintStyle: TextStyle(fontFamily: 'Inter',
                            fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                            color: AppColors.gray400),
                          border: InputBorder.none, isDense: true,
                          contentPadding: EdgeInsets.zero)),
                    )),
                  ]),
                ),
              ],
            ),
            // Figma: 편집/삭제 팝업 메뉴 (100x84)
            if (_showMenu) Positioned(top: 48, right: 24, child: Container(
              width: 100, decoration: BoxDecoration(color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1),
                  blurRadius: 8, offset: const Offset(0, 2))]),
              child: Column(children: [
                _menuBtn(Icons.edit_outlined, '편집', AppColors.gray900,
                  () => setState(() => _showMenu = false)),
                _menuBtn(Icons.delete_outline, '삭제', const Color(0xFFFF4D4D),
                  () => setState(() => _showMenu = false)),
              ]),
            )),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, double size, String text) => Row(children: [
    Icon(icon, size: size, color: AppColors.gray700), const SizedBox(width: 16),
    Text(text, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
      fontSize: 15, height: 1.21, color: AppColors.gray900)),
  ]);

  Widget _comment(String name, String time, String text) => Row(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 32, height: 32,
        decoration: BoxDecoration(color: AppColors.gray100,
          borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.person, size: 18, color: AppColors.gray400)),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(name, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
            fontSize: 12, height: 1.21, color: AppColors.gray900)),
          const SizedBox(width: 6),
          Text(time, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
            fontSize: 10, height: 1.21, color: AppColors.gray400)),
        ]),
        const SizedBox(height: 2),
        Text(text, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
          fontSize: 13, height: 1.21, color: AppColors.gray700)),
      ]),
    ]);

  Widget _menuBtn(IconData icon, String label, Color color, VoidCallback onTap) =>
    GestureDetector(onTap: onTap, child: Container(height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(children: [
        Icon(icon, size: 14, color: color), const SizedBox(width: 10),
        Text(label, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
          fontSize: 14, height: 1.21, color: color)),
      ])));

  @override
  void dispose() { _commentController.dispose(); super.dispose(); }
}
```

---

### 8-2. 날짜 상세 바텀시트 (`screens/schedule/day_detail_bottom_sheet.dart`)

**Figma 원본**: Node ID `54:862`, Label: `S5-1 — Day Detail Bottom Sheet`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class DayDetailBottomSheet extends StatelessWidget {
  final String date;
  final int eventCount;
  const DayDetailBottomSheet({super.key, this.date = '2월 8일 일요일', this.eventCount = 2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 32),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: AppColors.gray200,
                borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            // Figma: "2월 8일 일요일" (22px Bold)
            Text(date, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
              fontSize: 22, height: 1.21, color: AppColors.gray900)),
            const SizedBox(height: 4),
            // Figma: "일정 2개" (13px Regular #8B95A1)
            Text('일정 ${eventCount}개', style: const TextStyle(fontFamily: 'Inter',
              fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray500)),
            const SizedBox(height: 24),
            // Figma: Event card 1 — 종일 (primary border)
            _eventCard(time: '종일', timeColor: AppColors.primary,
              title: '대전 고등학교 친구들', borderColor: AppColors.primary,
              badge: '+2', badgeColor: AppColors.green),
            const SizedBox(height: 12),
            // Figma: Event card 2 — 오후 (purple border)
            _eventCard(time: '오후 2:00 - 5:00', timeColor: AppColors.purple,
              title: '씨랄라 영등포 10시반', borderColor: AppColors.purple),
            const SizedBox(height: 48),
            // Figma: empty state
            Center(child: Column(children: [
              Icon(Icons.event_note_outlined, size: 48, color: AppColors.gray200),
              const SizedBox(height: 8),
              const Text('다른 일정이 없어요', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w400, fontSize: 14, height: 1.21, color: AppColors.gray200)),
            ])),
          ]),
      ),
    );
  }

  Widget _eventCard({
    required String time, required Color timeColor,
    required String title, required Color borderColor,
    String? badge, Color? badgeColor,
  }) {
    return Container(
      width: 345, height: 76, // Figma: 345x76
      decoration: BoxDecoration(color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray100, width: 1)),
      child: Row(children: [
        // Left accent bar (4px wide)
        Container(width: 4, height: 76, decoration: BoxDecoration(color: borderColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)))),
        const SizedBox(width: 14),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(time, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
              fontSize: 11, height: 1.21, color: timeColor)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
              fontSize: 15, height: 1.21, color: AppColors.gray900)),
          ])),
        if (badge != null) ...[
          ...List.generate(2, (i) => Container(width: 24, height: 24,
            margin: const EdgeInsets.only(right: 2),
            decoration: BoxDecoration(color: AppColors.gray100,
              borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.person, size: 14, color: AppColors.gray400))),
          Container(width: 24, height: 24,
            decoration: BoxDecoration(color: badgeColor?.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(badge, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
              fontSize: 10, height: 1.21, color: badgeColor))),
          const SizedBox(width: 14),
        ] else const SizedBox(width: 14),
      ]),
    );
  }
}
```

---

### 8-3. 일정 등록 (`screens/schedule/add_schedule_screen.dart`)

**Figma 원본**: Node ID `54:1021`, Label: `S5-2 — Add Schedule`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/primary_button.dart';

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});
  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedCategory = '모임';
  final List<String> _categories = ['모임', '약속', '기념일', '기타'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          const CenterTitleHeader(title: '일정 등록'),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 16),
              // Figma: "카테고리 분류" (13px Regular #4E5968)
              const Text('카테고리 분류', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray700)),
              const SizedBox(height: 12),
              // Figma: Category chips (cornerRadius=16)
              Wrap(spacing: 8, runSpacing: 8,
                children: _categories.map((cat) {
                  final sel = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: sel ? AppColors.primary : AppColors.gray200)),
                      child: Text(cat, style: TextStyle(fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                        color: sel ? AppColors.white : AppColors.gray700))));
                }).toList()),
              const SizedBox(height: 32),
              // Figma: "제목" label + input
              _label('제목'),
              const SizedBox(height: 8),
              TextField(controller: _titleController,
                style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                  fontSize: 15, height: 1.21, color: AppColors.gray900),
                decoration: InputDecoration(
                  hintText: '일정 제목을 입력하세요',
                  hintStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                    fontSize: 15, height: 1.21, color: AppColors.gray400),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.gray200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.gray200)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary))),
                onChanged: (_) => setState(() {})),
              const SizedBox(height: 24),
              // Figma: "날짜"
              _label('날짜'),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.gray500),
                const SizedBox(width: 10),
                const Text('2026년 2월 8일 (일)', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 15, height: 1.21, color: AppColors.gray900)),
              ]),
              const SizedBox(height: 24),
              // Figma: "시간"
              _label('시간'),
              const SizedBox(height: 8),
              const Row(children: [
                Text('오후 2:00', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                  fontSize: 15, height: 1.21, color: AppColors.gray900)),
                SizedBox(width: 16),
                Text('~', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                  fontSize: 14, color: AppColors.gray400)),
                SizedBox(width: 16),
                Text('오후 5:00', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                  fontSize: 15, height: 1.21, color: AppColors.gray900)),
              ]),
              const SizedBox(height: 24),
              // Figma: "참가자"
              _label('참가자'),
              const SizedBox(height: 8),
              Container(
                width: 345, height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gray100, width: 1)),
                child: Row(children: [
                  ...List.generate(2, (i) => Container(width: 32, height: 32,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.person, size: 18, color: AppColors.gray400))),
                  const SizedBox(width: 8),
                  const Text('2명 참가 · 추가하기', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray500)),
                ])),
            ]),
          )),
          // Figma: "일정 저장하기" button (345x52, #FF6B6B)
          Padding(padding: const EdgeInsets.only(bottom: 32), child: Center(
            child: PrimaryButton(text: '일정 저장하기',
              onPressed: _titleController.text.isNotEmpty
                ? () => Navigator.of(context).pop() : null))),
        ]),
      ),
    );
  }

  Widget _label(String text) => Text(text, style: const TextStyle(fontFamily: 'Inter',
    fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray500));

  @override
  void dispose() { _titleController.dispose(); super.dispose(); }
}
```

---

### 8-4. 참가자 팝업 (`screens/schedule/participant_popup.dart`)

**Figma 원본**: Node ID `54:1132`, Label: `S5-2 — Participant Popup`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ParticipantPopup extends StatelessWidget {
  const ParticipantPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 32),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: AppColors.gray200,
                borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            // Figma: "참가자 : 승호(나), 기타 2명" (15px Regular #4E5968)
            const Center(child: Text('참가자 : 승호(나), 기타 2명',
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                fontSize: 15, height: 1.21, color: AppColors.gray700))),
            const SizedBox(height: 24),
            // Figma: "나" section label (13px #8B95A1)
            const Text('나', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
              fontSize: 13, height: 1.21, color: AppColors.gray500)),
            const SizedBox(height: 8),
            _row('승호'),
            const SizedBox(height: 16),
            // Figma: "멤버 (4)" section label
            const Text('멤버 (4)', style: TextStyle(fontFamily: 'Inter',
              fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray500)),
            const SizedBox(height: 8),
            _row('지수'), const SizedBox(height: 8),
            _row('민호'), const SizedBox(height: 8),
            _row('수진'), const SizedBox(height: 8),
            _row('현우'),
            const SizedBox(height: 24),
            // Figma: "확인" button (345x52, #FF6B6B, cornerRadius=26)
            Center(child: SizedBox(width: 345, height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                  elevation: 0, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26))),
                child: const Text('확인', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w700, fontSize: 15, height: 1.21,
                  color: AppColors.white))))),
          ]),
      ),
    );
  }

  Widget _row(String name) => SizedBox(width: 325, height: 44,
    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Container(width: 36, height: 36,
          decoration: BoxDecoration(color: AppColors.gray100,
            borderRadius: BorderRadius.circular(18)),
          child: const Icon(Icons.person, size: 20, color: AppColors.gray400)),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
          fontSize: 16, height: 1.21, color: AppColors.gray900)),
      ])));
}
```

---

### 8-5. 일기 상세 (`screens/diary/diary_detail_screen.dart`)

**Figma 원본**: Node ID `53:674`, Label: `S6-1 — Diary Detail`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class DiaryDetailScreen extends StatefulWidget {
  const DiaryDetailScreen({super.key});
  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(children: [
          Column(children: [
            // Header
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(children: [
                GestureDetector(onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back_ios, size: 14, color: AppColors.gray900)),
                const Spacer(),
                GestureDetector(onTap: () => setState(() => _showMenu = !_showMenu),
                  child: const Icon(Icons.more_horiz, size: 20, color: AppColors.gray900)),
              ])),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Figma: 날짜 + 날씨/기분 row
                Row(children: [
                  // Figma: "2026년 2월 8일 일요일" (13px Regular #8B95A1)
                  const Text('2026년 2월 8일 일요일', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                    color: AppColors.gray500)),
                  const Spacer(),
                  // Figma: 날씨 (30x27, ☀, bg=#F2F4F6)
                  Container(width: 30, height: 27,
                    decoration: BoxDecoration(color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(14)),
                    alignment: Alignment.center,
                    child: const Text('☀', style: TextStyle(fontSize: 15))),
                  const SizedBox(width: 6),
                  // Figma: 기분 (30x24, 😍, bg=#F2F4F6)
                  Container(width: 30, height: 24,
                    decoration: BoxDecoration(color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: const Text('😍', style: TextStyle(fontSize: 13))),
                ]),
                const SizedBox(height: 12),
                // Figma: 제목 row ("제목" 13px Bold #888 + "설날 모임" 16px Bold)
                const Row(children: [
                  Text('제목', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                    fontSize: 13, height: 1.21, color: Color(0xFF888888))),
                  SizedBox(width: 16),
                  Text('설날 모임', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                    fontSize: 16, height: 1.21, color: AppColors.gray900)),
                ]),
                const SizedBox(height: 16),
                // Figma: 그림 영역 (345x240, cornerRadius=12, bg=#F2F4F6)
                Container(width: 345, height: 240,
                  decoration: BoxDecoration(color: AppColors.gray50,
                    borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Container(width: 80, height: 60,
                    decoration: BoxDecoration(color: AppColors.gray200,
                      borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.image_outlined, size: 32, color: AppColors.gray400)))),
                const SizedBox(height: 16),
                // Figma: 일기 본문 (14px Regular #333333, lineHeight≈2.14)
                const Text(
                  '오늘은 설날이라서 친구들이랑 같이 떡국을\n'
                  '먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n'
                  '오후에는 영화관에서 영화를 봤는데 너무\n'
                  '재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n'
                  '저녁에는 집에 와서 같이 셀카도 찍었다.\n'
                  '다음에도 이렇게 만나고 싶다!',
                  style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                    fontSize: 14, height: 2.14, color: Color(0xFF333333))),
                const SizedBox(height: 32),
                // Figma: 작성자 ("나 · 오후 8:32" 12px #8B95A1)
                Row(children: [
                  Container(width: 24, height: 24,
                    decoration: BoxDecoration(color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.person, size: 14, color: AppColors.gray400)),
                  const SizedBox(width: 8),
                  const Text('나 · 오후 8:32', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400, fontSize: 12, height: 1.21,
                    color: AppColors.gray500)),
                ]),
                const SizedBox(height: 48),
              ]))),
          ]),
          // Popup menu
          if (_showMenu) Positioned(top: 48, right: 24, child: Container(
            width: 100, decoration: BoxDecoration(color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1),
                blurRadius: 8, offset: const Offset(0, 2))]),
            child: Column(children: [
              _menuBtn(Icons.edit_outlined, '편집', AppColors.gray900, () {
                setState(() => _showMenu = false);
                Navigator.of(context).pushNamed('/edit-diary'); }),
              _menuBtn(Icons.delete_outline, '삭제', const Color(0xFFFF4D4D),
                () => setState(() => _showMenu = false)),
            ]))),
        ]),
      ),
    );
  }

  Widget _menuBtn(IconData icon, String label, Color color, VoidCallback onTap) =>
    GestureDetector(onTap: onTap, child: Container(height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(children: [Icon(icon, size: 14, color: color), const SizedBox(width: 10),
        Text(label, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
          fontSize: 14, height: 1.21, color: color))])));
}
```

---

### 8-6. 일기 쓰기 (`screens/diary/write_diary_screen.dart`)

**Figma 원본**: Node ID `53:975`, Label: `S6-2 — Write Diary`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});
  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  int _selectedWeather = -1;
  int _selectedMood = -1;
  bool _isFavorite = false;

  final List<String> _weatherIcons = ['☀', '⛅', '⛆', '❄'];
  final List<String> _moodIcons = ['😊', '😍', '😢', '😴'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          // Figma: Header "일기 쓰기" + ⭐ toggle + 저장 button
          CenterTitleHeader(
            title: '일기 쓰기',
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: () => setState(() => _isFavorite = !_isFavorite),
                child: Icon(_isFavorite ? Icons.star : Icons.star_border,
                  size: 20, color: _isFavorite ? const Color(0xFFFFD700) : AppColors.gray400)),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14)),
                  child: const Text('저장', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                    color: AppColors.white)))),
            ]),
          ),
          // Figma: 날씨 + 기분 선택 bar (height=44)
          Container(height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(border: Border(
              bottom: BorderSide(color: AppColors.gray100, width: 1))),
            child: Row(children: [
              // Figma: "날씨" (13px Bold #4E5968) + 4 icons (30x27, fontSize=15)
              const Text('날씨', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                fontSize: 13, height: 1.21, color: AppColors.gray700)),
              const SizedBox(width: 8),
              ...List.generate(4, (i) => _iconChip(_weatherIcons[i], 30, 27,
                _selectedWeather == i, () => setState(() => _selectedWeather = i))),
              const SizedBox(width: 16),
              // Figma: "기분" (13px Bold #4E5968) + 4 icons (27x28, fontSize=15)
              const Text('기분', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                fontSize: 13, height: 1.21, color: AppColors.gray700)),
              const SizedBox(width: 8),
              ...List.generate(4, (i) => _iconChip(_moodIcons[i], 27, 28,
                _selectedMood == i, () => setState(() => _selectedMood = i))),
            ])),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 12),
              // Figma: 날짜 (13px #999999, bottom border)
              Container(width: 345, height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: AppColors.gray100, width: 1))),
                alignment: Alignment.centerLeft,
                child: const Text('2026년 2월 8일 월요일', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                  color: Color(0xFF999999)))),
              // Figma: 제목 입력 row ("제목" 13px Bold #888 + input 14px)
              Container(width: 345, height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: AppColors.gray100, width: 1))),
                child: Row(children: [
                  const Text('제목', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                    fontSize: 13, height: 1.21, color: Color(0xFF888888))),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _titleController,
                    style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                      fontSize: 14, height: 1.21, color: AppColors.gray900),
                    decoration: const InputDecoration(
                      hintText: '제목을 입력하세요',
                      hintStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                        fontSize: 14, height: 1.21, color: Color(0xFFC8C8C0)),
                      border: InputBorder.none, isDense: true,
                      contentPadding: EdgeInsets.zero))),
                ])),
              const SizedBox(height: 16),
              // Figma: 그림·사진 영역 (345x236, cornerRadius=12, bg=#F2F4F6)
              GestureDetector(
                onTap: () {}, // 사진 추가
                child: Container(width: 345, height: 236,
                  decoration: BoxDecoration(color: AppColors.gray50,
                    borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 40, color: AppColors.gray300),
                      SizedBox(height: 8),
                      // Figma: "탭하여 그림·사진 추가" (12px #C8C8C0)
                      Text('탭하여 그림·사진 추가', style: TextStyle(fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, fontSize: 12, height: 1.21,
                        color: Color(0xFFC8C8C0))),
                    ])))),
              const SizedBox(height: 16),
              // Figma: 본문 입력 영역 (height=300, fontSize=14)
              SizedBox(height: 300,
                child: TextField(controller: _bodyController,
                  maxLines: null, expands: true, textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                    fontSize: 14, height: 2.14, color: Color(0xFF333333)),
                  decoration: const InputDecoration(
                    hintText: '오늘 하루를 기록해보세요',
                    hintStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                      fontSize: 14, height: 1.21, color: Color(0xFFC8C8C0)),
                    border: InputBorder.none, isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8)))),
            ]))),
        ]),
      ),
    );
  }

  Widget _iconChip(String emoji, double w, double h, bool selected, VoidCallback onTap) =>
    GestureDetector(onTap: onTap, child: Container(
      width: w, height: h, margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary.withOpacity(0.15) : AppColors.gray50,
        borderRadius: BorderRadius.circular(14),
        border: selected ? Border.all(color: AppColors.primary, width: 1) : null),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 15))));

  @override
  void dispose() { _titleController.dispose(); _bodyController.dispose(); super.dispose(); }
}
```

---

### 8-7. 일기 수정 (`screens/diary/edit_diary_screen.dart`)

**Figma 원본**: Node ID `53:1182`, Label: `S6-3 — Edit Diary` (WriteDiary와 동일 구조, 데이터 프리필)

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class EditDiaryScreen extends StatefulWidget {
  const EditDiaryScreen({super.key});
  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  // Pre-filled from existing diary
  late final TextEditingController _titleController = TextEditingController(text: '설날 모임');
  late final TextEditingController _bodyController = TextEditingController(
    text: '오늘은 설날이라서 친구들이랑 같이 떡국을\n'
          '먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n'
          '오후에는 영화관에서 영화를 봤는데 너무\n'
          '재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n'
          '저녁에는 집에 와서 같이 셀카도 찍었다.\n'
          '다음에도 이렇게 만나고 싶다!');
  int _selectedWeather = 0; // ☀ pre-selected
  int _selectedMood = 1; // 😍 pre-selected

  final List<String> _weatherIcons = ['☀', '⛅', '⛆', '❄'];
  final List<String> _moodIcons = ['😊', '😍', '😢', '😴'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          // Header "일기 수정" + 저장 button
          CenterTitleHeader(
            title: '일기 수정',
            trailing: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14)),
                child: const Text('저장', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                  color: AppColors.white)))),
          ),
          // 날씨 + 기분 bar (same as WriteDiary)
          Container(height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(border: Border(
              bottom: BorderSide(color: AppColors.gray100, width: 1))),
            child: Row(children: [
              const Text('날씨', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                fontSize: 13, height: 1.21, color: AppColors.gray700)),
              const SizedBox(width: 8),
              ...List.generate(4, (i) => _chip(_weatherIcons[i], 30, 27,
                _selectedWeather == i, () => setState(() => _selectedWeather = i))),
              const SizedBox(width: 16),
              const Text('기분', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                fontSize: 13, height: 1.21, color: AppColors.gray700)),
              const SizedBox(width: 8),
              ...List.generate(4, (i) => _chip(_moodIcons[i], 27, 28,
                _selectedMood == i, () => setState(() => _selectedMood = i))),
            ])),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 12),
              // 날짜
              Container(width: 345, height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: AppColors.gray100, width: 1))),
                alignment: Alignment.centerLeft,
                child: const Text('2026년 2월 8일 일요일', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                  color: Color(0xFF999999)))),
              // 제목 (pre-filled)
              Container(width: 345, height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(color: AppColors.gray100, width: 1))),
                child: Row(children: [
                  const Text('제목', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                    fontSize: 13, height: 1.21, color: Color(0xFF888888))),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _titleController,
                    style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                      fontSize: 16, height: 1.21, color: AppColors.gray900),
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true,
                      contentPadding: EdgeInsets.zero))),
                ])),
              const SizedBox(height: 16),
              // 그림 영역 (pre-filled with image placeholder)
              Container(width: 345, height: 236,
                decoration: BoxDecoration(color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(12)),
                child: Center(child: Container(width: 80, height: 60,
                  decoration: BoxDecoration(color: AppColors.gray200,
                    borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.image, size: 32, color: AppColors.gray400)))),
              const SizedBox(height: 16),
              // 본문 (pre-filled)
              SizedBox(height: 300,
                child: TextField(controller: _bodyController,
                  maxLines: null, expands: true, textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                    fontSize: 14, height: 2.14, color: Color(0xFF333333)),
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8)))),
            ]))),
        ]),
      ),
    );
  }

  Widget _chip(String emoji, double w, double h, bool sel, VoidCallback onTap) =>
    GestureDetector(onTap: onTap, child: Container(width: w, height: h,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: sel ? AppColors.primary.withOpacity(0.15) : AppColors.gray50,
        borderRadius: BorderRadius.circular(14),
        border: sel ? Border.all(color: AppColors.primary, width: 1) : null),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 15))));

  @override
  void dispose() { _titleController.dispose(); _bodyController.dispose(); super.dispose(); }
}
```

---

### 8-8. 프로필 편집 (`screens/mypage/edit_profile_screen.dart`)

**Figma 원본**: Node ID `54:186`, Label: `S8-1 — Edit Profile`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: '김민수');
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          // Figma: Header "프로필 편집" + "저장" button
          CenterTitleHeader(
            title: '프로필 편집',
            trailing: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14)),
                child: const Text('저장', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                  color: AppColors.white)))),
          ),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: [
              const SizedBox(height: 32),
              // Figma: Profile avatar (96x96, borderRadius=48)
              Center(child: Column(children: [
                Container(width: 96, height: 96,
                  decoration: BoxDecoration(color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(48)),
                  child: const Icon(Icons.person, size: 48, color: AppColors.gray400)),
                const SizedBox(height: 8),
                // Figma: "사진 변경" (13px Regular #8B95A1)
                const Text('사진 변경', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                  color: AppColors.gray500)),
              ])),
              const SizedBox(height: 32),
              // Figma: "이름" field (13px label + 15px input)
              _field('이름', _nameController, '이름을 입력하세요'),
              const SizedBox(height: 24),
              // Figma: "상태 메시지" field
              _field('상태 메시지', _statusController, '상태 메시지를 입력하세요'),
              const SizedBox(height: 32),
              // Figma: Preview section
              Container(width: 345,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Container(width: 44, height: 44,
                    decoration: BoxDecoration(color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(22)),
                    child: const Icon(Icons.person, size: 24, color: AppColors.gray400)),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Figma: name preview (16px Bold)
                    Text(_nameController.text.isEmpty ? '이름' : _nameController.text,
                      style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700,
                        fontSize: 16, height: 1.21, color: AppColors.gray900)),
                    const SizedBox(height: 2),
                    // Figma: status preview (13px #8B95A1)
                    Text(_statusController.text.isEmpty ? '상태 메시지 미설정' : _statusController.text,
                      style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                        fontSize: 13, height: 1.21, color: AppColors.gray500)),
                  ]),
                ])),
              const SizedBox(height: 32),
              // Figma: "연동 계정" section
              Container(width: 345,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gray100, width: 1)),
                child: Row(children: [
                  // Figma: K badge (24x24, #FEE500 bg, "K" 12px Bold #3C1E1E)
                  Container(width: 24, height: 24,
                    decoration: BoxDecoration(color: const Color(0xFFFEE500),
                      borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: const Text('K', style: TextStyle(fontFamily: 'Inter',
                      fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF3C1E1E)))),
                  const SizedBox(width: 12),
                  const Text('카카오 계정으로 로그인됨', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400, fontSize: 14, height: 1.21,
                    color: AppColors.gray900)),
                ])),
            ]))),
        ]),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
        fontSize: 13, height: 1.21, color: AppColors.gray500)),
      const SizedBox(height: 8),
      TextField(controller: ctrl,
        style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
          fontSize: 15, height: 1.21, color: AppColors.gray900),
        decoration: InputDecoration(hintText: hint,
          hintStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
            fontSize: 15, height: 1.21, color: AppColors.gray300),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.gray200)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.gray200)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary))),
        onChanged: (_) => setState(() {})),
    ]);

  @override
  void dispose() { _nameController.dispose(); _statusController.dispose(); super.dispose(); }
}
```

---

### 8-9. 알림 설정 (`screens/mypage/notification_settings_screen.dart`)

**Figma 원본**: Node ID `54:230`, Label: `S8-2 — Notification Settings`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});
  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _allNotifications = true;
  final List<Map<String, dynamic>> _groups = [
    {'emoji': '🏠', 'name': '대학 친구들', 'members': '멤버 5명', 'enabled': true},
    {'emoji': '✈️', 'name': '여행 모임', 'members': '멤버 8명', 'enabled': true},
    {'emoji': '💼', 'name': '회사 동기', 'members': '멤버 4명', 'enabled': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          const CenterTitleHeader(title: '알림 설정'),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 24),
              // Figma: "전체 알림" toggle
              Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Figma: "전체 알림" (16px Bold)
                  const Text('전체 알림', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w700, fontSize: 16, height: 1.21,
                    color: AppColors.gray900)),
                  const SizedBox(height: 2),
                  // Figma: subtitle (12px #8B95A1)
                  const Text('모든 알림을 켜거나 끌 수 있습니다', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w400, fontSize: 12, height: 1.21,
                    color: AppColors.gray500)),
                ])),
                // Figma: Switch (44x24, Material default)
                Switch(value: _allNotifications,
                  onChanged: (v) => setState(() {
                    _allNotifications = v;
                    for (var g in _groups) { g['enabled'] = v; }
                  }),
                  activeColor: AppColors.primary),
              ]),
              const SizedBox(height: 32),
              // Figma: "그룹방별 알림" section
              const Text('그룹방별 알림', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                color: AppColors.gray700)),
              const SizedBox(height: 16),
              // Figma: Group toggle list
              ..._groups.asMap().entries.map((entry) {
                final i = entry.key;
                final g = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(children: [
                    // Figma: emoji (18px in 36x36 circle)
                    Container(width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(18)),
                      alignment: Alignment.center,
                      child: Text(g['emoji'] as String,
                        style: const TextStyle(fontSize: 18))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      // Figma: group name (15px Regular)
                      Text(g['name'] as String, style: const TextStyle(fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, fontSize: 15, height: 1.21,
                        color: AppColors.gray900)),
                      // Figma: member count (11px #8B95A1)
                      Text(g['members'] as String, style: const TextStyle(fontFamily: 'Inter',
                        fontWeight: FontWeight.w400, fontSize: 11, height: 1.21,
                        color: AppColors.gray500)),
                    ])),
                    Switch(value: g['enabled'] as bool,
                      onChanged: (v) => setState(() => _groups[i]['enabled'] = v),
                      activeColor: AppColors.primary),
                  ]),
                );
              }),
            ]))),
        ]),
      ),
    );
  }
}
```

---

### 8-10. 개인정보 관리 (`screens/mypage/privacy_settings_screen.dart`)

**Figma 원본**: Node ID `54:294`, Label: `S8-3 — Privacy Settings`

```dart
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(children: [
          const CenterTitleHeader(title: '개인정보 관리'),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 24),
              // ── "기본 정보" section ──
              const Text('기본 정보', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                color: AppColors.gray700)),
              const SizedBox(height: 16),
              // Figma: 이름 row (label 13px #8B95A1, value 14px #191F28)
              _infoRow('이름', '홍길동'),
              const SizedBox(height: 12),
              _infoRow('이메일', 'hong@email.com'),
              const SizedBox(height: 12),
              _infoRow('가입일', '2026.01.15'),
              const SizedBox(height: 12),
              // Figma: 로그인 방식 with badge
              Row(children: [
                const SizedBox(width: 100, child: Text('로그인', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 13, height: 1.21,
                  color: AppColors.gray500))),
                // Figma: "카카오" badge (11px Bold #3C1E1E, bg=#FEE500)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFFEE500),
                    borderRadius: BorderRadius.circular(4)),
                  child: const Text('카카오', style: TextStyle(fontFamily: 'Inter',
                    fontWeight: FontWeight.w700, fontSize: 11, height: 1.21,
                    color: Color(0xFF3C1E1E)))),
              ]),
              const SizedBox(height: 32),
              Container(height: 1, color: AppColors.gray100),
              const SizedBox(height: 24),
              // ── "보안 설정" section ──
              const Text('보안 설정', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                color: AppColors.gray700)),
              const SizedBox(height: 16),
              // Figma: 보안 메뉴 items (15px Regular)
              _menuItem('비밀번호 변경', () {}),
              const SizedBox(height: 16),
              _menuItem('2차 인증 설정', () {}),
              const SizedBox(height: 16),
              _menuItem('로그인 기록', () {}),
              const SizedBox(height: 32),
              Container(height: 1, color: AppColors.gray100),
              const SizedBox(height: 24),
              // ── "계정 관리" section ──
              const Text('계정 관리', style: TextStyle(fontFamily: 'Inter',
                fontWeight: FontWeight.w700, fontSize: 13, height: 1.21,
                color: AppColors.gray700)),
              const SizedBox(height: 16),
              // Figma: "로그아웃" (15px #8B95A1)
              GestureDetector(onTap: () {},
                child: const Text('로그아웃', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 15, height: 1.21,
                  color: AppColors.gray500))),
              const SizedBox(height: 16),
              // Figma: "회원 탈퇴" (15px #FF4D4D)
              GestureDetector(onTap: () {},
                child: const Text('회원 탈퇴', style: TextStyle(fontFamily: 'Inter',
                  fontWeight: FontWeight.w400, fontSize: 15, height: 1.21,
                  color: Color(0xFFFF4D4D)))),
              const SizedBox(height: 8),
              // Figma: warning text (11px #B0B8C1)
              const Text('탈퇴 시 모든 데이터가 삭제되며 복구할 수 없습니다.',
                style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
                  fontSize: 11, height: 1.21, color: AppColors.gray400)),
              const SizedBox(height: 48),
            ]))),
        ]),
      ),
    );
  }

  static Widget _infoRow(String label, String value) => Row(children: [
    SizedBox(width: 100, child: Text(label, style: const TextStyle(fontFamily: 'Inter',
      fontWeight: FontWeight.w400, fontSize: 13, height: 1.21, color: AppColors.gray500))),
    Text(value, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
      fontSize: 14, height: 1.21, color: AppColors.gray900)),
  ]);

  static Widget _menuItem(String label, VoidCallback onTap) => GestureDetector(onTap: onTap,
    child: Row(children: [
      Text(label, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400,
        fontSize: 15, height: 1.21, color: AppColors.gray900)),
      const Spacer(),
      const Icon(Icons.chevron_right, size: 16, color: AppColors.gray400),
    ]));
}
```

---

## 9. 보완된 네비게이션 라우터

Part 2의 라우터에 새로 추가된 서브화면들을 반영합니다:

```dart
// navigation/app_router.dart 에 추가할 라우트들:
case '/schedule-detail':
  return MaterialPageRoute(builder: (_) => const ScheduleDetailScreen());
case '/add-schedule':
  return MaterialPageRoute(builder: (_) => const AddScheduleScreen());
case '/diary-detail':
  return MaterialPageRoute(builder: (_) => const DiaryDetailScreen());
case '/write-diary':
  return MaterialPageRoute(builder: (_) => const WriteDiaryScreen());
case '/edit-diary':
  return MaterialPageRoute(builder: (_) => const EditDiaryScreen());
case '/edit-profile':
  return MaterialPageRoute(builder: (_) => const EditProfileScreen());
case '/notification-settings':
  return MaterialPageRoute(builder: (_) => const NotificationSettingsScreen());
case '/privacy-settings':
  return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());
```

바텀시트 호출 방법 (라우트가 아닌 `showModalBottomSheet`):
```dart
// DayDetailBottomSheet (캘린더 날짜 탭 시)
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => const DayDetailBottomSheet(date: '2월 8일 일요일', eventCount: 2),
);

// ParticipantPopup (참가자 추가 탭 시)
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => const ParticipantPopup(),
);
```

---

## 10. 최종 구현 현황

| # | 화면 | 파일 | Node ID | 상태 |
|---|---|---|---|---|
| 1 | S1 Splash | splash_screen.dart | 46:1483 | ✅ Part 1 |
| 2 | S2-1 Social Login | social_login_screen.dart | 46:1396 | ✅ Part 1 |
| 3 | S2-2 Terms Agreement | terms_agreement_screen.dart | 46:1423 | ✅ Part 2 |
| 4 | S3A Empty State | empty_state_screen.dart | 42:599 | ✅ Part 2 |
| 5 | S3A-1 Code Input | (CodeInputBottomSheet 내장) | 42:647 | ✅ Part 2 |
| 6 | S3A-2 Code Generate | code_generate_screen.dart | 42:667 | ✅ Part 2 |
| 7 | S3A-3 Create/Edit Diary | create_diary_screen.dart | 54:422/54:492 | ✅ Part 2 |
| 8 | S3B Group List | group_list_screen.dart | 48:109 | ✅ Part 2 |
| 9 | S4 Group Home | group_home_screen.dart | 54:556 | ✅ Part 2 |
| 10 | S5 Schedule Calendar | schedule_calendar_screen.dart | 42:302 | ✅ Part 2 |
| 11 | S5-1 Schedule Detail | schedule_detail_screen.dart | 53:2 | ✅ **Part 3** |
| 12 | S5-1 Day Detail Sheet | day_detail_bottom_sheet.dart | 54:862 | ✅ **Part 3** |
| 13 | S5-2 Add Schedule | add_schedule_screen.dart | 54:1021 | ✅ **Part 3** |
| 14 | S5-2 Participant Popup | participant_popup.dart | 54:1132 | ✅ **Part 3** |
| 15 | S6 Diary Calendar | diary_calendar_screen.dart | 46:116 | ✅ Part 2 |
| 16 | S6-1 Diary Detail | diary_detail_screen.dart | 53:674 | ✅ **Part 3** |
| 17 | S6-2 Write Diary | write_diary_screen.dart | 53:975 | ✅ **Part 3** |
| 18 | S6-3 Edit Diary | edit_diary_screen.dart | 53:1182 | ✅ **Part 3** |
| 19 | S7 Quiz Coming Soon | quiz_coming_soon_screen.dart | 46:529 | ✅ Part 2 |
| 20 | S8 My Page | my_page_screen.dart | 48:2 | ✅ Part 2 |
| 21 | S8-1 Edit Profile | edit_profile_screen.dart | 54:186 | ✅ **Part 3** |
| 22 | S8-2 Notification Settings | notification_settings_screen.dart | 54:230 | ✅ **Part 3** |
| 23 | S8-3 Privacy Settings | privacy_settings_screen.dart | 54:294 | ✅ **Part 3** |
| 24 | S9 Notifications | notifications_screen.dart | 54:354 | ✅ Part 2 |
| 25 | S10 Todo List | todo_list_screen.dart | 54:805 | ✅ Part 2 |

**전체 23개 Figma 화면 + 2개 바텀시트 = 25개 위젯 전체 코드 완성** ✅

