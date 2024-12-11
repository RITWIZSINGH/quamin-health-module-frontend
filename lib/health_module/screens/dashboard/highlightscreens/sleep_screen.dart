import 'package:flutter/material.dart';
import '../../../models/sleep_data.dart';
import 'package:quamin_health_module/health_module/widgets/sleep_screen_widgets/sleep_chart.dart';
import 'package:quamin_health_module/health_module/widgets/sleep_screen_widgets/sleep_schedule.dart';
import 'package:quamin_health_module/health_module/widgets/sleep_screen_widgets/sleep_stats.dart';
import 'package:quamin_health_module/health_module/widgets/sleep_screen_widgets/sleep_summary.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  late SleepData _selectedSleepData;

  @override
  void initState() {
    super.initState();
    _selectedSleepData = SleepDataProvider.weeklyData.last;
  }

  void _updateSelectedData(SleepData data) {
    setState(() {
      _selectedSleepData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Sleep',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SleepSummary(data: _selectedSleepData),
                      const SizedBox(height: 24),
                      SleepChart(
                        selectedData: _selectedSleepData,
                        onDataSelected: _updateSelectedData,
                      ),
                      const SizedBox(height: 24),
                      SleepStats(data: _selectedSleepData),
                      const SizedBox(height: 24),
                      const SleepSchedule(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}