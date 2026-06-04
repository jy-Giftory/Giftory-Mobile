import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';

@immutable
class GiftoryThemeColors extends ThemeExtension<GiftoryThemeColors> {
  const GiftoryThemeColors({
    required this.c50,
    required this.c100,
    required this.c200,
    required this.c300,
    required this.c400,
    required this.c500,
    required this.c600,
    required this.c700,
    required this.c800,
    required this.c900,
    required this.c950,
  });

  final Color c50;
  final Color c100;
  final Color c200;
  final Color c300;
  final Color c400;
  final Color c500;
  final Color c600;
  final Color c700;
  final Color c800;
  final Color c900;
  final Color c950;

  static const GiftoryThemeColors moca = GiftoryThemeColors(
    c50: GiftoryColor.moca50,
    c100: GiftoryColor.moca100,
    c200: GiftoryColor.moca200,
    c300: GiftoryColor.moca300,
    c400: GiftoryColor.moca400,
    c500: GiftoryColor.moca500,
    c600: GiftoryColor.moca600,
    c700: GiftoryColor.moca700,
    c800: GiftoryColor.moca800,
    c900: GiftoryColor.moca900,
    c950: GiftoryColor.moca950,
  );

  static const GiftoryThemeColors olive = GiftoryThemeColors(
    c50: GiftoryColor.olive50,
    c100: GiftoryColor.olive100,
    c200: GiftoryColor.olive200,
    c300: GiftoryColor.olive300,
    c400: GiftoryColor.olive400,
    c500: GiftoryColor.olive500,
    c600: GiftoryColor.olive600,
    c700: GiftoryColor.olive700,
    c800: GiftoryColor.olive800,
    c900: GiftoryColor.olive900,
    c950: GiftoryColor.olive950,
  );

  @override
  GiftoryThemeColors copyWith({
    Color? c50, Color? c100, Color? c200, Color? c300, Color? c400,
    Color? c500, Color? c600, Color? c700, Color? c800, Color? c900,
    Color? c950,
  }) =>
      GiftoryThemeColors(
        c50: c50 ?? this.c50, c100: c100 ?? this.c100,
        c200: c200 ?? this.c200, c300: c300 ?? this.c300,
        c400: c400 ?? this.c400, c500: c500 ?? this.c500,
        c600: c600 ?? this.c600, c700: c700 ?? this.c700,
        c800: c800 ?? this.c800, c900: c900 ?? this.c900,
        c950: c950 ?? this.c950,
      );

  @override
  GiftoryThemeColors lerp(ThemeExtension<GiftoryThemeColors>? other, double t) {
    if (other is! GiftoryThemeColors) return this;
    return GiftoryThemeColors(
      c50: Color.lerp(c50, other.c50, t)!,
      c100: Color.lerp(c100, other.c100, t)!,
      c200: Color.lerp(c200, other.c200, t)!,
      c300: Color.lerp(c300, other.c300, t)!,
      c400: Color.lerp(c400, other.c400, t)!,
      c500: Color.lerp(c500, other.c500, t)!,
      c600: Color.lerp(c600, other.c600, t)!,
      c700: Color.lerp(c700, other.c700, t)!,
      c800: Color.lerp(c800, other.c800, t)!,
      c900: Color.lerp(c900, other.c900, t)!,
      c950: Color.lerp(c950, other.c950, t)!,
    );
  }
}

extension GiftoryThemeX on BuildContext {
  GiftoryThemeColors get appColors =>
      Theme.of(this).extension<GiftoryThemeColors>() ?? GiftoryThemeColors.moca;
}
