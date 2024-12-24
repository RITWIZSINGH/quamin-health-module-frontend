import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  final health = HealthFactory(useHealthConnectIfAvailable: true);
  
  static final HealthService _instance = HealthService._internal();
  
  factory HealthService() {
    return _instance;
  }
  
  HealthService._internal();

  Future<bool> requestPermissions() async {
    await Permission.activityRecognition.request();
    
    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    return await health.requestAuthorization(types);
  }

  Future<int> getSteps(DateTime start, DateTime end) async {
    final steps = await health.getTotalStepsInInterval(start, end);
    return steps ?? 0;
  }

  Future<List<HealthDataPoint>> getHealthData(DateTime start, DateTime end) async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    return await health.getHealthDataFromTypes(start, end, types);
  }

  Future<Map<DateTime, int>> getWeeklySteps() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));
    
    final steps = <DateTime, int>{};
    
    for (var i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final dayEnd = day.add(const Duration(days: 1));
      final daySteps = await getSteps(day, dayEnd);
      steps[day] = daySteps;
    }
    
    return steps;
  }
}