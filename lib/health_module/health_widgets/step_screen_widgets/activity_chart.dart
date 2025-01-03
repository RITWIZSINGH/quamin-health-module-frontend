import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../health_services/step_services/step_tracking_service.dart';
import '../../health_models/step_data.dart';

class ActivityChart extends StatelessWidget {
  final String period;

  const ActivityChart({
    super.key,
    required this.period,
  });

  List<FlSpot> _getSpots(List<StepData> data) {
    if (data.isEmpty) return [];

    switch (period) {
      case 'Today':
        // Group by hour for today
        final hourlyData = List.generate(24, (index) {
          final hour = DateTime.now().subtract(Duration(hours: 23 - index));
          final steps = data
              .where((d) => d.timestamp.hour == hour.hour)
              .fold(0, (sum, item) => sum + item.steps);
          return FlSpot(index.toDouble(), steps.toDouble());
        });
        return hourlyData;
      
      case 'Weekly':
        // Group by day for the week
        final weeklyData = List.generate(7, (index) {
          final day = DateTime.now().subtract(Duration(days: 6 - index));
          final steps = data
              .where((d) => d.timestamp.day == day.day)
              .fold(0, (sum, item) => sum + item.steps);
          return FlSpot(index.toDouble(), steps.toDouble());
        });
        return weeklyData;
      
      case 'Monthly':
        // Group by month for the year
        final monthlyData = List.generate(12, (index) {
          final month = DateTime.now().subtract(Duration(days: (11 - index) * 30));
          final steps = data
              .where((d) => d.timestamp.month == month.month)
              .fold(0, (sum, item) => sum + item.steps);
          return FlSpot(index.toDouble(), steps.toDouble());
        });
        return monthlyData;
      
      default:
        return [];
    }
  }

  String _getLabel(double value) {
    switch (period) {
      case 'Today':
        return '${value.toInt()}:00';
      case 'Weekly':
        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[value.toInt() % 7];
      case 'Monthly':
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return months[value.toInt() % 12];
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff878ced),
        borderRadius: BorderRadius.circular(16),
      ),
      child: StreamBuilder<int>(
        stream: StepTrackingService().stepStream,
        builder: (context, snapshot) {
          // In a real app, you would get this data from your StepTrackingService
          final mockData = [StepData(timestamp: DateTime.now(), steps: snapshot.data ?? 0)];
          
          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        _getLabel(value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: _getSpots(mockData),
                  isCurved: true,
                  color: Colors.white,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}