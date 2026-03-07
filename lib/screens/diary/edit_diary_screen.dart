import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class EditDiaryScreen extends StatefulWidget {
  const EditDiaryScreen({super.key});

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final TextEditingController _titleController =
      TextEditingController(text: '설날 모임');

  String _formatDate(DateTime date) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[date.weekday - 1];
    return '${date.year}년 ${date.month}월 ${date.day}일 ${weekday}요일';
  }

  final TextEditingController _contentController = TextEditingController(
    text: '오늘은 설날이라서 친구들이랑 같이 떡국을\n먹었다. 아침에 세배도 하고 세뱃돈도 받았다.\n오후에는 영화관에서 영화를 봤는데 너무\n재밌었다. 팝콘이랑 콜라 먹으면서 행복했다.\n저녁에는 집에 와서 같이 셀카도 찍었다.\n다음에도 이렇게 만나고 싶다!',
  );

  int _selectedWeather = 0;
  int _selectedMood = 1;
  bool _hasImage = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - 좌측 뒤로가기 + 제목 + 우측 저장
            Container(
              color: AppColors.white,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
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
                  const SizedBox(width: 8),
                  const Text(
                    '일기 수정',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.gray900,
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
            ),
            // Weather + Mood selector
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Row(
                children: [
                  const Text(
                    '날씨',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ...List.generate(_weatherOptions.length, (i) {
                    final opt = _weatherOptions[i];
                    final isSelected = _selectedWeather == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedWeather = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? opt.color.withValues(alpha: 0.15)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          opt.icon,
                          size: 20,
                          color: isSelected ? opt.color : AppColors.gray400,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 16),
                  const Text(
                    '기분',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ...List.generate(_moodEmojis.length, (i) {
                    final isSelected = _selectedMood == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedMood = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: 32,
                        height: 32,
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
                              fontSize: isSelected ? 20 : 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Writing area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Date + title + image block
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
                          // Date display
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                            child: Text(
                              _formatDate(DateTime(2026, 2, 8)),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.gray400,
                              ),
                            ),
                          ),
                          const Divider(color: AppColors.gray100, height: 1),
                          // Title input
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 14,
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
                              Expanded(
                                child: TextField(
                                  controller: _titleController,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppColors.gray900,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: AppColors.gray100, height: 1),
                          // Image area (with existing image + remove button)
                          if (_hasImage)
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.07),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      style: BorderStyle.solid,
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
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _hasImage = false),
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
                          else
                            GestureDetector(
                              onTap: () => setState(() => _hasImage = true),
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.gray50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.gray200),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 28,
                                      color: AppColors.gray300,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '사진 추가',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
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
                    // Lined writing area
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
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.gray100, width: 1),
                  ),
                ),
              ),
            ),
          ),
          TextField(
            controller: _contentController,
            maxLines: null,
            minLines: 12,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 2.93,
              color: AppColors.gray800,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
