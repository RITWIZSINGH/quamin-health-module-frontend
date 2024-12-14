import 'daily_nutrient_requirements.dart';

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
        json['daily_nutrient_requirements'] as Map<String, dynamic>,
      ),
      summaryInHindi: json['summary_in_hindi'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily_nutrient_requirements': dailyNutrientRequirements.toJson(),
      'summary_in_hindi': summaryInHindi,
    };
  }
}