class Meal {
  final double fat;
  final double protein;
  final double carbs;
  final DateTime timestamp;

  Meal({
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'fat': fat,
    'protein': protein,
    'carbs': carbs,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    fat: json['fat'] as double,
    protein: json['protein'] as double,
    carbs: json['carbs'] as double,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}