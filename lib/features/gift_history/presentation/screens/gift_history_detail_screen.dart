import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/presentation/providers/gift_history_provider.dart';
import 'package:giftory/features/gift_history/presentation/widgets/star_rating_widget.dart';

class GiftHistoryDetailScreen extends ConsumerWidget {
  final GiftHistory history;
  const GiftHistoryDetailScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.chevron_left,
                        size: 24, color: GiftoryColor.moca950),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('히스토리', style: GiftoryTextStyle.header2),
                      Text(
                        '주었던 선물과 반응을 기록하세요.',
                        style: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(history.giftName,
                              style: GiftoryTextStyle.header1,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ),
                        Text(history.formattedPrice,
                            style: GiftoryTextStyle.header1),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${history.recipientName}   ${history.formattedDate}'
                      '${history.occasionLabel != null ? '   ${history.occasionLabel}' : ''}',
                      style: GiftoryTextStyle.small1
                          .copyWith(color: GiftoryColor.gray500),
                    ),
                    const SizedBox(height: 8),
                    StarRatingWidget(rating: history.satisfaction, size: 22),
                    if (history.memo != null && history.memo!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(history.memo!, style: GiftoryTextStyle.body2),
                    ],
                    if (history.purchaseLink != null &&
                        history.purchaseLink!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        history.purchaseLink!,
                        style: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray500),
                      ),
                    ],
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('기록 삭제'),
                            content: const Text('이 기록을 삭제하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('삭제'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          ref
                              .read(giftHistoryNotifierProvider.notifier)
                              .delete(history.id);
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      },
                      child: Text(
                        '기록 삭제',
                        style: GiftoryTextStyle.small1.copyWith(
                          color: GiftoryColor.red,
                          decoration: TextDecoration.underline,
                          decorationColor: GiftoryColor.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
