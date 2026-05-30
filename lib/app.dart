import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/router/app_router.dart';

class GiftoryApp extends StatelessWidget {
  const GiftoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Giftory',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        scaffoldBackgroundColor: GiftoryColor.background,
        fontFamily: 'LINESeedSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: GiftoryColor.moca700,
          surface: GiftoryColor.background,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: GiftoryColor.background,
          elevation: 0,
          titleTextStyle: GiftoryTextStyle.header2,
          iconTheme: const IconThemeData(color: GiftoryColor.moca950),
        ),
      ),
    );
  }
}
