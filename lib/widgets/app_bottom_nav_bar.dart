import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.gray100, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab(0, Icons.calendar_today_outlined, '일정'),
          _buildTab(1, Icons.menu_book_outlined, '일기'),
          _buildTab(2, Icons.sports_esports_outlined, '게임'),
          _buildTab(3, Icons.person_outline, '마이'),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected ? AppColors.primary : AppColors.gray400;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.21,
                letterSpacing: 0,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
