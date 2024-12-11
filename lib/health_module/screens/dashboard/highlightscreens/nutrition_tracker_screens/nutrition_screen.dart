import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../widgets/nutrition_screen_widgets/calorie_summary.dart';
import '../../../../widgets/nutrition_screen_widgets/nutrition_chart.dart';
import '../../../../widgets/nutrition_screen_widgets/macros_breakdown.dart';
import '../../../../widgets/common/primary_button.dart';
import 'add_meal_screen.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/health_module/providers/meal_provider.dart';

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
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CalorieSummary(),
                  const SizedBox(height: 24),
                  NutritionChart(
                    fatPercentage: mealProvider.fatPercentage,
                    proteinPercentage: mealProvider.proteinPercentage,
                    carbsPercentage: mealProvider.carbsPercentage,
                  ),
                  const SizedBox(height: 24),
                  MacrosBreakdown(
                    fatPercentage: mealProvider.fatPercentage,
                    proteinPercentage: mealProvider.proteinPercentage,
                    carbsPercentage: mealProvider.carbsPercentage,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Add meals',
                    icon: LucideIcons.soup,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddMealScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
