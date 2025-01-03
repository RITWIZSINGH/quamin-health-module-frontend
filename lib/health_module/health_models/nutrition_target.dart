class NutritionTarget {
  final double calorieTarget;
  final double fatTarget;
  final double proteinTarget;
  final double carbsTarget;

  NutritionTarget({
    required this.calorieTarget,
    required this.fatTarget,
    required this.proteinTarget,
    required this.carbsTarget,
  });

  factory NutritionTarget.defaultTarget() {
    return NutritionTarget(
      calorieTarget: 2000,
      fatTarget: 65,
      proteinTarget: 150,
      carbsTarget: 250,
    );
  }

  Map<String, dynamic> toJson() => {
    'calorieTarget': calorieTarget,
    'fatTarget': fatTarget,
    'proteinTarget': proteinTarget,
    'carbsTarget': carbsTarget,
  };

  factory NutritionTarget.fromJson(Map<String, dynamic> json) => NutritionTarget(
    calorieTarget: json['calorieTarget'] as double,
    fatTarget: json['fatTarget'] as double,
    proteinTarget: json['proteinTarget'] as double,
    carbsTarget: json['carbsTarget'] as double,
  );

  // Alias for toJson to match the provider's usage
  Map<String, dynamic> toMap() => toJson();

  // Alias for fromJson to match the provider's usage
  factory NutritionTarget.fromMap(Map<String, dynamic> map) => NutritionTarget.fromJson(map);
}