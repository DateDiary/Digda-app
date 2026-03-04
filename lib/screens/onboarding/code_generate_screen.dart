import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/outline_button.dart';
import '../../widgets/feature_card.dart';

class CodeGenerateScreen extends StatefulWidget {
  const CodeGenerateScreen({super.key});

  @override
  State<CodeGenerateScreen> createState() => _CodeGenerateScreenState();
}

class _CodeGenerateScreenState extends State<CodeGenerateScreen> {
  final String _generatedCode = 'A3X9K2';
  bool _copied = false;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _generatedCode));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  void _shareCode() {
    // 공유 기능 (추후 구현)
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.gray400,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== 첫 번째 뷰포트: 코드 생성 화면 (S3A-2) =====
            SizedBox(
              height: screenHeight,
              child: Stack(
                children: [
                  // 하단 흰색 시트
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 48),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 36,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.gray200,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            '초대 코드가 생성됐어요!',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              height: 1.3,
                              letterSpacing: 0,
                              color: AppColors.gray900,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // 코드 표시 박스
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                _generatedCode,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36,
                                  letterSpacing: 6,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // 버튼 2개
                          Row(
                            children: [
                              Expanded(
                                child: AppOutlineButton(
                                  text: _copied ? '복사됨' : '코드 복사',
                                  onPressed: _copyCode,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: '공유하기',
                                  onPressed: _shareCode,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              '상대방이 이 코드를 입력하면 연결돼요',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                height: 1.5,
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Center(
                            child: Text(
                              '코드는 24시간 후 만료됩니다',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5,
                                color: AppColors.gray400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 상단 닫기 버튼
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon:
                            const Icon(Icons.close, color: AppColors.white),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed('/home'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ===== 두 번째 뷰포트: S3A-3-Create_New_Diary 배경 =====
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '다이어리를 만들어보세요',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '그룹원들과 함께 사용할 다이어리를 생성할 수 있어요',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: '다이어리 만들기',
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed('/create-diary'),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed('/group-home'),
                      child: const Text(
                        '나중에 할게요',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ===== 세 번째 뷰포트: S4-Group_Home 미리보기 =====
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const Text(
                    '생성된 그룹방',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FeatureCard(
                    icon: Icons.calendar_month_outlined,
                    iconBgColor: AppColors.primary.withValues(alpha: 0.15),
                    iconColor: AppColors.primary,
                    cardBgColor: AppColors.primary.withValues(alpha: 0.06),
                    title: '일정 관리',
                    subtitle: '우리 모임 일정을 한눈에',
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed('/group-home'),
                  ),
                  const SizedBox(height: 12),
                  FeatureCard(
                    icon: Icons.book_outlined,
                    iconBgColor: const Color(0xFFFFE88A),
                    iconColor: const Color(0xFFC89A00),
                    cardBgColor: const Color(0xFFFFFBEE),
                    title: '그림일기',
                    subtitle: '오늘의 추억을 기록해요',
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed('/group-home'),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: '그룹방으로 이동',
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed('/group-home'),
                  ),
                  SizedBox(height: bottomPadding + 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
