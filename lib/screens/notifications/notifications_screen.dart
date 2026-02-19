import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/center_title_header.dart';
import '../../widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'emoji': '📅',
        'groupName': '일정 알림',
        'message': '내일 영화 데이트 일정이 있어요',
        'time': '방금 전',
        'isRead': false,
      },
      {
        'emoji': '📔',
        'groupName': '우리 커플 다이어리',
        'message': '상대방이 새 일기를 작성했어요',
        'time': '1시간 전',
        'isRead': false,
      },
      {
        'emoji': '✅',
        'groupName': '투두리스트',
        'message': '투두리스트 항목이 완료됐어요',
        'time': '2시간 전',
        'isRead': true,
      },
      {
        'emoji': '💕',
        'groupName': '기념일 알림',
        'message': '오늘은 기념일이에요! 축하해요',
        'time': '어제',
        'isRead': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            CenterTitleHeader(
              title: '알림',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Text(
                        '새로운 알림이 없어요',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.gray400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final n = notifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: NotificationItem(
                            emoji: n['emoji'] as String,
                            groupName: n['groupName'] as String,
                            message: n['message'] as String,
                            time: n['time'] as String,
                            isRead: n['isRead'] as bool,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
