import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  DateTime _lastResetDate = DateTime.now();
  Timer? _midnightTimer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int get currentSteps => _steps;
  String get currentStatus => _status;
  int get currentGoal => _goal;

  Future<void> initialize() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      throw Exception('Activity recognition permission not granted');
    }

    await _loadGoal();
    await _loadLastResetDate();
    _initPedometer();
    _setupMidnightReset();
  }

  Future<void> _loadLastResetDate() async {
    final prefs = await SharedPreferences.getInstance();
    String? dateStr = prefs.getString('last_reset_date');
    if (dateStr != null) {
      _lastResetDate = DateTime.parse(dateStr);
    }
  }

  Future<void> _saveLastResetDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_reset_date', _lastResetDate.toIso8601String());
  }

  void _setupMidnightReset() {
    // Cancel existing timer if any
    _midnightTimer?.cancel();

    // Calculate time until next midnight
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final timeUntilMidnight = tomorrow.difference(now);

    // Set timer for midnight
    _midnightTimer = Timer(timeUntilMidnight, () {
      _handleDayEnd();
      // Setup next day's timer
      _setupMidnightReset();
    });
  }

  Future<void> _handleDayEnd() async {
    // Store steps in Firestore
    await _storeStepsInFirestore();

    // Reset steps
    _steps = 0;
    _stepController.add(_steps);

    // Update last reset date
    _lastResetDate = DateTime.now();
    await _saveLastResetDate();
  }

  Future<void> _storeStepsInFirestore() async {
    try {
      final date = DateTime.now();
      final dateStr =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      await _firestore.collection('steps').doc(dateStr).set({
        'date': dateStr,
        'steps': _steps,
        'goal': _goal,
        'goalAchieved': _steps >= _goal,
        'timestamp': FieldValue.serverTimestamp(),
        'metrics': {
          'miles': calculateMiles(),
          'duration': calculateDuration(),
          'calories': calculateCalories(),
        }
      });
    } catch (e) {
      print('Error storing steps in Firestore: $e');
    }
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
        // Check if we need to reset steps (in case app was not running at midnight)
        final now = DateTime.now();
        if (now.day != _lastResetDate.day ||
            now.month != _lastResetDate.month ||
            now.year != _lastResetDate.year) {
          _handleDayEnd();
        }

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
    return (_steps * 6 / 1000);
  }

  double calculateCalories() {
    return (_steps * 0.045);
  }

  void dispose() {
    _midnightTimer?.cancel();
    _stepController.close();
    _statusController.close();
  }
}
