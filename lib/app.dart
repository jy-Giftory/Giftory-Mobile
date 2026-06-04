import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/router/app_router.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/settings/domain/entities/app_settings.dart';
import 'package:giftory/features/settings/presentation/providers/settings_provider.dart';

class GiftoryApp extends ConsumerWidget {
  const GiftoryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final themeColors = settings.themeType == ThemeType.moca
        ? GiftoryThemeColors.moca
        : GiftoryThemeColors.olive;

    return MaterialApp.router(
      title: 'Giftory',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        scaffoldBackgroundColor: GiftoryColor.background,
        fontFamily: 'LINESeedSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeColors.c700,
          surface: GiftoryColor.background,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: GiftoryColor.background,
          elevation: 0,
          titleTextStyle: GiftoryTextStyle.header2,
          iconTheme: IconThemeData(color: themeColors.c950),
        ),
        extensions: [themeColors],
      ),
    );
  }
}
