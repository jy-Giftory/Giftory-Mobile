import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/presentation/providers/anniversary_provider.dart';
import 'package:giftory/features/home/presentation/screens/add_anniversary_screen.dart';
import 'package:giftory/features/home/presentation/widgets/anniversary_list_item.dart';
import 'package:giftory/features/home/presentation/widgets/home_calendar.dart';
import 'package:giftory/features/home/presentation/widgets/upcoming_anniversary_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedMonth = ref.watch(focusedMonthProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final asyncAnniversaries = ref.watch(anniversaryNotifierProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: asyncAnniversaries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류가 발생했습니다: $e')),
        data: (anniversaries) {
          final eventDays = _buildEventDays(anniversaries, focusedMonth);
          final selectedAnniversaries = anniversaries
              .where((a) => a.occursOn(selectedDay))
              .toList();
          final upcoming = [...anniversaries]
            ..sort((a, b) => a.dDay.compareTo(b.dDay));

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: HomeCalendar(
                      focusedMonth: focusedMonth,
                      selectedDay: selectedDay,
                      eventDays: eventDays,
                      onDaySelected: (day) {
                        ref.read(selectedDayProvider.notifier).select(day);
                      },
                      onPreviousMonth: () {
                        ref.read(focusedMonthProvider.notifier).previous();
                      },
                      onNextMonth: () {
                        ref.read(focusedMonthProvider.notifier).next();
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => _showAddAnniversary(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: GiftoryColor.moca700,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '기념일 추가',
                            style: GiftoryTextStyle.small2.copyWith(
                              color: GiftoryColor.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(
                      '기념일 삭제는 왼쪽으로 밀어서 삭제해주세요.',
                      style: GiftoryTextStyle.small3.copyWith(
                        color: GiftoryColor.gray400,
                      ),
                    ),
                  ),
                ),
                if (selectedAnniversaries.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          '해당 날짜에 기념일이 존재하지 않습니다.',
                          style: GiftoryTextStyle.body2.copyWith(
                            color: GiftoryColor.gray400,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AnniversaryListItem(
                            anniversary: selectedAnniversaries[index],
                            onDelete: () => ref
                                .read(anniversaryNotifierProvider.notifier)
                                .delete(selectedAnniversaries[index].id),
                          ),
                        ),
                        childCount: selectedAnniversaries.length,
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: _buildDots()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '곧 다가오는 기념일',
                          style: GiftoryTextStyle.header3,
                        ),
                        Text(
                          '(가장 가까운 날 기준으로 보여드립니다)',
                          style: GiftoryTextStyle.small2.copyWith(
                            color: GiftoryColor.gray400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (upcoming.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          '등록된 기념일이 없습니다.',
                          style: GiftoryTextStyle.body2.copyWith(
                            color: GiftoryColor.gray400,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: UpcomingAnniversaryItem(
                            anniversary: upcoming[index],
                          ),
                        ),
                        childCount: upcoming.length,
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: _buildDots()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
    );
  }

  Set<DateTime> _buildEventDays(
    List<Anniversary> anniversaries,
    DateTime focusedMonth,
  ) {
    final daysInMonth =
        DateTime(focusedMonth.year, focusedMonth.month + 1, 0).day;
    final eventDays = <DateTime>{};
    for (final ann in anniversaries) {
      for (int d = 1; d <= daysInMonth; d++) {
        final date = DateTime(focusedMonth.year, focusedMonth.month, d);
        if (ann.occursOn(date)) eventDays.add(date);
      }
    }
    return eventDays;
  }

  Widget _buildDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: GiftoryColor.moca400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddAnniversary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: const AddAnniversaryScreen(),
        ),
      ),
    );
  }
}
