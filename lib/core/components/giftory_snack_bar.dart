import 'package:flutter/material.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';

class GiftorySnackBar {
  GiftorySnackBar._();

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GiftoryTextStyle.small1.copyWith(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.appColors.c950,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          duration: duration,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        ),
      );
  }
}
