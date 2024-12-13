import 'dart:convert';

class DietPlanResponse {
  final DailyNutrientRequirements dailyNutrientRequirements;
  final String summaryInHindi;

  DietPlanResponse({
    required this.dailyNutrientRequirements,
    required this.summaryInHindi,
  });

  factory DietPlanResponse.fromJson(Map<String, dynamic> json) {
    return DietPlanResponse(
      dailyNutrientRequirements: DailyNutrientRequirements.fromJson(
        json['daily_nutrient_requirements']['recommendations'],
      ),
      summaryInHindi: json['summary_in_hindi'],
    );
  }
}

class DailyNutrientRequirements {
  final String recommendations;

  DailyNutrientRequirements({required this.recommendations});

  factory DailyNutrientRequirements.fromJson(String recommendations) {
    return DailyNutrientRequirements(recommendations: recommendations);
  }
}