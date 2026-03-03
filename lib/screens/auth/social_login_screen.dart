import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

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
            SvgPicture.asset(
              'assets/svg/logo.svg',
              width: 48,
              height: 50,
            ),
            const SizedBox(height: 20),
            const Text(
              '디지털 그룹 다이어리',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '소셜 계정으로 3초만에 시작하세요',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            _SocialButton(
              text: '카카오로 시작하기',
              backgroundColor: AppColors.kakaoYellow,
              textColor: AppColors.kakaoText,
              icon: SvgPicture.asset(
                'assets/svg/kakao_logo.svg',
                width: 20,
                height: 20,
              ),
              onPressed: () => Navigator.of(context).pushNamed('/terms', arguments: 'kakao'),
            ),
            const SizedBox(height: 12),
            _SocialButton(
              text: '네이버로 시작하기',
              backgroundColor: AppColors.naverGreen,
              textColor: AppColors.white,
              icon: const Text(
                'N',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/terms', arguments: 'naver'),
            ),
            const SizedBox(height: 12),
            _SocialButton(
              text: 'Apple로 시작하기',
              backgroundColor: AppColors.appleBlack,
              textColor: AppColors.white,
              icon: const Icon(Icons.apple, size: 20, color: AppColors.white),
              onPressed: () => Navigator.of(context).pushNamed('/terms', arguments: 'apple'),
            ),
            const SizedBox(height: 48),
            Text(
              '로그인 시 이용약관과 개인정보처리방침에 동의하게 됩니다',
              style: AppTextStyles.captionLarge.copyWith(
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
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.onPressed,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 345,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
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
