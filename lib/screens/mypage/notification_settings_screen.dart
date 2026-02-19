import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/back_header.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _pushEnabled = true;
  bool _scheduleEnabled = true;
  bool _diaryEnabled = true;
  bool _marketingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackHeader(
              title: '알림 설정',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchItem(
                    '푸시 알림',
                    '모든 알림을 받습니다',
                    _pushEnabled,
                    (val) => setState(() => _pushEnabled = val),
                  ),
                  const Divider(color: AppColors.gray100, height: 1),
                  _buildSwitchItem(
                    '일정 알림',
                    '일정 시작 전 알림을 받습니다',
                    _scheduleEnabled,
                    (val) => setState(() => _scheduleEnabled = val),
                  ),
                  const Divider(color: AppColors.gray100, height: 1),
                  _buildSwitchItem(
                    '일기 알림',
                    '새 일기가 작성되면 알림을 받습니다',
                    _diaryEnabled,
                    (val) => setState(() => _diaryEnabled = val),
                  ),
                  const Divider(color: AppColors.gray100, height: 1),
                  _buildSwitchItem(
                    '마케팅 알림',
                    '이벤트 및 마케팅 정보를 받습니다',
                    _marketingEnabled,
                    (val) => setState(() => _marketingEnabled = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    height: 1.21,
                    letterSpacing: 0,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
