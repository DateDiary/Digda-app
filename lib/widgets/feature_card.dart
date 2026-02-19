import 'package:flutter/material.dart';
import '../theme/colors.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final Widget? badge;
  final bool isDisabled;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    this.iconBgColor = AppColors.gray50,
    required this.title,
    required this.subtitle,
    this.badge,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: 361,
        height: 110,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isDisabled ? AppColors.gray400 : AppColors.gray900,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      height: 1.21,
                      letterSpacing: 0,
                      color: isDisabled ? AppColors.gray400 : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1.21,
                      letterSpacing: 0,
                      color: isDisabled ? AppColors.gray200 : AppColors.gray500,
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(height: 4),
                    badge!,
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isDisabled ? AppColors.gray200 : AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }
}
