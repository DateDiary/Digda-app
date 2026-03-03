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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          '일기 삭제',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.gray900,
          ),
        ),
        content: const Text(
          '이 일기를 삭제하시겠습니까?',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.gray700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '취소',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.gray500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              '삭제',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - 좌측 정렬
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                      const SizedBox(width: 16),
                      const Text(
                        '일기 상세',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: AppColors.gray900,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _showMenu = !_showMenu),
                        child: const Icon(
                          Icons.more_horiz,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date + mood
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Text(
                                '2026년 2월 8일 일요일',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.gray400,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: AppColors.gray100,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 18,
                                  color: Color(0xFFFBBF24),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '😊',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Title row
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gray100),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: AppColors.gray100),
                                  ),
                                ),
                                child: const Text(
                                  '제목',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.gray400,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                '설날 모임',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.gray900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Image area
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.07),
                            border: Border.all(color: AppColors.gray100),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 64,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFBBF24),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                size: 32,
                                color: Color(0xFFFBBF24),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Diary content
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '오늘은 설날이라서 친구들이랑 같이 떡국을\n먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n오후에는 영화관에서 영화를 봤는데 너무\n재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n저녁에는 집에 와서 같이 셀카도 찍었다.\n다음에도 이렇게 만나고 싶다!',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              height: 1.9,
                              color: AppColors.gray800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Divider(color: AppColors.gray100),
                        const SizedBox(height: 12),
                        // Author info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                '나 · 오후 8:32',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.gray400,
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
            // Dropdown menu
            if (_showMenu) ...[
              GestureDetector(
                onTap: () => setState(() => _showMenu = false),
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                top: 44,
                right: 24,
                child: _buildDropdownMenu(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _onEditTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, size: 18, color: AppColors.gray700),
                    SizedBox(width: 10),
                    Text(
                      '편집',
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
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: AppColors.gray100,
            ),
            GestureDetector(
              onTap: _onDeleteTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 18, color: AppColors.primary),
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
      ),
    );
  }
}
