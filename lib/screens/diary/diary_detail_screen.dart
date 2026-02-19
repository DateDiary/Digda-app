import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';

class DiaryDetailScreen extends StatelessWidget {
  const DiaryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CenterTitleHeader(
              title: '일기',
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
                    const Text(
                      '2025년 2월 14일 금요일',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 16),
                    _buildAuthorChip('나'),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: AppColors.gray300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '오늘은 정말 특별한 발렌타인 데이였어요. 한강에서 피크닉을 하면서 함께 보낸 시간이 너무 소중했어요. 다음에도 이런 날이 많았으면 좋겠어요.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.6,
                        letterSpacing: 0,
                        color: AppColors.gray800,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.gray100),
                    const SizedBox(height: 16),
                    const Text(
                      '상대의 일기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAuthorChip('상대'),
                    const SizedBox(height: 12),
                    const Text(
                      '오늘 같이 한강에서 피크닉을 했는데 날씨도 좋고 정말 행복했어요. 앞으로도 이런 추억 많이 만들고 싶어요!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.6,
                        letterSpacing: 0,
                        color: AppColors.gray800,
                      ),
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

  Widget _buildAuthorChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 1.21,
          letterSpacing: 0,
          color: AppColors.gray500,
        ),
      ),
    );
  }
}
