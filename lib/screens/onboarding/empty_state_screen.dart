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
  static const int _codeLength = 6;
  final List<TextEditingController> _controllers =
      List.generate(_codeLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(_codeLength, (_) => FocusNode());

  bool get _isFilled => _controllers.every((c) => c.text.isNotEmpty);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 40,
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
            '초대 코드를 입력하세요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.3,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '상대방에게 받은 6자리 코드를 입력해주세요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              letterSpacing: 0,
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_codeLength, (index) {
              return SizedBox(
                width: 48,
                height: 56,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.gray900,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.gray50,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _controllers[index].text.isNotEmpty
                            ? AppColors.primary
                            : AppColors.gray200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) => _onChanged(value, index),
                  onTap: () => setState(() {}),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: '참여하기',
            onPressed: _isFilled
                ? () => Navigator.of(context).pushReplacementNamed('/group-list')
                : null,
          ),
        ],
      ),
    );
  }
}
