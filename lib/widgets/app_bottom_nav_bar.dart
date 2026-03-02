import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  void _navigate(BuildContext context, int index) {
    if (currentIndex == index) return;
    const routes = ['/group-list', '/schedule', '/diary', '/quiz'];
    if (index < routes.length) {
      Navigator.of(context).pushReplacementNamed(routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.gray100, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 62,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTab(context, 0, Icons.home_outlined, '홈'),
                _buildTab(context, 1, Icons.calendar_today_outlined, '일정'),
                _buildTab(context, 2, Icons.menu_book_outlined, '일기'),
                _buildTab(context, 3, Icons.sports_esports_outlined, '게임'),
              ],
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;
    final Color color = isSelected ? AppColors.primary : AppColors.gray400;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!.call(index);
        } else {
          _navigate(context, index);
        }
      },
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
