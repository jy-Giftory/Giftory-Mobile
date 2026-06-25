enum OccasionType {
  hundredDays,
  oneYear,
  birthday,
  parentsDay,
  custom,
}

extension OccasionTypeX on OccasionType {
  String get label {
    switch (this) {
      case OccasionType.hundredDays: return '100일';
      case OccasionType.oneYear:     return '1주년';
      case OccasionType.birthday:    return '생일';
      case OccasionType.parentsDay:  return '어버이날';
      case OccasionType.custom:      return '직접입력';
    }
  }
}
