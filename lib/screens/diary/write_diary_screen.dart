import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  int _selectedWeather = 0; // 0=맑음, 1=흐림, 2=비, 3=눈
  int _selectedMood = 1;    // 0~3 emoji index

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
      backgroundColor: const Color(0xFFFDF8F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - 중앙 타이틀 + 좌측 뒤로가기 + 우측 저장
            Container(
              color: AppColors.white,
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    '일기 쓰기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.gray900,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 14,
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    child: GestureDetector(
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                            child: Text(
                              _formatDate(DateTime.now()),
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
                              Expanded(
                                child: TextField(
                                  controller: _titleController,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.gray900,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: '제목을 입력하세요',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: AppColors.gray300,
                                    ),
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
                          // Image picker
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.gray300,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 28,
                                      color: AppColors.gray300,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
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
          // Lines
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
          // Text input
          TextField(
            controller: _contentController,
            maxLines: null,
            minLines: 12,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 2.93, // matches 44px line height
              color: AppColors.gray800,
            ),
            decoration: const InputDecoration(
              hintText: '오늘의 소중한 순간을 기록해보세요...',
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 2.93,
                color: AppColors.gray300,
              ),
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
