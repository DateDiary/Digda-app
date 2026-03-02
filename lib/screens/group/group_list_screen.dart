import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/group_list_tile.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  static const _groups = [
    _GroupData(
      name: '대학 친구들',
      memberCount: '4명 참여 중',
      icon: Icons.image_outlined,
      bgColor: Color(0xFFFFEAEA),
      iconColor: AppColors.primary,
      showActions: false,
    ),
    _GroupData(
      name: '여행 모임',
      memberCount: '6명 참여 중',
      icon: Icons.diamond_outlined,
      bgColor: Color(0xFFEAEEFF),
      iconColor: Color(0xFF6B82F0),
      showActions: true,
    ),
    _GroupData(
      name: '회사 동기',
      memberCount: '2명 참여 중',
      icon: Icons.coffee_outlined,
      bgColor: Color(0xFFFFF3E0),
      iconColor: Color(0xFFF0A050),
      showActions: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
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
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const Expanded(
                    child: Text(
                      '내 다이어리',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.3,
                        color: AppColors.gray900,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          size: 24,
                          color: AppColors.gray700,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/notifications'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.adjust_outlined,
                      size: 24,
                      color: AppColors.gray700,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/my-page'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  ..._groups.map(
                    (g) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GroupListTile(
                        name: g.name,
                        memberCount: g.memberCount,
                        groupIcon: g.icon,
                        groupIconBg: g.bgColor,
                        groupIconColor: g.iconColor,
                        showActions: g.showActions,
                        onTap: () =>
                            Navigator.of(context).pushNamed('/group-home'),
                        onShare: () =>
                            Navigator.of(context).pushNamed('/code-generate'),
                        onSettings: () =>
                            Navigator.of(context).pushNamed('/update-diary'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 새 다이어리 추가
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/create-diary'),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            '새 다이어리 추가',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
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
}

class _GroupData {
  final String name;
  final String memberCount;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool showActions;

  const _GroupData({
    required this.name,
    required this.memberCount,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.showActions,
  });
}
