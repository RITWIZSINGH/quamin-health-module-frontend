class NutritionTarget {
  final double calorieTarget;
  final double fatTarget;
  final double proteinTarget;
  final double carbsTarget;

  const NutritionTarget({
    required this.calorieTarget,
    required this.fatTarget,
    required this.proteinTarget,
    required this.carbsTarget,
  });

  factory NutritionTarget.defaultTarget() {
    return const NutritionTarget(
      calorieTarget: 2000,
      fatTarget: 65,
      proteinTarget: 50,
      carbsTarget: 300,
    );
  }
}