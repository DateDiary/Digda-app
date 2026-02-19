import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/primary_button.dart';

class TermsAgreementScreen extends StatefulWidget {
  const TermsAgreementScreen({super.key});

  @override
  State<TermsAgreementScreen> createState() => _TermsAgreementScreenState();
}

class _TermsAgreementScreenState extends State<TermsAgreementScreen> {
  bool _checkAll = false;
  List<bool> _checks = [false, false, false, false, false];

  bool get _allRequiredChecked => _checks[0] && _checks[1] && _checks[2];

  void _toggleAll(bool? value) {
    setState(() {
      _checkAll = value ?? false;
      _checks = List.filled(5, _checkAll);
    });
  }

  void _toggleItem(int index, bool? value) {
    setState(() {
      _checks[index] = value ?? false;
      _checkAll = _checks.every((e) => e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                '서비스 이용을 위해',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.21,
                  letterSpacing: 0,
                  color: AppColors.gray900,
                ),
              ),
              const Text(
                '약관에 동의해주세요',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.21,
                  letterSpacing: 0,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 32),
              _buildCheckAll(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 1,
                color: AppColors.gray100,
              ),
              _buildCheckItem(0, '이용약관 동의', true),
              const SizedBox(height: 12),
              _buildCheckItem(1, '개인정보 수집 및 이용 동의', true),
              const SizedBox(height: 12),
              _buildCheckItem(2, '만 14세 이상입니다', true),
              const SizedBox(height: 12),
              _buildCheckItem(3, '마케팅 정보 수신 동의', false),
              const SizedBox(height: 12),
              _buildCheckItem(4, '푸시 알림 수신 동의', false),
              const Spacer(),
              Center(
                child: PrimaryButton(
                  text: '동의하고 시작하기',
                  onPressed: _allRequiredChecked
                      ? () => Navigator.of(context).pushReplacementNamed('/home')
                      : null,
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckAll() {
    return GestureDetector(
      onTap: () => _toggleAll(!_checkAll),
      child: Row(
        children: [
          Icon(
            _checkAll ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 24,
            color: _checkAll ? AppColors.primary : AppColors.gray300,
          ),
          const SizedBox(width: 12),
          const Text(
            '전체 동의',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.21,
              letterSpacing: 0,
              color: AppColors.gray900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(int index, String label, bool isRequired) {
    return GestureDetector(
      onTap: () => _toggleItem(index, !_checks[index]),
      child: Row(
        children: [
          Icon(
            _checks[index] ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
            color: _checks[index] ? AppColors.primary : AppColors.gray300,
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isRequired
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.gray100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isRequired ? '필수' : '선택',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.21,
                letterSpacing: 0,
                color: isRequired ? AppColors.primary : AppColors.gray500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.21,
                letterSpacing: 0,
                color: AppColors.gray900,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.gray400),
        ],
      ),
    );
  }
}
