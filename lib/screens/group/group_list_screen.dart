import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/group_list_tile.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {'name': '우리 커플 다이어리', 'memberCount': '멤버 2명', 'icon': Icons.favorite_outline, 'bg': AppColors.gray50},
      {'name': '가족 여행 기록', 'memberCount': '멤버 4명', 'icon': Icons.flight_outlined, 'bg': AppColors.gray50},
      {'name': '친구들과 일상', 'memberCount': '멤버 5명', 'icon': Icons.group_outlined, 'bg': AppColors.gray50},
    ];

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
                  const Text(
                    'Date Diary',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/create-diary'),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GroupListTile(
                      name: group['name'] as String,
                      memberCount: group['memberCount'] as String,
                      groupIcon: group['icon'] as IconData,
                      groupIconBg: group['bg'] as Color,
                      onTap: () => Navigator.of(context).pushNamed('/group-home'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
