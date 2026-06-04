import 'package:go_router/go_router.dart';
import 'package:giftory/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:giftory/features/auth/presentation/screens/login_screen.dart';
import 'package:giftory/features/auth/presentation/screens/register_screen.dart';
import 'package:giftory/features/home/presentation/screens/home_screen.dart';
import 'package:giftory/features/gift_recommendation/presentation/screens/gift_recommendation_input_screen.dart';
import 'package:giftory/features/gift_recommendation/presentation/screens/gift_recommendation_result_screen.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/presentation/screens/gift_history_screen.dart';
import 'package:giftory/features/gift_history/presentation/screens/add_gift_history_screen.dart';
import 'package:giftory/features/gift_history/presentation/screens/gift_history_detail_screen.dart';
import 'package:giftory/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:giftory/features/settings/presentation/screens/settings_screen.dart';
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
          builder: (context, state) => const GiftRecommendationInputScreen(),
          routes: [
            GoRoute(
              path: 'result',
              builder: (context, state) =>
                  const GiftRecommendationResultScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/gift-history',
          builder: (context, state) => const GiftHistoryScreen(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) {
                final extra =
                    state.extra as Map<String, dynamic>?;
                return AddGiftHistoryScreen(
                  prefillGiftName: extra?['giftName'] as String?,
                  prefillPrice: extra?['price'] as int?,
                );
              },
            ),
            GoRoute(
              path: 'detail',
              builder: (context, state) {
                final history = state.extra as GiftHistory;
                return GiftHistoryDetailScreen(history: history);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
