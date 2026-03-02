import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ScheduleDetailScreen extends StatefulWidget {
  const ScheduleDetailScreen({super.key});

  @override
  State<ScheduleDetailScreen> createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  bool _showMenu = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onEditTap() {
    setState(() => _showMenu = false);
    Navigator.of(context).pushNamed('/add-schedule');
  }

  void _onDeleteTap() {
    setState(() => _showMenu = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 14,
                          color: AppColors.gray900,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _showMenu = !_showMenu),
                        child: const Icon(
                          Icons.more_horiz,
                          size: 22,
                          color: AppColors.gray700,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        // Profile avatar
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Schedule title (colored)
                        const Text(
                          '출근 늦게',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.purple,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Date
                        const Text(
                          '2026년 2월 8일 (월)',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Info rows
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                icon: Icons.notifications_outlined,
                                text: '1일 전에 알림이 도착합니다.',
                              ),
                              const SizedBox(height: 20),
                              _buildInfoRow(
                                icon: Icons.calendar_today_outlined,
                                text: '모임',
                              ),
                              const SizedBox(height: 20),
                              _buildInfoRow(
                                icon: Icons.label_outline,
                                text: '소프트 바이올렛',
                              ),
                              const SizedBox(height: 20),
                              // Participants row
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline,
                                      size: 20,
                                      color: AppColors.gray400,
                                    ),
                                    const SizedBox(width: 14),
                                    // Avatars
                                    _buildParticipantAvatars(),
                                    const Spacer(),
                                    const Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: AppColors.gray400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        // Timeline
                        _buildTimeline(),
                        const SizedBox(height: 24),
                        // Comments
                        _buildComments(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Dropdown menu overlay
            if (_showMenu) ...[
              GestureDetector(
                onTap: () => setState(() => _showMenu = false),
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                top: 44,
                right: 20,
                child: _buildDropdownMenu(),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.gray400),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: AppColors.gray800,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantAvatars() {
    final colors = [AppColors.primary, AppColors.blue, AppColors.green];
    return SizedBox(
      width: 72,
      height: 32,
      child: Stack(
        children: List.generate(
          colors.length,
          (i) => Positioned(
            left: i * 20.0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colors[i].withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              child: Icon(Icons.person, size: 18, color: colors[i]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        // Dashed divider
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: List.generate(
              40,
              (i) => Expanded(
                child: Container(
                  height: 1,
                  color: i.isEven ? AppColors.gray200 : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '2026. 2. 10. (화)',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.gray400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            const Text(
              '일정을 등록했습니다',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColors.gray500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: List.generate(
              40,
              (i) => Expanded(
                child: Container(
                  height: 1,
                  color: i.isEven ? AppColors.gray200 : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '댓글 2개',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 16),
          _buildCommentItem(
            avatarColor: AppColors.blue,
            name: '지수',
            time: '오후 3:12',
            content: '나도 같게! 장소 어디야?',
          ),
          const SizedBox(height: 14),
          _buildCommentItem(
            avatarColor: AppColors.green,
            name: '민호',
            time: '오후 4:05',
            content: '좋아 나도 참석! 🙌',
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem({
    required Color avatarColor,
    required String name,
    required String time,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: avatarColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, size: 18, color: avatarColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownMenu() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _onEditTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: const [
                  Icon(Icons.edit_outlined, size: 16, color: AppColors.gray700),
                  SizedBox(width: 8),
                  Text(
                    '편집',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: AppColors.gray100),
          GestureDetector(
            onTap: _onDeleteTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: const [
                  Icon(Icons.delete_outline, size: 16, color: AppColors.primaryDark),
                  SizedBox(width: 8),
                  Text(
                    '삭제',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray100, width: 1)),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: bottomPadding + 10,
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite_border, size: 22, color: AppColors.gray400),
          const SizedBox(width: 16),
          const Icon(Icons.person_outline, size: 22, color: AppColors.gray400),
          const SizedBox(width: 16),
          const Icon(Icons.image_outlined, size: 22, color: AppColors.gray400),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: _commentController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  color: AppColors.gray900,
                ),
                decoration: const InputDecoration(
                  hintText: '댓글',
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: AppColors.gray400,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.sentiment_satisfied_alt_outlined,
              size: 22, color: AppColors.gray400),
        ],
      ),
    );
  }
}
