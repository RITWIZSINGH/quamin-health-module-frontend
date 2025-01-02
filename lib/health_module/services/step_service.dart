import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepService {
  static final StepService _instance = StepService._internal();
  factory StepService() => _instance;
  StepService._internal();

  final _stepController = StreamController<StepCount>.broadcast();
  Stream<StepCount> get stepCountStream => _stepController.stream;
  
  bool _isInitialized = false;
  int _steps = 0;
  int get currentSteps => _steps;

  Future<void> initialize() async {
    if (_isInitialized) return;

    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      throw Exception('Activity recognition permission not granted');
    }

    Pedometer.stepCountStream.listen(
      (StepCount event) {
        _steps = event.steps;
        _stepController.add(event);
      },
      onError: (error) {
        print('Step count error: $error');
        _steps = 0;
      },
    );

    _isInitialized = true;
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    if (await Permission.activityRecognition.isGranted) return true;
    final status = await Permission.activityRecognition.request();
    return status.isGranted;
  }

  void dispose() {
    _stepController.close();
  }
}