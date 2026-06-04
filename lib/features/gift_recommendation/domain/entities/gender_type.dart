enum GenderType {
  female,
  male,
}

extension GenderTypeX on GenderType {
  String get label {
    switch (this) {
      case GenderType.female: return '여성';
      case GenderType.male:   return '남성';
    }
  }
}
