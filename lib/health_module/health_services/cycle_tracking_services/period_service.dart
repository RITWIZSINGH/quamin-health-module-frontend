import 'dart:convert';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/period_data.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/symptoms.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeriodService {
  static const String _periodDataKey = 'period_data';
  
  Future<void> savePeriodData(PeriodData data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(data.toJson());
    await prefs.setString(_periodDataKey, jsonData);
  }

  Future<PeriodData?> getPeriodData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_periodDataKey);
    if (jsonData != null) {
      return PeriodData.fromJson(json.decode(jsonData));
    }
    return null;
  }

  Future<void> addSymptom(Symptom symptom) async {
    final data = await getPeriodData();
    if (data != null) {
      final updatedData = PeriodData(
        startDate: data.startDate,
        endDate: data.endDate,
        cycleLength: data.cycleLength,
        periodLength: data.periodLength,
        symptoms: [...data.symptoms, symptom],
      );
      await savePeriodData(updatedData);
    }
  }

  String getFertilityStatus(PeriodData data) {
    final daysUntilPeriod = data.daysUntilNextPeriod;
    if (daysUntilPeriod <= 7) {
      return 'Low chance of getting pregnant';
    } else if (daysUntilPeriod >= 12 && daysUntilPeriod <= 16) {
      return 'High chance of getting pregnant';
    }
    return 'Medium chance of getting pregnant';
  }

  List<String> getDailyInsights(PeriodData data) {
    final insights = <String>[];
    final daysUntilPeriod = data.daysUntilNextPeriod;

    if (daysUntilPeriod <= 3) {
      insights.add('Your period may start soon. Consider keeping supplies handy.');
      insights.add('You might experience PMS symptoms.');
    }

    if (data.symptoms.isNotEmpty) {
      final recentSymptoms = data.symptoms
          .where((s) => s.date.isAfter(DateTime.now().subtract(Duration(days: 3))))
          .toList();
      
      if (recentSymptoms.isNotEmpty) {
        insights.add('Recent symptoms: ${recentSymptoms.map((s) => s.type).join(", ")}');
      }
    }

    return insights;
  }
}