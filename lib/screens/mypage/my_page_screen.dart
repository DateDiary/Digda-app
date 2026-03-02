import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '마이페이지',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/notifications'),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/my-page'),
                    child: const Icon(
                      Icons.settings_outlined,
                      size: 22,
                      color: AppColors.gray700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile section
                    _buildProfileSection(context),
                    const SizedBox(height: 24),
                    // 다이어리 관리 section
                    _buildSectionLabel('다이어리 관리'),
                    _buildMenuItem(
                      context,
                      icon: Icons.menu_outlined,
                      label: '그룹방 목록 보기',
                      onTap: () => Navigator.of(context).pushNamed('/home'),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.keyboard_outlined,
                      label: '초대 코드 입력',
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    // 설정 section
                    _buildSectionLabel('설정'),
                    _buildMenuItem(
                      context,
                      icon: Icons.notifications_outlined,
                      label: '알림 설정',
                      onTap: () => Navigator.of(context)
                          .pushNamed('/notification-settings'),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.lock_outline,
                      label: '개인정보 관리',
                      onTap: () =>
                          Navigator.of(context).pushNamed('/privacy-settings'),
                    ),
                    const SizedBox(height: 16),
                    // 기타 section
                    _buildSectionLabel('기타'),
                    _buildMenuItem(
                      context,
                      icon: Icons.info_outline,
                      label: '앱 정보',
                      trailing: const Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.gray400,
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
            child: Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.primary,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.gray700,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '홍길동',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed('/edit-profile'),
                child: Row(
                  children: const [
                    Text(
                      '프로필 편집',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: AppColors.gray400,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Widget? trailing,
    Color? labelColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: AppColors.white,
        child: Row(
          children: [
            Icon(icon, size: 20, color: labelColor ?? AppColors.gray700),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: labelColor ?? AppColors.gray900,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.gray400,
                ),
          ],
        ),
      ),
    );
  }
}
