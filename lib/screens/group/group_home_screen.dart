import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/feature_card.dart';

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Text(
                    '우리 커플 다이어리',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('/notifications'),
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.settings_outlined,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildMemberAvatars(),
                    const SizedBox(height: 24),
                    const Text(
                      '무엇을 기록할까요?',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FeatureCard(
                      icon: Icons.calendar_today_outlined,
                      iconBgColor: AppColors.gray50,
                      title: '일정',
                      subtitle: '함께하는 일정을 관리해요',
                      onTap: () => Navigator.of(context).pushNamed('/schedule'),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.book_outlined,
                      iconBgColor: AppColors.gray50,
                      title: '일기',
                      subtitle: '소중한 순간을 기록해요',
                      onTap: () => Navigator.of(context).pushNamed('/diary'),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.quiz_outlined,
                      iconBgColor: AppColors.gray50,
                      title: '퀴즈',
                      subtitle: '서로를 얼마나 아는지 확인해요',
                      onTap: () => Navigator.of(context).pushNamed('/quiz'),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.check_circle_outline,
                      iconBgColor: AppColors.gray50,
                      title: '투두리스트',
                      subtitle: '함께 해야 할 일을 체크해요',
                      onTap: () => Navigator.of(context).pushNamed('/todo'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildMemberAvatars() {
    return Row(
      children: [
        _buildAvatar('나', AppColors.primary),
        const SizedBox(width: 8),
        _buildAvatar('상대', AppColors.blue),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: const [
              Icon(Icons.people_outline, size: 14, color: AppColors.gray500),
              SizedBox(width: 4),
              Text(
                '멤버 2명',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.21,
                  letterSpacing: 0,
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label[0],
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.21,
            letterSpacing: 0,
            color: AppColors.gray500,
          ),
        ),
      ],
    );
  }
}
