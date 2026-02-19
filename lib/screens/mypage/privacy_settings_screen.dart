import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/back_header.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackHeader(
              title: '개인정보 처리방침',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      '1. 수집하는 개인정보 항목',
                      '디그다는 서비스 제공을 위해 다음과 같은 개인정보를 수집합니다.\n\n- 필수항목: 이메일 주소, 닉네임\n- 선택항목: 프로필 사진',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      '2. 개인정보의 수집 및 이용목적',
                      '수집된 개인정보는 다음의 목적을 위해 활용합니다.\n\n- 서비스 제공 및 운영\n- 고객 문의 응대\n- 서비스 개선',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      '3. 개인정보의 보유 및 이용기간',
                      '수집된 개인정보는 회원 탈퇴 시까지 보유하며, 탈퇴 후 즉시 파기합니다.',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      '4. 개인정보의 제3자 제공',
                      '디그다는 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다.',
                    ),
                    const SizedBox(height: 40),
                    Text(
                      '시행일: 2025년 1월 1일',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray400,
                      ),
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

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            height: 1.21,
            letterSpacing: 0,
            color: AppColors.gray900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.6,
            letterSpacing: 0,
            color: AppColors.gray700,
          ),
        ),
      ],
    );
  }
}
