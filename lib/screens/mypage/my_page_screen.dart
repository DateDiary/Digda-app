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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '마이페이지',
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
                    onTap: () => Navigator.of(context).pushNamed('/notifications'),
                    child: const Icon(
                      Icons.notifications_outlined,
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
                  children: [
                    _buildProfileSection(context),
                    const SizedBox(height: 8),
                    _buildDivider(),
                    _buildMenuSection(
                      title: '계정',
                      items: [
                        _MenuItem(
                          icon: Icons.person_outline,
                          label: '프로필 수정',
                          onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
                        ),
                      ],
                    ),
                    _buildDivider(),
                    _buildMenuSection(
                      title: '알림',
                      items: [
                        _MenuItem(
                          icon: Icons.notifications_outlined,
                          label: '알림 설정',
                          onTap: () => Navigator.of(context).pushNamed('/notification-settings'),
                        ),
                      ],
                    ),
                    _buildDivider(),
                    _buildMenuSection(
                      title: '정보',
                      items: [
                        _MenuItem(
                          icon: Icons.privacy_tip_outlined,
                          label: '개인정보 처리방침',
                          onTap: () => Navigator.of(context).pushNamed('/privacy-settings'),
                        ),
                        _MenuItem(
                          icon: Icons.description_outlined,
                          label: '이용약관',
                          onTap: () {},
                        ),
                        _MenuItem(
                          icon: Icons.info_outline,
                          label: '앱 버전',
                          trailing: const Text(
                            '1.0.0',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.gray400,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    _buildDivider(),
                    _buildMenuSection(
                      items: [
                        _MenuItem(
                          icon: Icons.logout,
                          label: '로그아웃',
                          labelColor: AppColors.primaryDark,
                          onTap: () => Navigator.of(context).pushReplacementNamed('/login'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '나',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '사용자 이름',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'user@email.com',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20, color: AppColors.gray400),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 8,
      color: AppColors.gray50,
    );
  }

  Widget _buildMenuSection({
    String? title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray400,
              ),
            ),
          ),
        ],
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: AppColors.white,
        child: Row(
          children: [
            Icon(item.icon, size: 20, color: item.labelColor ?? AppColors.gray700),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 1.21,
                  letterSpacing: 0,
                  color: item.labelColor ?? AppColors.gray900,
                ),
              ),
            ),
            item.trailing ?? const Icon(Icons.chevron_right, size: 20, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color? labelColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.labelColor,
    this.trailing,
    required this.onTap,
  });
}
