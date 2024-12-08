import 'package:flutter/material.dart';
import '/widgets/nutrition_screen_widgets/calorie_summary.dart';
import '/widgets/nutrition_screen_widgets/nutrition_chart.dart';
import '/widgets/nutrition_screen_widgets/macros_breakdown.dart';
import '/widgets/common/primary_button.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Nutrition',
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
              CalorieSummary(),
              SizedBox(height: 24),
              NutritionChart(),
              SizedBox(height: 24),
              MacrosBreakdown(),
              SizedBox(height: 24),
              PrimaryButton(
                text: 'Add meals',
                icon: Icons.fastfood_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
