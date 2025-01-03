import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/symptoms.dart';

class PeriodData {
  final DateTime startDate;
  final DateTime? endDate;
  final int cycleLength;
  final int periodLength;
  final List<Symptom> symptoms;

  PeriodData({
    required this.startDate,
    this.endDate,
    this.cycleLength = 28, // Average cycle length
    this.periodLength = 5, // Average period length
    this.symptoms = const [],
  });

  DateTime get nextPeriodDate {
    return startDate.add(Duration(days: cycleLength));
  }

  int get daysUntilNextPeriod {
    final now = DateTime.now();
    return nextPeriodDate.difference(now).inDays;
  }

  bool isInPeriod(DateTime date) {
    if (endDate != null) {
      return date.isAfter(startDate.subtract(Duration(days: 1))) && 
             date.isBefore(endDate!.add(Duration(days: 1)));
    }
    return date.isAfter(startDate.subtract(Duration(days: 1))) && 
           date.isBefore(startDate.add(Duration(days: periodLength)));
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'cycleLength': cycleLength,
      'periodLength': periodLength,
      'symptoms': symptoms.map((s) => s.toJson()).toList(),
    };
  }

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    return PeriodData(
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      cycleLength: json['cycleLength'],
      periodLength: json['periodLength'],
      symptoms: (json['symptoms'] as List)
          .map((s) => Symptom.fromJson(s))
          .toList(),
    );
  }
}