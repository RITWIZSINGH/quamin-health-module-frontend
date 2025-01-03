class StepData {
  final DateTime timestamp;
  final int steps;

  StepData({required this.timestamp, required this.steps});

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'steps': steps,
      };

  factory StepData.fromJson(Map<String, dynamic> json) => StepData(
        timestamp: DateTime.parse(json['timestamp']),
        steps: json['steps'],
      );
}