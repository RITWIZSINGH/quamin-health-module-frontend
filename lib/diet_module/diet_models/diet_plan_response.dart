
import 'package:quamin_health_module/diet_module/diet_models/daily_nutrient_requirements.dart';

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
        json['dailyNutrientRequirements'] as Map<String, dynamic>,
      ),
      summaryInHindi: json['summaryInHindi'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyNutrientRequirements': dailyNutrientRequirements.toJson(),
      'summaryInHindi': summaryInHindi,
    };
  }
}