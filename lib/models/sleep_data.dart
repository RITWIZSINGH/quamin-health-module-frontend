class SleepData {
  final double hours;
  final int deepSleepMinutes;
  final double sleepRate;
  final DateTime date;

  SleepData({
    required this.hours,
    required this.deepSleepMinutes,
    required this.sleepRate,
    required this.date,
  });
}

class SleepDataProvider {
  static final List<SleepData> weeklyData = [
    SleepData(hours: 7.5, deepSleepMinutes: 63, sleepRate: 82, date: DateTime.now().subtract(const Duration(days: 6))),
    SleepData(hours: 5.2, deepSleepMinutes: 45, sleepRate: 75, date: DateTime.now().subtract(const Duration(days: 5))),
    SleepData(hours: 6.8, deepSleepMinutes: 58, sleepRate: 80, date: DateTime.now().subtract(const Duration(days: 4))),
    SleepData(hours: 7.2, deepSleepMinutes: 65, sleepRate: 85, date: DateTime.now().subtract(const Duration(days: 3))),
    SleepData(hours: 5.8, deepSleepMinutes: 50, sleepRate: 78, date: DateTime.now().subtract(const Duration(days: 2))),
    SleepData(hours: 8.1, deepSleepMinutes: 70, sleepRate: 88, date: DateTime.now().subtract(const Duration(days: 1))),
    SleepData(hours: 7.0, deepSleepMinutes: 63, sleepRate: 82, date: DateTime.now()),
  ];

  static final List<SleepData> monthlyData = [
    SleepData(hours: 7.2, deepSleepMinutes: 62, sleepRate: 83, date: DateTime(2024, 1, 1)),
    SleepData(hours: 6.9, deepSleepMinutes: 58, sleepRate: 80, date: DateTime(2024, 2, 1)),
    SleepData(hours: 7.5, deepSleepMinutes: 65, sleepRate: 85, date: DateTime(2024, 3, 1)),
    SleepData(hours: 7.1, deepSleepMinutes: 60, sleepRate: 82, date: DateTime(2024, 4, 1)),
    SleepData(hours: 7.3, deepSleepMinutes: 63, sleepRate: 84, date: DateTime(2024, 5, 1)),
    SleepData(hours: 7.0, deepSleepMinutes: 59, sleepRate: 81, date: DateTime(2024, 6, 1)),
    SleepData(hours: 6.8, deepSleepMinutes: 57, sleepRate: 79, date: DateTime(2024, 7, 1)),
    SleepData(hours: 7.4, deepSleepMinutes: 64, sleepRate: 86, date: DateTime(2024, 8, 1)),
    SleepData(hours: 7.2, deepSleepMinutes: 61, sleepRate: 83, date: DateTime(2024, 9, 1)),
    SleepData(hours: 7.1, deepSleepMinutes: 60, sleepRate: 82, date: DateTime(2024, 10, 1)),
    SleepData(hours: 6.9, deepSleepMinutes: 58, sleepRate: 80, date: DateTime(2024, 11, 1)),
    SleepData(hours: 7.3, deepSleepMinutes: 63, sleepRate: 84, date: DateTime(2024, 12, 1)),
  ];

  static double calculateAverageHours(List<SleepData> data) {
    if (data.isEmpty) return 0;
    return data.map((d) => d.hours).reduce((a, b) => a + b) / data.length;
  }

  static int calculateAverageDeepSleepMinutes(List<SleepData> data) {
    if (data.isEmpty) return 0;
    return data.map((d) => d.deepSleepMinutes).reduce((a, b) => a + b) ~/ data.length;
  }
}