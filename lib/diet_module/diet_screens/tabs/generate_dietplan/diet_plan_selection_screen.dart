import 'package:flutter/material.dart';
import '../../../diet_models/diet_period.dart';
import '../../../diet_widgets/common/animated_salad_bowl.dart';
import '../../../diet_widgets/diet_plan_duration/plan_option_card.dart';

class DietPlanSelectionScreen extends StatelessWidget {
  final Function(DietPeriod) onPlanSelected;

  const DietPlanSelectionScreen({
    super.key,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe1f1cf), Color(0xffa8dfc9)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AnimatedSaladBowl(),
                  const SizedBox(height: 32),
                  Text(
                    'Choose Your Diet Plan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  PlanOptionCard(
                    title: '3 Months Plan',
                    description:
                        'Short term diet plan to kickstart your diet journey',
                    price: 2000,
                    onTap: () => onPlanSelected(DietPeriod.threemonths),
                  ),
                  const SizedBox(height: 16),
                  PlanOptionCard(
                    title: '6 Months Plan',
                    description: 'Medium term diet plan to sustain progress',
                    price: 4000,
                    onTap: () => onPlanSelected(DietPeriod.sixmonths),
                  ),
                  const SizedBox(height: 16),
                  PlanOptionCard(
                    title: '12 Months Plan',
                    description: 'Long term diet plan for lasting results',
                    price: 6000,
                    onTap: () => onPlanSelected(DietPeriod.twelvemonths),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}