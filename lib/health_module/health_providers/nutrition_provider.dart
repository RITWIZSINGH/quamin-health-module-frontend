import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_services/nutrition_services/nutrition_service.dart';
import 'package:quamin_health_module/health_module/health_services/nutrition_services/nutrition_storing_service.dart';
import '../health_models/nutrition_target.dart';
import '../health_models/meal.dart';

class NutritionProvider extends ChangeNotifier {
  final NutritionService _nutritionService = NutritionService();
  final LocalStorageService _localStorage = LocalStorageService();
  NutritionTarget _target = NutritionTarget.defaultTarget();
  final List<Meal> _meals = [];

  NutritionProvider() {
    _initializeData();
    _initializeDayEndListener();
  }

  Future<void> _initializeData() async {
    final savedTarget = await _localStorage.loadTarget();
    if (savedTarget != null) {
      _target = savedTarget;
    }
    final savedMeals = await _localStorage.loadMeals();
    _meals.addAll(savedMeals);
    notifyListeners();
  }

  void _initializeDayEndListener() {
    _nutritionService.getDayEndStream().listen((_) {
      resetDaily();
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

  Future<void> updateTarget(NutritionTarget newTarget) async {
    _target = newTarget;
    await _localStorage.saveTarget(newTarget);
    notifyListeners();
  }

  Future<void> addMeal(Meal meal) async {
    _meals.add(meal);
    await _localStorage.saveMeals(_meals);
    notifyListeners();
  }

  Future<void> resetDaily() async {
    _meals.clear();
    await _localStorage.saveMeals(_meals);
    notifyListeners();
  }
}