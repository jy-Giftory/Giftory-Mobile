import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final ValueChanged<int>? onChanged;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final filled = index < rating;
        final icon = GestureDetector(
          onTap: onChanged != null ? () => onChanged!(index + 1) : null,
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: filled ? GiftoryColor.moca600 : GiftoryColor.gray300,
            size: size,
          ),
        );
        return index < maxRating - 1
            ? Padding(padding: const EdgeInsets.only(right: 2), child: icon)
            : icon;
      }),
    );
  }
}
