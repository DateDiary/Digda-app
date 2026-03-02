import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/feature_card.dart';

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  static const _memberColors = [
    AppColors.primary,
    AppColors.blue,
    AppColors.green,
    AppColors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppColors.gray900,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        '대학 친구들',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          height: 1.3,
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 22,
                      color: AppColors.gray700,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/notifications'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.adjust_outlined,
                      size: 22,
                      color: AppColors.gray700,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // 멤버 아바타
                    _buildMemberSection(),
                    const SizedBox(height: 24),
                    // 기능 카드들
                    FeatureCard(
                      icon: Icons.calendar_month_outlined,
                      iconBgColor: AppColors.primary.withValues(alpha: 0.15),
                      iconColor: AppColors.primary,
                      cardBgColor: AppColors.primary.withValues(alpha: 0.06),
                      title: '일정 관리',
                      subtitle: '우리 모임 일정을 한눈에',
                      onTap: () =>
                          Navigator.of(context).pushNamed('/schedule'),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.book_outlined,
                      iconBgColor: const Color(0xFFFFE88A),
                      iconColor: const Color(0xFFC89A00),
                      cardBgColor: const Color(0xFFFFFBEE),
                      title: '그림일기',
                      subtitle: '오늘의 추억을 기록해요',
                      onTap: () => Navigator.of(context).pushNamed('/diary'),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.sentiment_satisfied_outlined,
                      iconBgColor: AppColors.gray100,
                      iconColor: AppColors.gray400,
                      cardBgColor: AppColors.gray50,
                      title: '퀴즈 게임',
                      subtitle: '준비 중이에요',
                      isDisabled: true,
                      badge: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gray200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Coming Soon',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: AppColors.gray500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FeatureCard(
                      icon: Icons.check_box_outlined,
                      iconBgColor: AppColors.blue.withValues(alpha: 0.2),
                      iconColor: AppColors.blue,
                      cardBgColor: AppColors.blue.withValues(alpha: 0.06),
                      title: '투두리스트',
                      subtitle: '할 일을 함께 관리해요',
                      badge: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '3개 남음',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                      onTap: () => Navigator.of(context).pushNamed('/todo'),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberSection() {
    const totalMembers = 7;
    const displayCount = 4;
    const extraCount = totalMembers - displayCount;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(displayCount, (i) => _buildAvatar(i)),
            const SizedBox(width: 8),
            _buildExtraAvatar(extraCount),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '7명 참여 중',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(int index) {
    final color = _memberColors[index % _memberColors.length];
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Icon(Icons.person_outline, size: 22, color: color),
    );
  }

  Widget _buildExtraAvatar(int count) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColors.gray500,
          ),
        ),
      ),
    );
  }
}
