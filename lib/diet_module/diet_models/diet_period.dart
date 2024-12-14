enum DietPeriod {
  threemonths,
  sixmonths,
  twelvemonths;

  String get displayName {
    switch (this) {
      case DietPeriod.threemonths:
        return '3 Months';
      case DietPeriod.sixmonths:
        return '6 Months';
      case DietPeriod.twelvemonths:
        return '12 Months';
    }
  }

  static DietPeriod fromJson(String value) {
    return DietPeriod.values.firstWhere(
      (element) => element.toString().split('.').last == value,
    );
  }

  String toJson() => toString().split('.').last;
}