import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/back_header.dart';
import '../../widgets/primary_button.dart';

class EditDiaryScreen extends StatefulWidget {
  const EditDiaryScreen({super.key});

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final TextEditingController _titleController =
      TextEditingController(text: '발렌타인 데이');
  final TextEditingController _contentController = TextEditingController(
      text: '오늘은 정말 특별한 발렌타인 데이였어요. 한강에서 피크닉을 하면서 함께 보낸 시간이 너무 소중했어요.');

  bool get _canSave =>
      _titleController.text.trim().isNotEmpty &&
      _contentController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackHeader(
              title: '일기 수정',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 12),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.3,
                        letterSpacing: 0,
                        color: AppColors.gray900,
                      ),
                      decoration: const InputDecoration(
                        hintText: '제목',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.gray200,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const Divider(color: AppColors.gray100),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _contentController,
                      maxLines: null,
                      minLines: 10,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.6,
                        letterSpacing: 0,
                        color: AppColors.gray800,
                      ),
                      decoration: const InputDecoration(
                        hintText: '오늘의 소중한 순간을 기록해보세요...',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: AppColors.inputHint,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: '수정 완료',
                onPressed: _canSave
                    ? () => Navigator.of(context).pop()
                    : null,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
