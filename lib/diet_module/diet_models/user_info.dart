class UserInfo {
  final int age;
  final double weight;
  final double height;
  final String symptoms;
  final String medicalConditions;
  final String activityLevel;
  final String dietaryPreferences;
  final String preferredCuisine;
  final String sleepPattern;
  final String stressLevel;

  UserInfo({
    required this.age,
    required this.weight,
    required this.height,
    required this.symptoms,
    required this.medicalConditions,
    required this.activityLevel,
    required this.dietaryPreferences,
    required this.preferredCuisine,
    required this.sleepPattern,
    required this.stressLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'weight': weight,
      'height': height,
      'symptoms': symptoms,
      'medical_conditions': medicalConditions,
      'activity_level': activityLevel,
      'dietary_preferences': dietaryPreferences,
      'preferred_cuisine': preferredCuisine,
      'sleep_pattern': sleepPattern,
      'stress_level': stressLevel,
    };
  }
}