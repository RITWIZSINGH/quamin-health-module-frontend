// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../../../health_widgets/cycle_tracking_widgets/calendar_strip.dart';
import '../../../health_widgets/cycle_tracking_widgets/period_circle.dart';
import '../../../health_widgets/cycle_tracking_widgets/feeling_section.dart';
import '../../../health_widgets/cycle_tracking_widgets/menstrual_health_articles.dart';

class CycleTrackingScreen extends StatelessWidget {
  const CycleTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Cycle tracking',
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
              CalendarStrip(),
              SizedBox(height: 24),
              PeriodCircle(),
              SizedBox(height: 32),
              FeelingSection(),
              SizedBox(height: 24),
              HealthArticles(),
            ],
          ),
        ),
      ),
    );
  }
}
