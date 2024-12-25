import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../widgets/step_screen_widgets/progress_ring.dart';
import '../../../widgets/step_screen_widgets/stat_card.dart';
import '../../../widgets/step_screen_widgets/activity_chart.dart';
import '../../../widgets/step_screen_widgets/time_period_selector.dart';

class StepsScreen extends StatelessWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Steps',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'You have achieved',
                style: TextStyle(fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '80% ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff636ae8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'of your goal',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'today',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const ProgressRing(
                progress: 0.8,
                steps: 11857,
                goal: 18,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatCard(
                    icon: LucideIcons.flame,
                    value: '850',
                    unit: 'kcal',
                    color: Colors.purple,
                    progress: 0.7,
                  ),
                  StatCard(
                    icon: LucideIcons.mapPin,
                    value: '5',
                    unit: 'km',
                    color: Colors.orange,
                    progress: 0.5,
                  ),
                  StatCard(
                    icon: LucideIcons.clock,
                    value: '120',
                    unit: 'min',
                    color: Colors.blue,
                    progress: 0.8,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  const TimePeriodSelector(),
                  const SizedBox(height: 20),
                  const ActivityChart(),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}