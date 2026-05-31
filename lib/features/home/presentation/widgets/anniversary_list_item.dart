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
    return Dismissible(
      key: ValueKey(anniversary.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: GiftoryColor.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
      ),
      child: Container(
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
                const Icon(Icons.notifications, color: GiftoryColor.moca400, size: 15),
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
      ),
    );
  }
}
