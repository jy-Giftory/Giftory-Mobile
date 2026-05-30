import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';

class UpcomingAnniversaryItem extends StatelessWidget {
  final Anniversary anniversary;

  const UpcomingAnniversaryItem({super.key, required this.anniversary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: GiftoryColor.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GiftoryColor.gray100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              anniversary.title,
              style: GiftoryTextStyle.body2,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: GiftoryColor.moca100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              anniversary.dDayLabel,
              style: GiftoryTextStyle.small1.copyWith(
                color: GiftoryColor.moca800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
