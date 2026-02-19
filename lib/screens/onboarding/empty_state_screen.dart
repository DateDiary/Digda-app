import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/outline_button.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date Diary',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.gray900,
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.book_outlined,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 80,
                  child: _buildDecorativeMark(),
                ),
                Positioned(
                  top: 20,
                  right: 60,
                  child: _buildDecorativeMark(),
                ),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.book_outlined,
                        size: 40,
                        color: AppColors.gray300,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '아직 참여 중인 다이어리가 없어요',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '코드를 입력하거나 새 다이어리를 만들어보세요',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            AppOutlineButton(
              text: '코드로 참여하기',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => const CodeInputBottomSheet(),
                );
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: '새 다이어리 만들기',
              onPressed: () => Navigator.of(context).pushNamed('/create-diary'),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildDecorativeMark() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          '?',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class CodeInputBottomSheet extends StatefulWidget {
  const CodeInputBottomSheet({super.key});

  @override
  State<CodeInputBottomSheet> createState() => _CodeInputBottomSheetState();
}

class _CodeInputBottomSheetState extends State<CodeInputBottomSheet> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '참여 코드 입력',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '다이어리 참여 코드 6자리를 입력해주세요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 328,
            height: 56,
            child: TextField(
              controller: _codeController,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 8,
                color: AppColors.gray900,
              ),
              decoration: InputDecoration(
                counterText: '',
                hintText: '------',
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  letterSpacing: 8,
                  color: AppColors.gray200,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.gray200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: '참여하기',
            onPressed: _codeController.text.length == 6
                ? () => Navigator.of(context).pushReplacementNamed('/group-list')
                : null,
          ),
        ],
      ),
    );
  }
}
