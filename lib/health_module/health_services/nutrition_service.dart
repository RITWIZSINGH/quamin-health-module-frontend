import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quamin_health_module/health_module/health_providers/nutrition_provider.dart';
import '../health_models/daily_nutrition.dart';

class NutritionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> saveDailyNutrition(DailyNutrition nutrition) async {
    final date = DateTime.now().toIso8601String().split('T')[0];
    
    await _firestore.collection('nutrition_history').add({
      'date': date,
      'calories': nutrition.calories,
      'fat': nutrition.fat,
      'protein': nutrition.protein,
      'carbs': nutrition.carbs,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> resetDailyValues(NutritionProvider provider) async {
    // Save current values before reset
    final dailyNutrition = DailyNutrition(
      calories: provider.totalCalories,
      fat: provider.totalFat,
      protein: provider.totalProtein,
      carbs: provider.totalCarbs,
    );
    
    await saveDailyNutrition(dailyNutrition);
    
    // Reset values
    provider.resetDaily();
  }

  Stream<DateTime> getDayEndStream() {
    return Stream.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      return now;
    }).where((dateTime) {
      // Check if it's the end of the day (23:59)
      return dateTime.hour == 23 && dateTime.minute == 59;
    });
  }
}