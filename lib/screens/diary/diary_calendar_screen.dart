import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/diary_list_item.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> _diaries = {
    DateTime.utc(2025, 2, 14): [
      {'title': '발렌타인 데이', 'preview': '오늘은 특별한 날이었어요', 'hasImage': true},
    ],
    DateTime.utc(2025, 2, 20): [
      {'title': '영화 데이트', 'preview': '오랜만에 영화를 봤어요', 'hasImage': false},
    ],
  };

  List<Map<String, dynamic>> _getDiariesForDay(DateTime day) {
    return _diaries[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selectedDiaries = _selectedDay != null
        ? _getDiariesForDay(_selectedDay!)
        : _getDiariesForDay(_focusedDay);

    final displayDate = _selectedDay ?? _focusedDay;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CenterTitleHeader(
              title: '일기',
              onBack: () => Navigator.of(context).pop(),
              trailing: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/write-diary'),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 22,
                  color: AppColors.gray700,
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: _getDiariesForDay,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.gray900,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  size: 20,
                  color: AppColors.gray700,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.gray700,
                ),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.primary,
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
                markerDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.gray500,
                ),
                weekendStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() => _focusedDay = focusedDay);
              },
            ),
            const Divider(color: AppColors.gray100, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${displayDate.month}월 ${displayDate.day}일의 일기',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray900,
                    ),
                  ),
                  Text(
                    '${selectedDiaries.length}개',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.21,
                      letterSpacing: 0,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: selectedDiaries.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book_outlined,
                            size: 40,
                            color: AppColors.gray200,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '이날의 일기가 없어요',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: selectedDiaries.length,
                      itemBuilder: (context, index) {
                        final diary = selectedDiaries[index];
                        return DiaryListItem(
                          title: diary['title'] as String,
                          preview: diary['preview'] as String,
                          date: '${displayDate.year}.${displayDate.month.toString().padLeft(2, '0')}.${displayDate.day.toString().padLeft(2, '0')}',
                          hasImage: diary['hasImage'] as bool,
                          onTap: () => Navigator.of(context).pushNamed('/diary-detail'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/write-diary'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.edit_outlined, color: AppColors.white),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
