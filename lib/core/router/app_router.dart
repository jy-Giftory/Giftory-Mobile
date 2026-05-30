import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:giftory/features/auth/presentation/screens/login_screen.dart';
import 'package:giftory/features/auth/presentation/screens/register_screen.dart';
import 'package:giftory/features/home/presentation/screens/home_screen.dart';
import 'package:giftory/core/components/giftory_bottom_nav_bar.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => GiftoryBottomNavBar(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/gift-recommend',
          builder: (context, state) => const _PlaceholderScreen(label: '선물추천'),
        ),
        GoRoute(
          path: '/gift-history',
          builder: (context, state) => const _PlaceholderScreen(label: '선물내역'),
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const _PlaceholderScreen(label: '위시리스트'),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const _PlaceholderScreen(label: '설정'),
        ),
      ],
    ),
  ],
);

class _PlaceholderScreen extends StatelessWidget {
  final String label;
  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(label)),
    );
  }
}
