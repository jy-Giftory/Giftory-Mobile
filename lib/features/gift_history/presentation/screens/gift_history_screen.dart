import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/presentation/providers/gift_history_provider.dart';
import 'package:giftory/features/gift_history/presentation/widgets/star_rating_widget.dart';
import 'package:giftory/core/theme/app_theme.dart';

class GiftHistoryScreen extends ConsumerWidget {
  const GiftHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHistories = ref.watch(giftHistoryNotifierProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: asyncHistories.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (histories) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('히스토리', style: GiftoryTextStyle.header1),
                          SizedBox(height: 4),
                          Text(
                            '주었던 선물과 반응을 기록하세요.',
                            style: GiftoryTextStyle.small1
                                .copyWith(color: GiftoryColor.gray500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/gift-history/add'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: context.appColors.c700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '기록하기',
                          style: GiftoryTextStyle.small1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: histories.isEmpty
                    ? Center(
                        child: Text(
                          '아직 기록이 없습니다.\n새로운 기록을 시작하세요.',
                          style: GiftoryTextStyle.body2
                              .copyWith(color: GiftoryColor.gray400),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAverageSatisfaction(context, histories),
                            SizedBox(height: 16),
                            ...histories.map((h) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _HistoryCard(
                                    history: h,
                                    onTap: () => context.push(
                                        '/gift-history/detail',
                                        extra: h),
                                  ),
                                )),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAverageSatisfaction(BuildContext context, List<GiftHistory> histories) {
    final avg = histories.isEmpty
        ? 0.0
        : histories.map((h) => h.satisfaction).reduce((a, b) => a + b) /
            histories.length;
    return Row(
      children: [
        Text('평균 만족도', style: GiftoryTextStyle.small1
            .copyWith(color: GiftoryColor.gray600)),
        SizedBox(width: 12),
        Icon(Icons.star_rounded, color: context.appColors.c600, size: 20),
        SizedBox(width: 4),
        Text(
          '${avg.toStringAsFixed(1)} /5.0',
          style: GiftoryTextStyle.small1.copyWith(
            fontWeight: FontWeight.w700,
            color: context.appColors.c700,
          ),
        ),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final GiftHistory history;
  final VoidCallback onTap;

  const _HistoryCard({required this.history, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GiftoryColor.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GiftoryColor.gray100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(history.giftName,
                      style: GiftoryTextStyle.body2
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ),
                Text(history.formattedPrice,
                    style: GiftoryTextStyle.body2
                        .copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 4),
            Text(
              '${history.recipientName}   ${history.formattedDate}'
              '${history.occasionLabel != null ? '   ${history.occasionLabel}' : ''}',
              style: GiftoryTextStyle.small1
                  .copyWith(color: GiftoryColor.gray500),
            ),
            SizedBox(height: 6),
            StarRatingWidget(rating: history.satisfaction, size: 18),
            if (history.memo != null && history.memo!.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(
                history.memo!,
                style: GiftoryTextStyle.small1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (history.purchaseLink != null &&
                history.purchaseLink!.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(
                history.purchaseLink!,
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.gray500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
