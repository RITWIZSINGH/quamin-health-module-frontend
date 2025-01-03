import 'package:flutter/material.dart';
import '../health_models/nutrition_target.dart';
import '../health_models/meal.dart';
import '../health_services/nutrition_service.dart';

class NutritionProvider extends ChangeNotifier {
  final NutritionService _nutritionService = NutritionService();
  NutritionTarget _target = NutritionTarget.defaultTarget();
  final List<Meal> _meals = [];

  NutritionProvider() {
    _initializeDayEndListener();
  }

  void _initializeDayEndListener() {
    _nutritionService.getDayEndStream().listen((_) {
      _nutritionService.resetDailyValues(this);
    });
  }

  NutritionTarget get target => _target;
  List<Meal> get meals => _meals;

  double get totalCalories {
    return _meals.fold(0, (sum, meal) {
      return sum + (meal.fat * 9) + (meal.protein * 4) + (meal.carbs * 4);
    });
  }

  double get totalFat => _meals.fold(0.0, (sum, meal) => sum + meal.fat);
  double get totalProtein => _meals.fold(0.0, (sum, meal) => sum + meal.protein);
  double get totalCarbs => _meals.fold(0.0, (sum, meal) => sum + meal.carbs);

  double get caloriePercentage => totalCalories / _target.calorieTarget;
  double get fatPercentage => totalFat / _target.fatTarget;
  double get proteinPercentage => totalProtein / _target.proteinTarget;
  double get carbsPercentage => totalCarbs / _target.carbsTarget;

  void updateTarget(NutritionTarget newTarget) {
    _target = newTarget;
    notifyListeners();
  }

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void resetDaily() {
    _meals.clear();
    notifyListeners();
  }
}