import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class DiaryDetailScreen extends StatefulWidget {
  const DiaryDetailScreen({super.key});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  bool _showMenu = false;

  void _onEditTap() {
    setState(() => _showMenu = false);
    Navigator.of(context).pushNamed('/edit-diary');
  }

  void _onDeleteTap() {
    setState(() => _showMenu = false);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '일기를 삭제할까요?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '삭제한 일기는 되돌릴 수 없어요',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.gray200),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.gray700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ── 헤더 ──
                Container(
                  color: AppColors.white,
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 18,
                          color: AppColors.gray900,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () =>
                            setState(() => _showMenu = !_showMenu),
                        icon: const Icon(
                          Icons.more_horiz_rounded,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                      ),
                    ],
                  ),
                ),
                // ── 본문 ──
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 상단 히어로 카드
                        Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 날짜
                              const Text(
                                '2026년 2월 8일 일요일',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.gray500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // 제목
                              const Text(
                                '설날 모임',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                  color: AppColors.gray900,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 14),
                              // 날씨 + 기분 칩
                              Row(
                                children: [
                                  _buildChip(
                                    icon: Icons.wb_sunny_outlined,
                                    iconColor: const Color(0xFFFBBF24),
                                    label: '맑음',
                                  ),
                                  const SizedBox(width: 8),
                                  _buildChip(
                                    emoji: '😊',
                                    label: '행복',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 이미지 카드
                        Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              height: 220,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5F0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.photo_rounded,
                                      size: 28,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '오늘의 사진',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 본문 카드
                        Container(
                          color: AppColors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                          child: const Text(
                            '오늘은 설날이라서 친구들이랑 같이 떡국을 먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n\n오후에는 영화관에서 영화를 봤는데 너무 재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n\n저녁에는 집에 와서 같이 셀카도 찍었다. 다음에도 이렇게 만나고 싶다!',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 1.8,
                              color: AppColors.gray800,
                              letterSpacing: -0.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 작성자 정보
                        Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.primary.withValues(alpha: 0.2),
                                      AppColors.primary.withValues(alpha: 0.08),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '나',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.gray900,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '오후 8:32에 작성',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: _onEditTap,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.gray50,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    '수정하기',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppColors.gray700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // 드롭다운 메뉴 오버레이
            if (_showMenu) ...[
              GestureDetector(
                onTap: () => setState(() => _showMenu = false),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: 48,
                right: 16,
                child: _buildDropdownMenu(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChip({
    IconData? icon,
    Color? iconColor,
    String? emoji,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, size: 16, color: iconColor),
          if (emoji != null)
            Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.gray700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return Container(
      width: 148,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _onEditTap,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 18, color: AppColors.gray700),
                  SizedBox(width: 10),
                  Text(
                    '수정',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            color: AppColors.gray100,
          ),
          GestureDetector(
            onTap: _onDeleteTap,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.delete_outline_rounded,
                      size: 18, color: AppColors.primary),
                  SizedBox(width: 10),
                  Text(
                    '삭제',
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
