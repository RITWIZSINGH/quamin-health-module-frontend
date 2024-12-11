import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/sleep_data.dart';
import 'dart:math' as math;

enum TimeRange { today, weekly, monthly }

class SleepChart extends StatefulWidget {
  final Function(SleepData) onDataSelected;
  final SleepData selectedData;
  
  const SleepChart({
    super.key,
    required this.onDataSelected,
    required this.selectedData,
  });
  
  @override
  State<SleepChart> createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  TimeRange _selectedRange = TimeRange.weekly;
  final ScrollController _scrollController = ScrollController();
  
  List<SleepData> get _currentData {
    switch (_selectedRange) {
      case TimeRange.today:
        return [SleepDataProvider.weeklyData.last];
      case TimeRange.weekly:
        return SleepDataProvider.weeklyData;
      case TimeRange.monthly:
        return SleepDataProvider.monthlyData;
    }
  }

  String _getDateLabel(DateTime date) {
    switch (_selectedRange) {
      case TimeRange.today:
        return 'Today';
      case TimeRange.weekly:
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[date.weekday - 1];
      case TimeRange.monthly:
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return months[date.month - 1];
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: TimeRange.values.map((range) {
                return _buildPeriodButton(
                  range.name[0].toUpperCase() + range.name.substring(1),
                  _selectedRange == range,
                  () => _updateTimeRange(range),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              width: constraints.maxWidth,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: SizedBox(
                  width: _selectedRange == TimeRange.monthly 
                      ? math.max(800, constraints.maxWidth)
                      : constraints.maxWidth,
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
                          final index = barTouchResponse.spot!.touchedBarGroupIndex;
                          if (index < _currentData.length) {
                            widget.onDataSelected(_currentData[index]);
                          }
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index >= _currentData.length) return const Text('');
                              return Text(
                                _getDateLabel(_currentData[index].date),
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
                      barGroups: List.generate(_currentData.length, (index) {
                        final isSelected = _currentData[index].date == widget.selectedData.date;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: _currentData[index].hours,
                              color: isSelected ? const Color(0xff888CEF) : const Color(0xffCED0F8),
                              width: _selectedRange == TimeRange.monthly ? 40 : 20,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPeriodButton(String text, bool isSelected, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF888CEF) : Colors.transparent,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  void _updateTimeRange(TimeRange range) {
    setState(() {
      _selectedRange = range;
    });
    widget.onDataSelected(_currentData.last);
  }
}