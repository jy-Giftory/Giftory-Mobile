import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/recommendation_record.dart';
import 'package:giftory/features/gift_recommendation/presentation/widgets/congrats_message_section.dart';
import 'package:giftory/features/gift_recommendation/presentation/widgets/gift_recommendation_card.dart';
import 'package:giftory/features/wishlist/presentation/providers/wishlist_provider.dart';

class RecommendationHistoryDetailScreen extends ConsumerWidget {
  final RecommendationRecord record;
  const RecommendationHistoryDetailScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistNotifierProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.chevron_left,
                        size: 24, color: context.appColors.c950),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.recipient.isEmpty
                              ? 'AI 선물 추천'
                              : '${record.recipient}님을 위한 추천',
                          style: GiftoryTextStyle.header2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          record.formattedDate,
                          style: GiftoryTextStyle.small1
                              .copyWith(color: GiftoryColor.gray500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...record.items.map((item) => GiftRecommendationCard(
                          item: item,
                          isInWishlist: wishlist.any((w) =>
                              w.title == item.title && w.price == item.price),
                          onWishlistToggle: () => ref
                              .read(wishlistNotifierProvider.notifier)
                              .toggleByContent(item),
                        )),
                    if (record.congratsMessage.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      CongratsMessageSection(
                        message: record.congratsMessage,
                        onSaved: (_) {},
                      ),
                    ],
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
