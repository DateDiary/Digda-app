import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Map<String, dynamic>> _todos = [
    {'text': '다음 모임 장소 정하기', 'isCompleted': false, 'completedDate': null},
    {'text': '회비 걷기', 'isCompleted': false, 'completedDate': null},
    {'text': '단체 사진 공유하기', 'isCompleted': false, 'completedDate': null},
    {'text': '생일 선물 아이디어 모으기', 'isCompleted': false, 'completedDate': null},
    {'text': '날짜 정하기', 'isCompleted': true, 'completedDate': '2월 5일 완료'},
    {'text': '인원 확인하기', 'isCompleted': true, 'completedDate': '2월 3일 완료'},
    {'text': '그룹방 만들기', 'isCompleted': true, 'completedDate': '1월 26일 완료'},
  ];

  final TextEditingController _addController = TextEditingController();

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }

  void _toggleTodo(int index) {
    setState(() {
      final todo = _todos[index];
      todo['isCompleted'] = !(todo['isCompleted'] as bool);
      if (todo['isCompleted'] as bool) {
        final now = DateTime.now();
        todo['completedDate'] =
            '${now.month}월 ${now.day}일 완료';
      } else {
        todo['completedDate'] = null;
      }
    });
  }

  void _addTodo() {
    final text = _addController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _todos.insert(0, {
        'text': text,
        'isCompleted': false,
        'completedDate': null,
      });
      _addController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pending =
        _todos.where((t) => !(t['isCompleted'] as bool)).toList();
    final completed =
        _todos.where((t) => t['isCompleted'] as bool).toList();
    final total = _todos.length;
    final completedCount = completed.length;
    final progress = total > 0 ? completedCount / total : 0.0;
    final progressPct = (progress * 100).round();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CenterTitleHeader(
              title: '투두리스트',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  // 진행률 카드
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    decoration: BoxDecoration(
                      color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '진행률',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.gray700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '$total개 중 $completedCount개 완료',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.gray500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$progressPct%',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                color: AppColors.gray900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor: AppColors.gray200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 할 일 섹션
                  if (pending.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8),
                      child: Text(
                        '할 일',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.gray700,
                        ),
                      ),
                    ),
                    ...pending.map((todo) {
                      final index = _todos.indexOf(todo);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TodoItem(
                          text: todo['text'] as String,
                          isCompleted: false,
                          onToggle: () => _toggleTodo(index),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                  // 완료 섹션
                  if (completed.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 8),
                      child: Text(
                        '완료 ($completedCount)',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.gray400,
                        ),
                      ),
                    ),
                    ...completed.map((todo) {
                      final index = _todos.indexOf(todo);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TodoItem(
                          text: todo['text'] as String,
                          isCompleted: true,
                          completedDate: todo['completedDate'] as String?,
                          onToggle: () => _toggleTodo(index),
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // 하단 입력 바
            Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.gray100)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.gray100),
                      ),
                      child: TextField(
                        controller: _addController,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.gray900,
                        ),
                        decoration: const InputDecoration(
                          hintText: '할 일을 입력하세요',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.gray400,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12),
                        ),
                        onSubmitted: (_) => _addTodo(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _addTodo,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        '추가',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
