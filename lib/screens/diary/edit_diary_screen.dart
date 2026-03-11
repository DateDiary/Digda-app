import 'dart:io';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/image_pick_helper.dart';

class EditDiaryScreen extends StatefulWidget {
  const EditDiaryScreen({super.key});

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final TextEditingController _titleController =
      TextEditingController(text: '설날 모임');
  final TextEditingController _contentController = TextEditingController(
    text: '오늘은 설날이라서 친구들이랑 같이 떡국을\n먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n오후에는 영화관에서 영화를 봤는데 너무\n재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n저녁에는 집에 와서 같이 셀카도 찍었다.\n다음에도 이렇게 만나고 싶다!',
  );

  static const int _maxTitleLength = 20;
  static const int _maxContentLength = 300;

  int _selectedWeather = 0;
  int _selectedMood = 1;
  File? _pickedImage;
  DateTime _selectedDate = DateTime(2026, 2, 8);

  bool get _canSave =>
      _titleController.text.trim().isNotEmpty &&
      _contentController.text.trim().isNotEmpty;

  final List<_WeatherOption> _weatherOptions = const [
    _WeatherOption(icon: Icons.wb_sunny_outlined, color: Color(0xFFFBBF24)),
    _WeatherOption(icon: Icons.wb_cloudy_outlined, color: AppColors.gray400),
    _WeatherOption(icon: Icons.grain, color: AppColors.blue),
    _WeatherOption(icon: Icons.ac_unit, color: AppColors.saturdayBlue),
  ];

  final List<String> _moodEmojis = ['😊', '😍', '😂', '🥰'];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[date.weekday - 1];
    return '${date.year}년 ${date.month}월 ${date.day}일 ${weekday}요일';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      body: SafeArea(
        child: Column(
          children: [
            // ── 헤더: < 일기 수정(중앙) 저장(우) ──
            Container(
              color: const Color(0xFFFFFDF5),
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    '일기 수정',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.gray900,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 14,
                            color: AppColors.gray900,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _canSave
                            ? () => Navigator.of(context).pop()
                            : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _canSave
                                ? AppColors.primary
                                : AppColors.gray200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '저장',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: _canSave
                                  ? AppColors.white
                                  : AppColors.gray400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ── 날씨 + 기분 선택 바 ──
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAF9F4),
                border: Border(
                  bottom: BorderSide(color: AppColors.gray100),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      '날씨',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(_weatherOptions.length, (i) {
                      final opt = _weatherOptions[i];
                      final isSelected = _selectedWeather == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedWeather = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? opt.color.withValues(alpha: 0.15)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            opt.icon,
                            size: 18,
                            color: isSelected ? opt.color : AppColors.gray400,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 12),
                    const Text(
                      '기분',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(_moodEmojis.length, (i) {
                      final isSelected = _selectedMood == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMood = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _moodEmojis[i],
                              style: TextStyle(
                                fontSize: isSelected ? 18 : 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            // ── 본문 영역 ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    // 날짜 + 제목 + 이미지 카드
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.gray100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 날짜 (클릭하여 변경)
                          GestureDetector(
                            onTap: () => _showDateChangeDialog(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 14, 16, 10),
                              child: Row(
                                children: [
                                  Text(
                                    _formatDate(_selectedDate),
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.edit_calendar_outlined,
                                    size: 14,
                                    color: AppColors.gray400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                              color: AppColors.gray100, height: 1),
                          // 제목 입력
                          Container(
                            color: const Color(0xFFFFF8F0),
                            child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right:
                                        BorderSide(color: AppColors.gray100),
                                  ),
                                ),
                                child: const Text(
                                  '제목',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppColors.gray900,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _titleController,
                                  maxLength: _maxTitleLength,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.gray900,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '제목을 입력하세요',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: AppColors.gray300,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    counterText:
                                        '${_titleController.text.length}/$_maxTitleLength',
                                    counterStyle: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: AppColors.gray400,
                                    ),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                          ),
                          const Divider(
                              color: AppColors.gray100, height: 1),
                          // 이미지 추가 영역
                          GestureDetector(
                            onTap: () async {
                              final file = await pickImage(context);
                              if (file != null) {
                                setState(() => _pickedImage = file);
                              }
                            },
                            child: _pickedImage != null
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                        child: Image.file(
                                          _pickedImage!,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () =>
                                              setState(() => _pickedImage = null),
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: AppColors.gray700,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              size: 14,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    height: 160,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              width: 72,
                                              height: 56,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.gray300,
                                                  width: 1.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.image_outlined,
                                                size: 32,
                                                color: AppColors.gray300,
                                              ),
                                            ),
                                            Positioned(
                                              top: -6,
                                              right: -6,
                                              child: Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.gray400,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 12,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '탭하여 그림·사진 추가',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: AppColors.gray400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    // 줄이 있는 본문 입력 영역
                    _buildLinedArea(),
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

  Future<void> _showDateChangeDialog() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.gray900,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Widget _buildLinedArea() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Stack(
        children: [
          Column(
            children: List.generate(
              12,
              (i) => Container(
                height: 44,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.gray100, width: 1),
                  ),
                ),
              ),
            ),
          ),
          TextField(
            controller: _contentController,
            maxLength: _maxContentLength,
            maxLines: null,
            minLines: 12,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 2.93,
              color: AppColors.gray800,
            ),
            decoration: InputDecoration(
              hintText: '오늘의 소중한 순간을 기록해보세요...',
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 2.93,
                color: AppColors.gray300,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              counterText:
                  '${_contentController.text.length}/$_maxContentLength',
              counterStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                color: AppColors.gray400,
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }
}

class _WeatherOption {
  final IconData icon;
  final Color color;

  const _WeatherOption({required this.icon, required this.color});
}
