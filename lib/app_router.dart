import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/social_login_screen.dart';
import 'screens/auth/terms_agreement_screen.dart';
import 'screens/onboarding/empty_state_screen.dart';
import 'screens/onboarding/code_generate_screen.dart';
import 'screens/onboarding/create_diary_screen.dart';
import 'screens/group/group_list_screen.dart';
import 'screens/group/group_home_screen.dart';
import 'screens/schedule/schedule_calendar_screen.dart';
import 'screens/schedule/schedule_detail_screen.dart';
import 'screens/schedule/add_schedule_screen.dart';
import 'screens/diary/diary_calendar_screen.dart';
import 'screens/diary/diary_detail_screen.dart';
import 'screens/diary/write_diary_screen.dart';
import 'screens/diary/edit_diary_screen.dart';
import 'screens/game/quiz_coming_soon_screen.dart';
import 'screens/mypage/my_page_screen.dart';
import 'screens/mypage/edit_profile_screen.dart';
import 'screens/mypage/notification_settings_screen.dart';
import 'screens/mypage/privacy_settings_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'screens/todo/todo_list_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const SocialLoginScreen());
      case '/terms':
        final loginType = settings.arguments as String? ?? 'kakao';
        return MaterialPageRoute(
            builder: (_) => TermsAgreementScreen(loginType: loginType));
      case '/home':
        return MaterialPageRoute(builder: (_) => const EmptyStateScreen());
      case '/code-generate':
        return MaterialPageRoute(builder: (_) => const CodeGenerateScreen());
      case '/create-diary':
        return MaterialPageRoute(builder: (_) => const CreateDiaryScreen());
      case '/update-diary':
        return MaterialPageRoute(
            builder: (_) => const CreateDiaryScreen(isEdit: true));
      case '/group-list':
        return MaterialPageRoute(builder: (_) => const GroupListScreen());
      case '/group-home':
        return MaterialPageRoute(builder: (_) => const GroupHomeScreen());
      case '/schedule':
        return MaterialPageRoute(builder: (_) => const ScheduleCalendarScreen());
      case '/schedule-detail':
        return MaterialPageRoute(builder: (_) => const ScheduleDetailScreen());
      case '/add-schedule':
        return MaterialPageRoute(builder: (_) => const AddScheduleScreen());
      case '/diary':
        return MaterialPageRoute(builder: (_) => const DiaryCalendarScreen());
      case '/diary-detail':
        return MaterialPageRoute(builder: (_) => const DiaryDetailScreen());
      case '/write-diary':
        return MaterialPageRoute(builder: (_) => const WriteDiaryScreen());
      case '/edit-diary':
        return MaterialPageRoute(builder: (_) => const EditDiaryScreen());
      case '/quiz':
        return MaterialPageRoute(builder: (_) => const QuizComingSoonScreen());
      case '/my-page':
        return MaterialPageRoute(builder: (_) => const MyPageScreen());
      case '/edit-profile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/notification-settings':
        return MaterialPageRoute(builder: (_) => const NotificationSettingsScreen());
      case '/privacy-settings':
        return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());
      case '/notifications':
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case '/todo':
        return MaterialPageRoute(builder: (_) => const TodoListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('경로를 찾을 수 없어요: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
