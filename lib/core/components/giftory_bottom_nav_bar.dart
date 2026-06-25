import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';

class GiftoryBottomNavBar extends StatelessWidget {
  final Widget child;

  const GiftoryBottomNavBar({super.key, required this.child});

  static const _tabs = [
    _NavTab(icon: Icons.card_giftcard_outlined, label: '선물추천', path: '/gift-recommend'),
    _NavTab(icon: Icons.history_outlined, label: '선물내역', path: '/gift-history'),
    _NavTab(icon: Icons.home_outlined, label: '홈', path: '/home'),
    _NavTab(icon: Icons.favorite_outline, label: '위시리스트', path: '/wishlist'),
    _NavTab(icon: Icons.person_outline, label: '설정', path: '/settings'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _tabs.indexWhere((t) => location == t.path || location.startsWith('${t.path}/'));
    return index == -1 ? 2 : index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: GiftoryColor.gray100)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 56,
            child: Row(
              children: _tabs.asMap().entries.map((entry) {
                final i = entry.key;
                final tab = entry.value;
                final isActive = i == currentIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => context.go(tab.path),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab.icon,
                          size: 22,
                          color: isActive ? context.appColors.c700 : GiftoryColor.gray400,
                        ),
                        SizedBox(height: 2),
                        Text(
                          tab.label,
                          style: GiftoryTextStyle.small2.copyWith(
                            color: isActive ? context.appColors.c700 : GiftoryColor.gray400,
                            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab {
  final IconData icon;
  final String label;
  final String path;
  const _NavTab({required this.icon, required this.label, required this.path});
}
