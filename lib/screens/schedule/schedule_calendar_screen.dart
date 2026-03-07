import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  State<ScheduleCalendarScreen> createState() =>
      _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> _events = {
    DateTime.utc(2026, 2, 1): [
      {'title': '야근', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 5): [
      {'title': '야근', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 7): [
      {'title': '출근 일찍', 'color': AppColors.primary},
      {'title': '카페로 데이트', 'color': AppColors.purple},
    ],
    DateTime.utc(2026, 2, 8): [
      {'title': '야근', 'color': AppColors.primary, 'time': '종일'},
      {
        'title': '출근 늦게',
        'color': AppColors.purple,
        'time': '오후 2:00 - 5:00'
      },
    ],
    DateTime.utc(2026, 2, 14): [
      {'title': '출근 늦게', 'color': AppColors.purple},
    ],
    DateTime.utc(2026, 2, 16): [
      {'title': '설날연휴', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 17): [
      {'title': '설날', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 18): [
      {'title': '설날연휴', 'color': AppColors.primary},
      {'title': '영화보기', 'color': AppColors.purple},
    ],
    DateTime.utc(2026, 2, 20): [
      {'title': '야근', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 22): [
      {'title': '야근', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 26): [
      {'title': '야근', 'color': AppColors.primary},
    ],
    DateTime.utc(2026, 2, 28): [
      {'title': '출근 일찍', 'color': AppColors.primary},
      {'title': '부랄 저녁', 'color': AppColors.purple},
    ],
    DateTime.utc(2026, 3, 1): [
      {'title': '삼일절', 'color': AppColors.eventHoliday, 'isHoliday': true},
    ],
    DateTime.utc(2026, 3, 2): [
      {'title': '대체휴일', 'color': AppColors.eventHoliday, 'isHoliday': true},
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  // 사용자 일정만 (공휴일 제외)
  List<Map<String, dynamic>> _getUserEventsForDay(DateTime day) {
    return _getEventsForDay(day)
        .where((e) => e['isHoliday'] != true)
        .toList();
  }

  void _showDayDetail(DateTime day) {
    final userEvents = _getUserEventsForDay(day);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DayDetailBottomSheet(
        day: day,
        events: userEvents,
        onAddSchedule: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/add-schedule');
        },
        onScheduleTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/schedule-detail');
        },
      ),
    ).then((_) {
      setState(() => _selectedDay = null);
    });
  }

  Widget _buildDayCell(
    DateTime day,
    List<Map<String, dynamic>> events,
    double rowHeight, {
    Color? circleBg,
    required Color textColor,
  }) {
    return SizedBox(
      height: rowHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          if (circleBg != null)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: circleBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: textColor,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 24,
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: textColor,
                  ),
                ),
              ),
            ),
          // 이벤트 마커 - 숫자 바로 아래 밀착
          ...events.take(2).map((event) {
            final color = event['color'] as Color;
            return Container(
              margin: const EdgeInsets.only(top: 1, left: 2, right: 2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                event['title'] as String,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더 - 제목 "일정" + 우측 아이콘
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  const Text(
                    '일정',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: AppColors.gray900,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/notifications'),
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
                    onTap: () =>
                        Navigator.of(context).pushNamed('/my-page'),
                    child: const Icon(
                      Icons.settings_outlined,
                      size: 22,
                      color: AppColors.gray700,
                    ),
                  ),
                ],
              ),
            ),
            // 날짜 네비게이션 - 가운데 정렬
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                      );
                    }),
                    child: const Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${_focusedDay.year}년 ${_focusedDay.month}월',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: AppColors.gray700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                    }),
                    child: const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            // 캘린더 - 하단까지 확장
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final rowHeight =
                      ((constraints.maxHeight - 28) / 6).clamp(64.0, 100.0);
                  return TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),
                    eventLoader: _getEventsForDay,
                    calendarFormat: CalendarFormat.month,
                    headerVisible: false,
                    daysOfWeekHeight: 24,
                    rowHeight: rowHeight,
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.white,
                      ),
                      todayDecoration: BoxDecoration(),
                      todayTextStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: AppColors.white,
                      ),
                      defaultTextStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.gray900,
                      ),
                      weekendTextStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.primary,
                      ),
                      outsideTextStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.gray300,
                      ),
                      markersMaxCount: 2,
                      cellAlignment: Alignment.topCenter,
                      cellMargin: EdgeInsets.all(1),
                      cellPadding: EdgeInsets.only(top: 4),
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
                    calendarBuilders: CalendarBuilders(
                      // 기본 날짜 - 숫자 + 이벤트 밀착
                      defaultBuilder: (context, day, focusedDay) {
                        final events = _getEventsForDay(day);
                        final isWeekend =
                            day.weekday == DateTime.saturday ||
                            day.weekday == DateTime.sunday;
                        return _buildDayCell(
                          day,
                          events,
                          rowHeight,
                          textColor: isWeekend
                              ? AppColors.primary
                              : AppColors.gray900,
                        );
                      },
                      // 오늘 날짜 - 검은 원 + 이벤트 밀착
                      todayBuilder: (context, day, focusedDay) {
                        final events = _getEventsForDay(day);
                        return _buildDayCell(
                          day,
                          events,
                          rowHeight,
                          circleBg: AppColors.black,
                          textColor: AppColors.white,
                        );
                      },
                      // 선택된 날짜 - 빨간 원 + 이벤트 밀착
                      selectedBuilder: (context, day, focusedDay) {
                        final events = _getEventsForDay(day);
                        return _buildDayCell(
                          day,
                          events,
                          rowHeight,
                          circleBg: AppColors.primary,
                          textColor: AppColors.white,
                        );
                      },
                      // 이전/다음 달 날짜
                      outsideBuilder: (context, day, focusedDay) {
                        return _buildDayCell(
                          day,
                          [],
                          rowHeight,
                          textColor: AppColors.gray300,
                        );
                      },
                      // markerBuilder 비활성 - defaultBuilder에서 직접 렌더
                      markerBuilder: (context, day, events) {
                        return const SizedBox.shrink();
                      },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      _showDayDetail(selectedDay);
                    },
                    onPageChanged: (focusedDay) {
                      setState(() => _focusedDay = focusedDay);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // FAB - 왼쪽 위 대각선으로 이동, 크기 확대
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 8),
        child: SizedBox(
          width: 68,
          height: 68,
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('/add-schedule'),
            backgroundColor: AppColors.primary,
            shape: const CircleBorder(),
            elevation: 4,
            child: const Icon(Icons.add, color: AppColors.white, size: 30),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}

class _DayDetailBottomSheet extends StatelessWidget {
  final DateTime day;
  final List<Map<String, dynamic>> events;
  final VoidCallback onAddSchedule;
  final VoidCallback onScheduleTap;

  const _DayDetailBottomSheet({
    required this.day,
    required this.events,
    required this.onAddSchedule,
    required this.onScheduleTap,
  });

  String _formatDayLabel(DateTime day) {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[day.weekday - 1];
    return '${day.month}월 ${day.day}일 $weekday요일';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDayLabel(day),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '일정 ${events.length}개',
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
                    GestureDetector(
                      onTap: onAddSchedule,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: events.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          bottom: MediaQuery.of(context).padding.bottom + 16,
                        ),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          final color = event['color'] as Color;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GestureDetector(
                              onTap: onScheduleTap,
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.07),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 3,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius:
                                            BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event['time'] as String? ??
                                                '종일',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: color,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            event['title'] as String,
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: AppColors.gray900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _buildAvatarStack(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: AppColors.gray200,
          ),
          SizedBox(height: 12),
          Text(
            '일정이 없어요',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 46,
      height: 28,
      child: Stack(
        children: [
          _buildAvatar(AppColors.primary, 0),
          _buildAvatar(AppColors.blue, 16),
        ],
      ),
    );
  }

  Widget _buildAvatar(Color color, double left) {
    return Positioned(
      left: left,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 1.5),
        ),
        child: Icon(Icons.person, size: 16, color: color),
      ),
    );
  }
}
