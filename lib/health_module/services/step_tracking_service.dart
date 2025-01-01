import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepTrackingService {
  static final StepTrackingService _instance = StepTrackingService._internal();
  factory StepTrackingService() => _instance;
  StepTrackingService._internal();

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  final _stepController = StreamController<int>.broadcast();
  final _statusController = StreamController<String>.broadcast();

  Stream<int> get stepStream => _stepController.stream;
  Stream<String> get statusStream => _statusController.stream;

  int _steps = 0;
  String _status = 'unknown';
  int _goal = 10000; // Default goal

  int get currentSteps => _steps;
  String get currentStatus => _status;
  int get currentGoal => _goal;

  Future<void> initialize() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      throw Exception('Activity recognition permission not granted');
    }

    await _loadGoal();
    _initPedometer();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    _goal = prefs.getInt('step_goal') ?? 10000;
  }

  Future<void> setGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('step_goal', goal);
    _goal = goal;
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    if (await Permission.activityRecognition.isGranted) return true;
    final status = await Permission.activityRecognition.request();
    return status.isGranted;
  }

  void _initPedometer() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream = Pedometer.stepCountStream;

    _pedestrianStatusStream.listen(
      (PedestrianStatus event) {
        _status = event.status;
        _statusController.add(_status);
      },
      onError: (error) {
        _status = 'not available';
        _statusController.add(_status);
      },
    );

    _stepCountStream.listen(
      (StepCount event) {
        _steps = event.steps;
        _stepController.add(_steps);
      },
      onError: (error) {
        _steps = 0;
        _stepController.add(_steps);
      },
    );
  }

  double calculateProgress() {
    return _steps / _goal;
  }

  double calculateMiles() {
    return (2.2 * _steps) / 5280;
  }

  double calculateDuration() {
    return (_steps * 1 / 1000);
  }

  double calculateCalories() {
    return (_steps * 0.0566);
  }

  void dispose() {
    _stepController.close();
    _statusController.close();
  }
}