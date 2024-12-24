import 'package:flutter/foundation.dart';
import '../services/health_service.dart';
import 'package:health/health.dart';
class HealthProvider extends ChangeNotifier {
  final _healthService = HealthService();
  
  int _steps = 0;
  int _calories = 0;
  double _distance = 0;
  int _activeMinutes = 0;
  Map<DateTime, int> _weeklySteps = {};
  bool _isLoading = true;

  int get steps => _steps;
  int get calories => _calories;
  double get distance => _distance;
  int get activeMinutes => _activeMinutes;
  Map<DateTime, int> get weeklySteps => _weeklySteps;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _healthService.requestPermissions();
      await fetchTodayData();
      await fetchWeeklyData();
    } catch (e) {
      debugPrint('Error initializing health data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTodayData() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    
    _steps = await _healthService.getSteps(midnight, now);
    
    final healthData = await _healthService.getHealthData(midnight, now);
    
    for (final dataPoint in healthData) {
      switch (dataPoint.type) {
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          _calories += (dataPoint.value as double).round();
          break;
        case HealthDataType.DISTANCE_WALKING_RUNNING:
          _distance += dataPoint.value as double;
          break;
        default:
          break;
      }
    }
    
    notifyListeners();
  }

  Future<void> fetchWeeklyData() async {
    _weeklySteps = await _healthService.getWeeklySteps();
    notifyListeners();
  }
}