import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/presentation/screens/add_anniversary_screen.dart';

class AnniversaryListItem extends StatelessWidget {
  final Anniversary anniversary;
  final VoidCallback? onDelete;

  const AnniversaryListItem({
    super.key,
    required this.anniversary,
    this.onDelete,
  });

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ClipRRect(
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
          child: AddAnniversaryScreen(initial: anniversary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(anniversary.id),
      direction: DismissDirection.endToStart,
      resizeDuration: null,
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
      child: GestureDetector(
        onTap: () => _showEditSheet(context),
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
                child: Text(anniversary.title, style: GiftoryTextStyle.body2),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Icon(Icons.notifications,
                      color: context.appColors.c400, size: 15),
                  const SizedBox(width: 4),
                  Text(
                    anniversary.repeatLabel,
                    style: GiftoryTextStyle.small1
                        .copyWith(color: context.appColors.c400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
