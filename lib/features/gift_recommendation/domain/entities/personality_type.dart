enum PersonalityType {
  practical,
  emotional,
  active,
  trendy,
  unknown,
}

extension PersonalityTypeX on PersonalityType {
  String get label {
    switch (this) {
      case PersonalityType.practical: return '실용적';
      case PersonalityType.emotional: return '감성적';
      case PersonalityType.active:    return '활동적';
      case PersonalityType.trendy:    return '트렌디';
      case PersonalityType.unknown:   return '잘 모르겠음';
    }
  }
}
