import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';
import 'package:giftory/features/auth/presentation/providers/auth_provider.dart';
import 'package:giftory/features/settings/domain/entities/app_settings.dart';
import 'package:giftory/features/settings/presentation/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final notifier = ref.read(settingsNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('설정', style: GiftoryTextStyle.header1),
                    const SizedBox(height: 4),
                    Text('알림 및 앱 환경을 설정하세요.',
                        style: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray500)),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(Icons.notifications_outlined,
                            color: GiftoryColor.moca700, size: 20),
                        const SizedBox(width: 6),
                        Text('알림 설정',
                            style: GiftoryTextStyle.body2
                                .copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: GiftoryColor.moca50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline,
                              size: 14, color: GiftoryColor.moca600),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '기념일 1주일 전 알림 (필수): 중요한 기념일을 놓치지 않기 위해 1주일 전에 미리 알려드립니다.',
                              style: GiftoryTextStyle.small1
                                  .copyWith(color: GiftoryColor.moca700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildToggleRow(
                      '한 달 전 알림',
                      settings.notifyMonthBefore,
                      (v) => notifier.update(
                          settings.copyWith(notifyMonthBefore: v)),
                    ),
                    _buildToggleRow(
                      '2주 전 알림',
                      settings.notifyTwoWeeksBefore,
                      (v) => notifier.update(
                          settings.copyWith(notifyTwoWeeksBefore: v)),
                    ),
                    _buildToggleRow(
                      '하루 전 알림',
                      settings.notifyDayBefore,
                      (v) => notifier.update(
                          settings.copyWith(notifyDayBefore: v)),
                    ),
                    _buildToggleRow(
                      '당일 알림',
                      settings.notifyOnDay,
                      (v) => notifier
                          .update(settings.copyWith(notifyOnDay: v)),
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      '이메일 알림 받기',
                      settings.emailNotification,
                      (v) => notifier.update(
                          settings.copyWith(emailNotification: v)),
                      subtitle:
                          '이메일 알림은 기본적으로 해지되어 있으며 선택 시 활성화 됩니다.',
                    ),
                    const SizedBox(height: 24),
                    Text('테마 변경',
                        style: GiftoryTextStyle.body2
                            .copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _ThemeCard(
                          label: 'MOCA',
                          color: GiftoryColor.moca600,
                          isSelected: settings.themeType == ThemeType.moca,
                          onTap: () => notifier.update(
                              settings.copyWith(themeType: ThemeType.moca)),
                        ),
                        const SizedBox(width: 12),
                        _ThemeCard(
                          label: 'OLIVE',
                          color: GiftoryColor.olive500,
                          isSelected: settings.themeType == ThemeType.olive,
                          onTap: () => notifier.update(
                              settings.copyWith(themeType: ThemeType.olive)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: GiftoryButton(label: '저장하기', onPressed: () {}),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, MediaQuery.of(context).padding.bottom + 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _showLogoutDialog(context, ref),
                    child: Text(
                      '로그아웃',
                      style: GiftoryTextStyle.small1
                          .copyWith(color: GiftoryColor.gray500),
                    ),
                  ),
                  Text('|',
                      style: GiftoryTextStyle.small1
                          .copyWith(color: GiftoryColor.gray300)),
                  TextButton(
                    onPressed: () => _showWithdrawalDialog(context, ref),
                    child: Text(
                      '회원탈퇴',
                      style: GiftoryTextStyle.small1
                          .copyWith(color: GiftoryColor.red),
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

  Widget _buildToggleRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged, {
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GiftoryTextStyle.small1),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GiftoryTextStyle.small2
                        .copyWith(color: GiftoryColor.gray400),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: GiftoryColor.moca700,
            activeTrackColor: GiftoryColor.moca300,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GiftoryColor.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('로그아웃', style: GiftoryTextStyle.header2),
        content: Text('로그아웃 하시겠습니까?',
            style: GiftoryTextStyle.body2
                .copyWith(color: GiftoryColor.gray600)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('취소',
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.gray500)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(authNotifierProvider.notifier).logout();
              context.go('/onboarding');
            },
            child: Text('확인',
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.moca700,
                        fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showWithdrawalDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: GiftoryColor.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('회원탈퇴', style: GiftoryTextStyle.header2),
        content: Text(
          '탈퇴 시 모든 데이터가 삭제되며\n복구가 불가능합니다.\n정말 탈퇴하시겠습니까?',
          style: GiftoryTextStyle.body2
              .copyWith(color: GiftoryColor.gray600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('취소',
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.gray500)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(authNotifierProvider.notifier).logout();
              context.go('/onboarding');
            },
            child: Text('탈퇴하기',
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.red,
                        fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: GiftoryColor.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? GiftoryColor.moca700 : GiftoryColor.gray200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: GiftoryTextStyle.small1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? GiftoryColor.moca700
                      : GiftoryColor.gray500,
                )),
          ],
        ),
      ),
    );
  }
}
