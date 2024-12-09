import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepChart extends StatefulWidget {
  const SleepChart({super.key});
  
  @override
  _SleepChartState createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  int _selectedDayIndex = 5; // Default selected day (Saturday)

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPeriodButton('Today', false),
            _buildPeriodButton('Weekly', true),
            _buildPeriodButton('Monthly', false),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 10,
              barTouchData: BarTouchData(
                enabled: true,
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      barTouchResponse == null ||
                      barTouchResponse.spot == null) {
                    return;
                  }
                  setState(() {
                    _selectedDayIndex =
                        barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = [
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat',
                        'Sun'
                      ];
                      return Text(
                        days[value.toInt()],
                        style: const TextStyle(fontSize: 12),
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
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                _createBarData(0, 7.5, _selectedDayIndex == 0),
                _createBarData(1, 5.2, _selectedDayIndex == 1),
                _createBarData(2, 6.8, _selectedDayIndex == 2),
                _createBarData(3, 7.2, _selectedDayIndex == 3),
                _createBarData(4, 5.8, _selectedDayIndex == 4),
                _createBarData(5, 8.1, _selectedDayIndex == 5),
                _createBarData(6, 7.0, _selectedDayIndex == 6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF888CEF) : Colors.transparent,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  BarChartGroupData _createBarData(int x, double y, bool isSelected) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isSelected ? Color(0xff888CEF) : Color(0xffCED0F8),
          width: 20,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}
