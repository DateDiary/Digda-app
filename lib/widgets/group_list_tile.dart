import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GroupListTile extends StatelessWidget {
  final String name;
  final String memberCount;
  final IconData groupIcon;
  final Color groupIconBg;
  final bool hasNotification;
  final bool hasSettings;
  final VoidCallback? onTap;

  const GroupListTile({
    super.key,
    required this.name,
    required this.memberCount,
    this.groupIcon = Icons.group,
    this.groupIconBg = AppColors.gray50,
    this.hasNotification = false,
    this.hasSettings = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 361,
        height: 92,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 14,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: groupIconBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(groupIcon, size: 24, color: AppColors.gray500),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    memberCount,
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
              ),
            ),
            if (hasNotification || hasSettings) ...[
              const Icon(Icons.notifications_outlined, size: 24, color: AppColors.gray400),
              const SizedBox(width: 8),
              const Icon(Icons.settings_outlined, size: 24, color: AppColors.gray400),
            ],
            const Icon(Icons.chevron_right, size: 20, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}
