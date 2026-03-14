import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_router.dart';
import 'theme/colors.dart';

class DigdaApp extends StatefulWidget {
  const DigdaApp({super.key});

  @override
  State<DigdaApp> createState() => _DigdaAppState();
}

class _DigdaAppState extends State<DigdaApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() {
    // 앱이 이미 실행 중일 때 들어오는 딥링크 처리
    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });

    // 앱이 종료 상태에서 딥링크로 시작된 경우
    return _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        // 초기 라우트 빌드 후 처리되도록 약간 딜레이
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleDeepLink(uri);
        });
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    // digda://invite?code=A3X9K2
    if (uri.host == 'invite') {
      final code = uri.queryParameters['code'];
      if (code != null && code.length == 6) {
        _navigatorKey.currentState?.pushNamed('/code-input', arguments: code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: '디그다',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ko', 'KR'),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Inter',
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          surface: AppColors.white,
          onSurface: AppColors.gray900,
        ),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.gray900),
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.gray900,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
