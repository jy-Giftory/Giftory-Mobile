enum AgeGroup {
  teens,
  twenties,
  thirties,
  forties,
  fiftyPlus,
}

extension AgeGroupX on AgeGroup {
  String get label {
    switch (this) {
      case AgeGroup.teens:     return '10대';
      case AgeGroup.twenties:  return '20대';
      case AgeGroup.thirties:  return '30대';
      case AgeGroup.forties:   return '40대';
      case AgeGroup.fiftyPlus: return '50대 이상';
    }
  }
}
