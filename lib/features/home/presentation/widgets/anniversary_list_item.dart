import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';

class AnniversaryListItem extends StatelessWidget {
  final Anniversary anniversary;
  final VoidCallback? onDelete;

  const AnniversaryListItem({
    super.key,
    required this.anniversary,
    this.onDelete,
  });

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
          const SizedBox(width: 8),
          Row(
            children: [
              const Icon(Icons.notifications, color: GiftoryColor.moca400, size: 15,),
              const SizedBox(width: 4),
              Text(
                anniversary.repeatLabel,
                style: GiftoryTextStyle.small1.copyWith(
                  color: GiftoryColor.moca400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
