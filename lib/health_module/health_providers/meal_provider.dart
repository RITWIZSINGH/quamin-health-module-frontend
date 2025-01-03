import 'package:flutter/foundation.dart';
import '../health_models/meal.dart';

class MealProvider extends ChangeNotifier {
  final List<Meal> _meals = [];
  
  List<Meal> get meals => List.unmodifiable(_meals);
  
  double get totalFat => _meals.fold(0, (sum, meal) => sum + meal.fat);
  double get totalProtein => _meals.fold(0, (sum, meal) => sum + meal.protein);
  double get totalCarbs => _meals.fold(0, (sum, meal) => sum + meal.carbs);
  
  double get fatPercentage => totalFat / 65; // Based on 65g daily value
  double get proteinPercentage => totalProtein / 50; // Based on 50g daily value
  double get carbsPercentage => totalCarbs / 300; // Based on 300g daily value
  
  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }
  
  void clearMeals() {
    _meals.clear();
    notifyListeners();
  }
}