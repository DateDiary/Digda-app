import 'package:flutter/material.dart';
import '../theme/colors.dart';

class TodoItem extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final String? completedDate;
  final VoidCallback? onToggle;

  const TodoItem({
    super.key,
    required this.text,
    this.isCompleted = false,
    this.completedDate,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 345,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray100, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 22,
              color: isCompleted ? AppColors.blue : AppColors.gray300,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.21,
                      letterSpacing: 0,
                      color: isCompleted ? AppColors.gray400 : AppColors.gray900,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (isCompleted && completedDate != null)
                    Text(
                      completedDate!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        height: 1.21,
                        letterSpacing: 0,
                        color: AppColors.gray200,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
