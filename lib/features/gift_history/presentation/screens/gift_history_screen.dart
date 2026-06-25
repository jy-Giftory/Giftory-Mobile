import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/giftory_search_bar.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/presentation/providers/gift_history_provider.dart';
import 'package:giftory/features/gift_history/presentation/widgets/star_rating_widget.dart';

enum HistorySort {
  latest,
  oldest,
  priceHigh,
  priceLow,
  satisfaction,
}

extension HistorySortX on HistorySort {
  String get label {
    switch (this) {
      case HistorySort.latest: return '최신순';
      case HistorySort.oldest: return '오래된순';
      case HistorySort.priceHigh: return '높은가격';
      case HistorySort.priceLow: return '낮은가격';
      case HistorySort.satisfaction: return '만족도순';
    }
  }
}

class GiftHistoryScreen extends ConsumerStatefulWidget {
  const GiftHistoryScreen({super.key});

  @override
  ConsumerState<GiftHistoryScreen> createState() => _GiftHistoryScreenState();
}

class _GiftHistoryScreenState extends ConsumerState<GiftHistoryScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  HistorySort _sort = HistorySort.latest;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<GiftHistory> _applyFilter(List<GiftHistory> source) {
    var list = source;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((h) {
        return h.giftName.toLowerCase().contains(q) ||
            h.recipientName.toLowerCase().contains(q) ||
            (h.occasionLabel?.toLowerCase().contains(q) ?? false);
      }).toList();
    }
    final sorted = [...list];
    switch (_sort) {
      case HistorySort.latest:
        sorted.sort((a, b) => b.date.compareTo(a.date));
        break;
      case HistorySort.oldest:
        sorted.sort((a, b) => a.date.compareTo(b.date));
        break;
      case HistorySort.priceHigh:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case HistorySort.priceLow:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case HistorySort.satisfaction:
        sorted.sort((a, b) => b.satisfaction.compareTo(a.satisfaction));
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final asyncHistories = ref.watch(giftHistoryNotifierProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: asyncHistories.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (histories) {
            final filtered = _applyFilter(histories);
            return Column(
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
                            const SizedBox(height: 4),
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
                if (histories.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: GiftorySearchBar(
                      controller: _searchController,
                      hintText: '선물명, 받는 사람으로 검색',
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 32,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: HistorySort.values.length,
                      separatorBuilder: (_, i) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final option = HistorySort.values[i];
                        return GiftoryFilterChip(
                          label: option.label,
                          selected: _sort == option,
                          onTap: () => setState(() => _sort = option),
                        );
                      },
                    ),
                  ),
                ],
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
                      : filtered.isEmpty
                          ? Center(
                              child: Text(
                                '검색 결과가 없습니다.',
                                style: GiftoryTextStyle.body2
                                    .copyWith(color: GiftoryColor.gray400),
                              ),
                            )
                          : SingleChildScrollView(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 16, 20, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildAverageSatisfaction(context, filtered),
                                  const SizedBox(height: 16),
                                  ...filtered.map((h) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildAverageSatisfaction(
      BuildContext context, List<GiftHistory> histories) {
    final avg = histories.isEmpty
        ? 0.0
        : histories.map((h) => h.satisfaction).reduce((a, b) => a + b) /
            histories.length;
    return Row(
      children: [
        Text('평균 만족도',
            style: GiftoryTextStyle.small1
                .copyWith(color: GiftoryColor.gray600)),
        const SizedBox(width: 12),
        Icon(Icons.star_rounded, color: context.appColors.c600, size: 20),
        const SizedBox(width: 4),
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
            const SizedBox(height: 4),
            Text(
              '${history.recipientName}   ${history.formattedDate}'
              '${history.occasionLabel != null ? '   ${history.occasionLabel}' : ''}',
              style: GiftoryTextStyle.small1
                  .copyWith(color: GiftoryColor.gray500),
            ),
            const SizedBox(height: 6),
            StarRatingWidget(rating: history.satisfaction, size: 18),
            if (history.memo != null && history.memo!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                history.memo!,
                style: GiftoryTextStyle.small1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (history.purchaseLink != null &&
                history.purchaseLink!.isNotEmpty) ...[
              const SizedBox(height: 4),
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
