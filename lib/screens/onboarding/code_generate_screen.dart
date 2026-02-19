import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/primary_button.dart';

class CodeGenerateScreen extends StatefulWidget {
  const CodeGenerateScreen({super.key});

  @override
  State<CodeGenerateScreen> createState() => _CodeGenerateScreenState();
}

class _CodeGenerateScreenState extends State<CodeGenerateScreen> {
  final String _generatedCode = 'A1B2C3';
  bool _copied = false;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _generatedCode));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CenterTitleHeader(
              title: '참여 코드',
              onBack: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            const Text(
              '다이어리 참여 코드',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _generatedCode,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 34,
                height: 1.21,
                letterSpacing: 8,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _copyCode,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _copied ? Icons.check : Icons.copy,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _copied ? '복사됨' : '코드 복사',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '이 코드를 친구에게 공유하면\n같은 다이어리에 참여할 수 있어요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5,
                  letterSpacing: 0,
                  color: AppColors.gray500,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: '확인',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
