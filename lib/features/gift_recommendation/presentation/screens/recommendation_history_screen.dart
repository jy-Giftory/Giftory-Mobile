import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/recommendation_record.dart';
import 'package:giftory/features/gift_recommendation/presentation/providers/recommendation_history_provider.dart';

class RecommendationHistoryScreen extends ConsumerWidget {
  const RecommendationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(recommendationHistoryNotifierProvider);

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
                    child: Icon(Icons.chevron_left,
                        size: 24, color: context.appColors.c950),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('지난 추천 목록', style: GiftoryTextStyle.header2),
                      Text(
                        'AI가 추천했던 선물들을 다시 확인하세요.',
                        style: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: recordsAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    '추천 기록을 불러오지 못했습니다.',
                    style: GiftoryTextStyle.body2
                        .copyWith(color: GiftoryColor.gray400),
                  ),
                ),
                data: (records) => records.isEmpty
                    ? Center(
                        child: Text(
                          '아직 추천 받은 기록이 없습니다.',
                          style: GiftoryTextStyle.body2
                              .copyWith(color: GiftoryColor.gray400),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        itemCount: records.length,
                        separatorBuilder: (_, i) =>
                            const SizedBox(height: 12),
                        itemBuilder: (_, index) => _RecordCard(
                          record: records[index],
                          onTap: () => context.push(
                            '/gift-recommend/history/detail',
                            extra: records[index],
                          ),
                          onDelete: () => ref
                              .read(recommendationHistoryNotifierProvider
                                  .notifier)
                              .remove(records[index].id),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final RecommendationRecord record;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _RecordCard({
    required this.record,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      resizeDuration: null,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: GiftoryColor.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
      ),
      child: GestureDetector(
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
                    child: Text(
                      record.recipient.isEmpty
                          ? 'AI 선물 추천'
                          : '${record.recipient}님을 위한 추천',
                      style: GiftoryTextStyle.body2
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.appColors.c100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${record.items.length}개',
                      style: GiftoryTextStyle.small2.copyWith(
                        color: context.appColors.c800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                record.summary,
                style: GiftoryTextStyle.small1
                    .copyWith(color: GiftoryColor.gray600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                record.formattedDate,
                style: GiftoryTextStyle.small2
                    .copyWith(color: GiftoryColor.gray400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
