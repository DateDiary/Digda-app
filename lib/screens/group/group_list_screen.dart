import 'package:flutter/material.dart';
import '../../theme/colors.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            // 헤더 - 푸터 제거됨, 제목 변경
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    '내 그룹',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1.3,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
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
                      Icons.settings_outlined,
                      size: 24,
                      color: AppColors.gray700,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/my-page'),
                  ),
                ],
              ),
            ),
            // 그룹 리스트 - 그룹 수에 따라 동적 중앙 배치
            Expanded(
              child: _groups.length < 6
                  ? Center(
                      child: _buildGroupContent(context),
                    )
                  : SingleChildScrollView(
                      child: _buildGroupContent(context),
                    ),
            ),
          ],
        ),
      ),
      // 푸터 제거됨
    );
  }

  Widget _buildGroupContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                onTap: () => Navigator.of(context).pushNamed('/group-home',
                    arguments: g.name),
                onShare: () =>
                    Navigator.of(context).pushNamed('/code-generate'),
                onSettings: () =>
                    Navigator.of(context).pushNamed('/update-diary'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/create-diary'),
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
