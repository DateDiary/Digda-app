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
    {'text': '데이트 장소 예약하기', 'isCompleted': false, 'completedDate': null},
    {'text': '기념일 선물 준비', 'isCompleted': false, 'completedDate': null},
    {'text': '여행 계획 세우기', 'isCompleted': true, 'completedDate': '2.10 완료'},
    {'text': '같이 볼 영화 고르기', 'isCompleted': true, 'completedDate': '2.08 완료'},
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
        todo['completedDate'] = '${now.month}.${now.day.toString().padLeft(2, '0')} 완료';
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
    final pending = _todos.where((t) => !(t['isCompleted'] as bool)).toList();
    final completed = _todos.where((t) => t['isCompleted'] as bool).toList();

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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  if (pending.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        '할 일 (${pending.length})',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          height: 1.21,
                          letterSpacing: 0,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),
                    ...pending.map((todo) {
                      final index = _todos.indexOf(todo);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TodoItem(
                          text: todo['text'] as String,
                          isCompleted: todo['isCompleted'] as bool,
                          completedDate: todo['completedDate'] as String?,
                          onToggle: () => _toggleTodo(index),
                        ),
                      );
                    }),
                  ],
                  if (completed.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        '완료 (${completed.length})',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          height: 1.21,
                          letterSpacing: 0,
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
                          isCompleted: todo['isCompleted'] as bool,
                          completedDate: todo['completedDate'] as String?,
                          onToggle: () => _toggleTodo(index),
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  void _showAddTodoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _addController,
                autofocus: true,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColors.gray900,
                ),
                decoration: InputDecoration(
                  hintText: '새 할 일 추가',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppColors.gray300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.gray200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) {
                  _addTodo();
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                _addTodo();
                Navigator.of(context).pop();
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
