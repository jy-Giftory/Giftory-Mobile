enum RepeatType {
  yearly,
  monthly,
  biMonthly,
}

extension RepeatTypeX on RepeatType {
  String get label {
    switch (this) {
      case RepeatType.yearly:
        return '매년 반복';
      case RepeatType.monthly:
        return '매달 반복';
      case RepeatType.biMonthly:
        return '두 달마다 반복';
    }
  }

  String repeatLabel(int day) {
    switch (this) {
      case RepeatType.yearly:
        return '매년 $day일마다 반복';
      case RepeatType.monthly:
        return '매달 $day일마다 반복';
      case RepeatType.biMonthly:
        return '두 달마다 $day일마다 반복';
    }
  }
}