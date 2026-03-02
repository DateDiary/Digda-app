import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mock diary data with colors for left border
  final List<Map<String, dynamic>> _recentDiaries = [
    {
      'title': '설날 데이트',
      'preview': '오늘 떡국 먹고 영화 봤다. 너무 행복했다...',
      'date': '2026.02.08',
      'color': AppColors.primary,
      'hasImage': true,
    },
    {
      'title': '제물포 바닷가 산책',
      'preview': '바다 보면서 산책하고 커피 마셨다...',
      'date': '2026.02.07',
      'color': AppColors.blue,
      'hasImage': true,
    },
    {
      'title': '카페에서 브런치',
      'preview': '새로 생긴 카페 가봤는데 분위기 좋았다...',
      'date': '2026.02.05',
      'color': AppColors.green,
      'hasImage': true,
    },
  ];

  final Map<DateTime, List<Map<String, dynamic>>> _diaries = {
    DateTime.utc(2026, 2, 5): [
      {'title': '카페에서 브런치'},
    ],
    DateTime.utc(2026, 2, 7): [
      {'title': '제물포 바닷가 산책'},
    ],
    DateTime.utc(2026, 2, 8): [
      {'title': '설날 데이트'},
    ],
    DateTime.utc(2026, 2, 14): [
      {'title': '발렌타인 데이'},
    ],
    DateTime.utc(2026, 2, 21): [
      {'title': '주말'},
    ],
    DateTime.utc(2026, 2, 22): [
      {'title': '산책'},
    ],
  };

  List<Map<String, dynamic>> _getDiariesForDay(DateTime day) {
    return _diaries[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 14,
                              color: AppColors.gray900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '그림일기',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                                color: AppColors.gray900,
                              ),
                            ),
                            Text(
                              '${_focusedDay.year}년 ${_focusedDay.month}월',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('/notifications'),
                                  child: Stack(
                                    children: [
                                      const Icon(
                                        Icons.notifications_outlined,
                                        size: 22,
                                        color: AppColors.gray700,
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('/my-page'),
                                  child: const Icon(
                                    Icons.settings_outlined,
                                    size: 22,
                                    color: AppColors.gray700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Calendar
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    eventLoader: _getDiariesForDay,
                    calendarFormat: CalendarFormat.month,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: false,
                      headerPadding: EdgeInsets.zero,
                      titleTextStyle: TextStyle(fontSize: 0),
                      leftChevronPadding: EdgeInsets.zero,
                      rightChevronPadding: EdgeInsets.zero,
                      leftChevronIcon: SizedBox.shrink(),
                      rightChevronIcon: SizedBox.shrink(),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.white,
                      ),
                      defaultTextStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.gray900,
                      ),
                      weekendTextStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.primary,
                      ),
                      outsideTextStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.gray300,
                      ),
                      markersMaxCount: 1,
                      markerDecoration: const BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                      ),
                      markerSize: 5,
                      markerMargin: const EdgeInsets.only(top: 1),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: AppColors.gray500,
                      ),
                      weekendStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      Navigator.of(context).pushNamed('/diary-detail');
                    },
                    onPageChanged: (focusedDay) {
                      setState(() => _focusedDay = focusedDay);
                    },
                  ),
                  // Legend
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Color(0xFFFBBF24),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '일기가 있는 날',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Recent diary section header
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '최근 일기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: AppColors.gray900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Diary list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final diary = _recentDiaries[index];
                  return _buildDiaryItem(diary);
                },
                childCount: _recentDiaries.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/write-diary'),
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.white, size: 28),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildDiaryItem(Map<String, dynamic> diary) {
    final color = diary['color'] as Color;
    final hasImage = diary['hasImage'] as bool;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/diary-detail'),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray100),
        ),
        child: Row(
          children: [
            // Left color border
            Container(
              width: 3,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diary['title'] as String,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diary['preview'] as String,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diary['date'] as String,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
            // Image placeholder
            if (hasImage)
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 24,
                  color: color.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
