import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:intl/intl.dart';

class HomeCalendar extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDay;
  final Set<DateTime> eventDays;
  final ValueChanged<DateTime> onDaySelected;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const HomeCalendar({
    super.key,
    required this.focusedMonth,
    required this.selectedDay,
    required this.eventDays,
    required this.onDaySelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        _buildDayHeaders(),
        const SizedBox(height: 4),
        _buildGrid(),
      ],
    );
  }

  Widget _buildHeader() {
    final label = DateFormat('yyyy년 M월').format(focusedMonth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, size: 18),
          onPressed: onPreviousMonth,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: GiftoryColor.gray700,
        ),
        const SizedBox(width: 8),
        Text(label, style: GiftoryTextStyle.header2),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.chevron_right, size: 18),
          onPressed: onNextMonth,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: GiftoryColor.gray700,
        ),
      ],
    );
  }

  Widget _buildDayHeaders() {
    const headers = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      children: headers.asMap().entries.map((entry) {
        final i = entry.key;
        final h = entry.value;
        Color color = GiftoryColor.gray600;
        if (i == 0) color = GiftoryColor.red;
        if (i == 6) color = GiftoryColor.blue;
        return Expanded(
          child: Center(
            child: Text(
              h,
              style: GiftoryTextStyle.small1.copyWith(color: color),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGrid() {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month, 1);
    final lastDay = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);
    final startOffset = firstDay.weekday % 7; // 0=Sun
    final totalCells = startOffset + lastDay.day;
    final rows = (totalCells / 7).ceil();

    final today = DateTime.now();
    final todayNorm = DateTime(today.year, today.month, today.day);

    return Column(
      children: List.generate(rows, (row) {
        return Row(
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final day = cellIndex - startOffset + 1;
            if (day < 1 || day > lastDay.day) {
              return const Expanded(child: SizedBox(height: 36));
            }

            final date = DateTime(focusedMonth.year, focusedMonth.month, day);
            final isSelected = date == DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
            final isToday = date == todayNorm;
            final hasEvent = eventDays.contains(date);

            Color textColor = GiftoryColor.moca950;
            if (col == 0) textColor = GiftoryColor.red;
            if (col == 6) textColor = GiftoryColor.blue;

            Widget dayWidget = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? GiftoryColor.moca700
                        : isToday
                            ? GiftoryColor.moca200
                            : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: GiftoryTextStyle.small1.copyWith(
                      color: isSelected
                          ? Colors.white
                          : textColor,
                      fontWeight: isSelected || isToday
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasEvent ? GiftoryColor.moca500 : Colors.transparent,
                  ),
                ),
              ],
            );

            return Expanded(
              child: GestureDetector(
                onTap: () => onDaySelected(date),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Center(child: dayWidget),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
