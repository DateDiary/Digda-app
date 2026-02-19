import 'package:flutter/material.dart';
import '../../theme/colors.dart';

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
            Container(
              width: 36,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.book_outlined, size: 20, color: AppColors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              '디지털 그룹 다이어리',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '소셜 계정으로 3초만에 시작하세요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            _buildSocialButton(
              text: '카카오로 시작하기',
              backgroundColor: AppColors.kakaoYellow,
              textColor: AppColors.kakaoText,
              icon: 'K',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 12),
            _buildSocialButton(
              text: '네이버로 시작하기',
              backgroundColor: AppColors.naverGreen,
              textColor: AppColors.white,
              icon: 'N',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 12),
            _buildSocialButton(
              text: 'Apple로 시작하기',
              backgroundColor: AppColors.appleBlack,
              textColor: AppColors.white,
              icon: '',
              onPressed: () => Navigator.of(context).pushNamed('/terms'),
            ),
            const SizedBox(height: 48),
            const Text(
              '로그인 시 이용약관과 개인정보처리방침에 동의하게 됩니다',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
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
              if (icon == '')
                const Icon(Icons.apple, size: 20, color: AppColors.white)
              else
                Text(
                  icon,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
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
