enum DietPeriod {
  oneWeek,
  oneMonth,
  threeMonths,
  sixMonths;

  String get displayName {
    switch (this) {
      case DietPeriod.oneWeek:
        return '1 Week';
      case DietPeriod.oneMonth:
        return '1 Month';
      case DietPeriod.threeMonths:
        return '3 Months';
      case DietPeriod.sixMonths:
        return '6 Months';
    }
  }

  String get description {
    switch (this) {
      case DietPeriod.oneWeek:
        return 'Perfect for trying out a new diet';
      case DietPeriod.oneMonth:
        return 'Great for short-term goals';
      case DietPeriod.threeMonths:
        return 'Ideal for sustainable changes';
      case DietPeriod.sixMonths:
        return 'Best for long-term transformation';
    }
  }
}