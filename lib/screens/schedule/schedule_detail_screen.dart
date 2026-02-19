import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class ScheduleDetailScreen extends StatelessWidget {
  const ScheduleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CenterTitleHeader(
              title: '일정 상세',
              onBack: () => Navigator.of(context).pop(),
              trailing: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.more_horiz,
                  size: 22,
                  color: AppColors.gray700,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '발렌타인 데이',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            height: 1.21,
                            letterSpacing: 0,
                            color: AppColors.gray900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: '날짜',
                      value: '2025년 2월 14일 (금)',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      icon: Icons.access_time_outlined,
                      label: '시간',
                      value: '오후 6:00 - 오후 10:00',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      icon: Icons.location_on_outlined,
                      label: '장소',
                      value: '한강 공원',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      icon: Icons.people_outline,
                      label: '참여자',
                      value: '나, 상대',
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 1,
                      color: AppColors.gray100,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '메모',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '한강에서 피크닉 예정. 돗자리와 간식 챙겨오기!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.5,
                        letterSpacing: 0,
                        color: AppColors.gray700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.gray400),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
