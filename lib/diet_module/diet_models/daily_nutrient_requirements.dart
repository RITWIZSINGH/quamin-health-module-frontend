class DailyNutrientRequirements {
  final String recommendations;

  DailyNutrientRequirements({
    required this.recommendations,
  });

  factory DailyNutrientRequirements.fromJson(Map<String, dynamic> json) {
    return DailyNutrientRequirements(
      recommendations: json['recommendations'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendations': recommendations,
    };
  }
}