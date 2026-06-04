import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';
import 'package:giftory/features/gift_recommendation/presentation/providers/gift_recommendation_provider.dart';
import 'package:giftory/features/gift_recommendation/presentation/widgets/gift_recommendation_card.dart';
import 'package:giftory/features/wishlist/presentation/providers/wishlist_provider.dart';

class GiftRecommendationResultScreen extends ConsumerWidget {
  const GiftRecommendationResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(giftRecommendationResultProvider);
    final wishlist = ref.watch(wishlistNotifierProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: resultAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('오류가 발생했습니다.',
                    style: GiftoryTextStyle.body2
                        .copyWith(color: GiftoryColor.gray500)),
                const SizedBox(height: 8),
                Text('$e',
                    style: GiftoryTextStyle.small1
                        .copyWith(color: GiftoryColor.gray400),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                GiftoryButton(
                  label: '다시 검색',
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
        data: (result) {
          if (result == null) {
            return const Center(child: Text('결과가 없습니다.'));
          }
          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context, result.subtitle),
                _buildSortTabs(ref, result.sortOption),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...result.sortedItems.map((item) =>
                            GiftRecommendationCard(
                              item: item,
                              isInWishlist: wishlist
                                  .any((w) => w.id == item.id),
                              onWishlistToggle: () => ref
                                  .read(wishlistNotifierProvider.notifier)
                                  .toggle(item),
                            )),
                        const SizedBox(height: 24),
                        _buildCongratsSection(result.congratsMessage),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(Icons.chevron_left,
                size: 24, color: GiftoryColor.moca950),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI 선물 추천', style: GiftoryTextStyle.header2),
                Text(subtitle,
                    style: GiftoryTextStyle.small1
                        .copyWith(color: GiftoryColor.gray500)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: GiftoryColor.moca700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('다시 검색',
                  style: GiftoryTextStyle.small1
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortTabs(WidgetRef ref, SortOption current) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: SortOption.values.map((option) {
          final selected = current == option;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => ref
                  .read(giftRecommendationResultProvider.notifier)
                  .updateSort(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: selected
                      ? GiftoryColor.moca700
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? GiftoryColor.moca700
                        : GiftoryColor.gray300,
                  ),
                ),
                child: Text(
                  option.label,
                  style: GiftoryTextStyle.small1.copyWith(
                    color: selected ? Colors.white : GiftoryColor.gray600,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCongratsSection(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('축하 메시지 초안',
            style: GiftoryTextStyle.body2
                .copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(
          '선물과 함께 전달할 메시지 초안 추천입니다.\n그대로 작성해 드리고, 직접 마음을 담아 메시지를 적어보세요.',
          style: GiftoryTextStyle.small1
              .copyWith(color: GiftoryColor.gray500),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: GiftoryColor.moca50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: GiftoryColor.moca100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: GiftoryTextStyle.small1),
              const SizedBox(height: 8),
              Text(
                '조안을 눌러 직접 작성해보세요',
                style: GiftoryTextStyle.small2
                    .copyWith(color: GiftoryColor.gray400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
