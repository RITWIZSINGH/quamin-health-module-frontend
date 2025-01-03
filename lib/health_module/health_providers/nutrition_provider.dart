import 'package:flutter/material.dart';
import '../health_models/nutrition_target.dart';
import '../health_models/meal.dart';

class NutritionProvider extends ChangeNotifier {
  NutritionTarget _target = NutritionTarget.defaultTarget();
  final List<Meal> _meals = [];

  NutritionTarget get target => _target;
  List<Meal> get meals => _meals;

  double get totalCalories {
    return _meals.fold(0, (sum, meal) {
      // 1g of fat = 9 calories, 1g of protein/carbs = 4 calories
      return sum + (meal.fat * 9) + (meal.protein * 4) + (meal.carbs * 4);
    });
  }

  double get caloriePercentage => totalCalories / _target.calorieTarget;

  double get fatPercentage => _meals.fold(0.0, (sum, meal) => sum + meal.fat) / _target.fatTarget;
  double get proteinPercentage => _meals.fold(0.0, (sum, meal) => sum + meal.protein) / _target.proteinTarget;
  double get carbsPercentage => _meals.fold(0.0, (sum, meal) => sum + meal.carbs) / _target.carbsTarget;

  void updateTarget(NutritionTarget newTarget) {
    _target = newTarget;
    notifyListeners();
  }

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }
}