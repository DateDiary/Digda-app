import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class _Schedule {
  final String title;
  final Color color;
  final DateTime start;
  final DateTime end;
  final String? time;
  final bool isHoliday;

  const _Schedule({
    required this.title,
    required this.color,
    required this.start,
    DateTime? end,
    this.time,
    this.isHoliday = false,
  }) : end = end ?? start;

  bool get isMultiDay =>
      start.year != end.year ||
      start.month != end.month ||
      start.day != end.day;

  bool coversDay(DateTime day) {
    final d = DateTime.utc(day.year, day.month, day.day);
    final s = DateTime.utc(start.year, start.month, start.day);
    final e = DateTime.utc(end.year, end.month, end.day);
    return !d.isBefore(s) && !d.isAfter(e);
  }

  bool isStartDay(DateTime day) => isSameDay(start, day);
  bool isEndDay(DateTime day) => isSameDay(end, day);
}

class ScheduleCalendarScreen extends StatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  State<ScheduleCalendarScreen> createState() =>
      _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 일정 데이터 — start/end로 다일 이벤트 지원
  final List<_Schedule> _schedules = [
    _Schedule(
      title: '야근',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 1),
    ),
    _Schedule(
      title: '야근',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 5),
    ),
    _Schedule(
      title: '출근 일찍',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 7),
    ),
    _Schedule(
      title: '카페로 데이트',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 7),
    ),
    _Schedule(
      title: '야근',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 8),
      time: '종일',
    ),
    _Schedule(
      title: '출근 늦게',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 8),
      time: '오후 2:00 - 5:00',
    ),
    _Schedule(
      title: '출근 늦게',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 14),
    ),
    // 설날연휴 — 3일 연결
    _Schedule(
      title: '설날연휴',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 16),
      end: DateTime.utc(2026, 2, 18),
      isHoliday: true,
    ),
    _Schedule(
      title: '영화보기',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 18),
    ),
    _Schedule(
      title: '야근',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 20),
    ),
    // 출장 — 2일
    _Schedule(
      title: '제주 출장',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 22),
      end: DateTime.utc(2026, 2, 23),
    ),
    _Schedule(
      title: '야근',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 26),
    ),
    _Schedule(
      title: '출근 일찍',
      color: AppColors.primary,
      start: DateTime.utc(2026, 2, 28),
    ),
    _Schedule(
      title: '부랄 저녁',
      color: AppColors.purple,
      start: DateTime.utc(2026, 2, 28),
    ),
    _Schedule(
      title: '삼일절',
      color: AppColors.eventHoliday,
      start: DateTime.utc(2026, 3, 1),
      end: DateTime.utc(2026, 3, 2),
      isHoliday: true,
    ),
  ];

  /// 해당 날짜에 걸치는 모든 일정
  List<_Schedule> _getSchedulesForDay(DateTime day) {
    return _schedules.where((s) => s.coversDay(day)).toList();
  }

  /// 사용자 일정만 (공휴일 제외)
  List<_Schedule> _getUserSchedulesForDay(DateTime day) {
    return _getSchedulesForDay(day).where((s) => !s.isHoliday).toList();
  }

  /// eventLoader용 (TableCalendar에 전달)
  List<dynamic> _eventLoader(DateTime day) {
    return _getSchedulesForDay(day);
  }

  void _showMonthPicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030, 12, 31),
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
      setState(() {
        _focusedDay = picked;
        _selectedDay = null;
      });
    }
  }

  void _showDayDetail(DateTime day) {
    final userSchedules = _getUserSchedulesForDay(day);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DayDetailBottomSheet(
        day: day,
        schedules: userSchedules,
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
    double rowHeight, {
    Color? circleBg,
    required Color textColor,
    bool isOutside = false,
  }) {
    final schedules = isOutside ? <_Schedule>[] : _getSchedulesForDay(day);

    return SizedBox(
      height: rowHeight,
      child: Column(
        children: [
          const SizedBox(height: 4),
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
          const SizedBox(height: 2),
          ...schedules.take(2).map((s) => _buildEventPill(day, s)),
        ],
      ),
    );
  }

  Widget _buildEventPill(DateTime day, _Schedule schedule) {
    final color = schedule.color;
    final isStart = schedule.isStartDay(day);
    final isEnd = schedule.isEndDay(day);
    final isMulti = schedule.isMultiDay;

    // 단일 일정 — 둥근 pill
    if (!isMulti) {
      return Container(
        height: 14,
        margin: const EdgeInsets.only(top: 1, left: 2, right: 2),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          schedule.title,
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
    }

    // 다일 일정 — 연결 바
    final isRowStart = day.weekday == DateTime.sunday;
    final isRowEnd = day.weekday == DateTime.saturday;

    final roundLeft = isStart || isRowStart;
    final roundRight = isEnd || isRowEnd;
    final showText = isStart || (isRowStart && !isEnd);

    return Container(
      height: 14,
      margin: EdgeInsets.only(
        top: 1,
        left: roundLeft ? 2 : 0,
        right: roundRight ? 2 : 0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.horizontal(
          left: roundLeft ? const Radius.circular(4) : Radius.zero,
          right: roundRight ? const Radius.circular(4) : Radius.zero,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: showText
          ? Text(
              schedule.title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 8,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          : null,
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
                  GestureDetector(
                    onTap: () => _showMonthPicker(),
                    child: Row(
                      children: [
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
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: AppColors.gray500,
                        ),
                      ],
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
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),
                    eventLoader: _eventLoader,
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
                      cellMargin: EdgeInsets.zero,
                      cellPadding: EdgeInsets.zero,
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
                      defaultBuilder: (context, day, focusedDay) {
                        final isWeekend =
                            day.weekday == DateTime.saturday ||
                            day.weekday == DateTime.sunday;
                        return _buildDayCell(
                          day,
                          rowHeight,
                          textColor: isWeekend
                              ? AppColors.primary
                              : AppColors.gray900,
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return _buildDayCell(
                          day,
                          rowHeight,
                          circleBg: AppColors.black,
                          textColor: AppColors.white,
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return _buildDayCell(
                          day,
                          rowHeight,
                          circleBg: AppColors.primary,
                          textColor: AppColors.white,
                        );
                      },
                      outsideBuilder: (context, day, focusedDay) {
                        return _buildDayCell(
                          day,
                          rowHeight,
                          textColor: AppColors.gray300,
                          isOutside: true,
                        );
                      },
                      markerBuilder: (context, day, events) {
                        return const SizedBox.shrink();
                      },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      final allSchedules = _getSchedulesForDay(selectedDay);
                      final userSchedules =
                          _getUserSchedulesForDay(selectedDay);
                      if (userSchedules.isNotEmpty || allSchedules.isEmpty) {
                        _showDayDetail(selectedDay);
                      } else {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) setState(() => _selectedDay = null);
                        });
                      }
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 20),
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
  final List<_Schedule> schedules;
  final VoidCallback onAddSchedule;
  final VoidCallback onScheduleTap;

  const _DayDetailBottomSheet({
    required this.day,
    required this.schedules,
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
      initialChildSize: 0.85,
      minChildSize: 0.5,
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
                          '일정 ${schedules.length}개',
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
                child: schedules.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          bottom:
                              MediaQuery.of(context).padding.bottom + 16,
                        ),
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
                          final color = schedule.color;
                          // 다일 일정이면 날짜 범위 표시
                          String timeText = schedule.time ?? '종일';
                          if (schedule.isMultiDay) {
                            timeText =
                                '${schedule.start.month}/${schedule.start.day} - ${schedule.end.month}/${schedule.end.day}';
                          }
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
                                            timeText,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: color,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            schedule.title,
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
