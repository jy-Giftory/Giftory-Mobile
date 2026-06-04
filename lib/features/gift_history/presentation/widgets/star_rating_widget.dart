import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/core/theme/app_theme.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final ValueChanged<int>? onChanged;

  StarRatingWidget({
    super.key,
    required int rating,
    int maxRating = 5,
    this.size = 24,
    this.onChanged,
  })  : maxRating = math.max(0, maxRating),
        rating = rating.clamp(0, math.max(0, maxRating));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final filled = index < rating;
        final icon = onChanged != null
            ? IconButton(
                onPressed: () => onChanged!(index + 1),
                icon: Icon(
                  filled ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: filled ? context.appColors.c600 : GiftoryColor.gray300,
                  size: size,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            : Icon(
                filled ? Icons.star_rounded : Icons.star_outline_rounded,
                color: filled ? context.appColors.c600 : GiftoryColor.gray300,
                size: size,
              );
        return index < maxRating - 1
            ? Padding(padding: const EdgeInsets.only(right: 2), child: icon)
            : icon;
      }),
    );
  }
}
