import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/outline_button.dart';

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
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // 하단 흰색 시트
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 32),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                    icon: const Icon(Icons.close, color: AppColors.gray500),
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/home'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
