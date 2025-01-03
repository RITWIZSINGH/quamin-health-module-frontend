import 'dart:convert';
import 'package:quamin_health_module/health_module/health_models/meal.dart';
import 'package:quamin_health_module/health_module/health_models/nutrition_target.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _mealsKey = 'meals';
  static const String _targetKey = 'nutrition_target';

  // Save meals to local storage
  Future<void> saveMeals(List<Meal> meals) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = meals.map((meal) => meal.toJson()).toList();
    await prefs.setString(_mealsKey, jsonEncode(mealsJson));
  }

  // Load meals from local storage
  Future<List<Meal>> loadMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final mealsString = prefs.getString(_mealsKey);
    if (mealsString == null) return [];

    final mealsJson = jsonDecode(mealsString) as List;
    return mealsJson.map((json) => Meal.fromJson(json as Map<String, dynamic>)).toList();
  }

  // Save nutrition target
  Future<void> saveTarget(NutritionTarget target) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_targetKey, jsonEncode(target.toJson()));
  }

  // Load nutrition target
  Future<NutritionTarget?> loadTarget() async {
    final prefs = await SharedPreferences.getInstance();
    final targetString = prefs.getString(_targetKey);
    if (targetString == null) return null;

    final json = jsonDecode(targetString) as Map<String, dynamic>;
    return NutritionTarget.fromJson(json);
  }
}
