import 'package:giftory/features/home/domain/entities/repeat_type.dart';

class Anniversary {
  final String id;
  final String title;
  final DateTime originalDate;
  final RepeatType repeatType;

  const Anniversary({
    required this.id,
    required this.title,
    required this.originalDate,
    required this.repeatType,
  });

  DateTime get nextOccurrence {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    switch (repeatType) {
      case RepeatType.yearly:
        DateTime candidate = DateTime(today.year, originalDate.month, originalDate.day);
        if (candidate.isBefore(today)) {
          candidate = DateTime(today.year + 1, originalDate.month, originalDate.day);
        }
        return candidate;

      case RepeatType.monthly:
        DateTime candidate = DateTime(today.year, today.month, originalDate.day);
        if (candidate.isBefore(today)) {
          candidate = DateTime(today.year, today.month + 1, originalDate.day);
        }
        return candidate;

      case RepeatType.biMonthly:
        DateTime candidate = DateTime(originalDate.year, originalDate.month, originalDate.day);
        while (candidate.isBefore(today)) {
          candidate = DateTime(candidate.year, candidate.month + 2, candidate.day);
        }
        return candidate;
    }
  }

  int get dDay {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return nextOccurrence.difference(today).inDays;
  }

  String get dDayLabel {
    final d = dDay;
    if (d == 0) return 'D-Day';
    return 'D-$d';
  }

  String get repeatLabel => repeatType.repeatLabel(originalDate.day);

  bool occursOn(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    switch (repeatType) {
      case RepeatType.yearly:
        return d.month == originalDate.month && d.day == originalDate.day;
      case RepeatType.monthly:
        return d.day == originalDate.day;
      case RepeatType.biMonthly:
        if (d.day != originalDate.day) return false;
        final monthsDiff =
            (d.year - originalDate.year) * 12 + (d.month - originalDate.month);
        return monthsDiff >= 0 && monthsDiff % 2 == 0;
    }
  }

  Anniversary copyWith({
    String? id,
    String? title,
    DateTime? originalDate,
    RepeatType? repeatType,
  }) {
    return Anniversary(
      id: id ?? this.id,
      title: title ?? this.title,
      originalDate: originalDate ?? this.originalDate,
      repeatType: repeatType ?? this.repeatType,
    );
  }
}
