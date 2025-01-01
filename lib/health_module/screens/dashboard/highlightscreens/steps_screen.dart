import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../widgets/step_screen_widgets/progress_ring.dart';
import '../../../widgets/step_screen_widgets/stat_card.dart';
import '../../../widgets/step_screen_widgets/activity_chart.dart';
import '../../../widgets/step_screen_widgets/time_period_selector.dart';
import '../../../services/step_tracking_service.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  final StepTrackingService _stepService = StepTrackingService();
  String _selectedPeriod = 'Today';

  @override
  void initState() {
    super.initState();
    _stepService.initialize();
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () => _showGoalSettingDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<int>(
        stream: _stepService.stepStream,
        builder: (context, snapshot) {
          final steps = snapshot.data ?? 0;
          final progress = steps / _stepService.currentGoal;

          return SingleChildScrollView(
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
                          text: '${(progress * 100).toStringAsFixed(0)}% ',
                          style: const TextStyle(
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
                  ProgressRing(
                    progress: progress,
                    steps: steps,
                    goal: _stepService.currentGoal,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      StatCard(
                        type: 'calories',
                        icon: LucideIcons.flame,
                        color: Colors.purple,
                      ),
                      StatCard(
                        type: 'distance',
                        icon: LucideIcons.mapPin,
                        color: Colors.orange,
                      ),
                      StatCard(
                        type: 'duration',
                        icon: LucideIcons.clock,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      TimePeriodSelector(
                        selectedPeriod: _selectedPeriod,
                        onPeriodChanged: (period) {
                          setState(() => _selectedPeriod = period);
                        },
                      ),
                      const SizedBox(height: 20),
                      ActivityChart(period: _selectedPeriod),
                      const SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showGoalSettingDialog(BuildContext context) async {
    final controller = TextEditingController(
      text: _stepService.currentGoal.toString(),
    );

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Daily Step Goal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Daily Steps Goal',
            hintText: 'Enter your daily step goal',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newGoal = int.tryParse(controller.text);
              if (newGoal != null && newGoal > 0) {
                _stepService.setGoal(newGoal);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}