import 'package:flutter/material.dart';
import 'package:quamin_health_module/widgets/sleep_screen_widgets/sleep_chart.dart';
import '/widgets/sleep_screen_widgets/sleep_summary.dart';
import '/widgets/sleep_screen_widgets/sleep_stats.dart';
import '/widgets/sleep_screen_widgets/sleep_schedule.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SleepSummary(),
              SizedBox(height: 24),
              SleepChart(),
              SizedBox(height: 24),
              SleepStats(),
              SizedBox(height: 24),
              SleepSchedule(),
            ],
          ),
        ),
      ),
    );
  }
}