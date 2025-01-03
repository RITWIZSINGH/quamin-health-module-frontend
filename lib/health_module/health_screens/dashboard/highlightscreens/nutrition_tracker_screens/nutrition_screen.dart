import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:quamin_health_module/health_module/health_providers/nutrition_provider.dart';
import 'package:quamin_health_module/health_module/health_widgets/common/primary_button.dart';
import 'package:quamin_health_module/health_module/health_widgets/nutrition_screen_widgets/calorie_summary.dart';
import 'package:quamin_health_module/health_module/health_widgets/nutrition_screen_widgets/macros_breakdown.dart';
import 'package:quamin_health_module/health_module/health_widgets/nutrition_screen_widgets/nutrition_chart.dart';
import 'add_meal_screen.dart';
import 'set_target_screen.dart';
import 'package:provider/provider.dart';

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
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SetTargetScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NutritionProvider>(
        builder: (context, nutritionProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CalorieSummary(),
                  const SizedBox(height: 24),
                  const NutritionChart(),
                  const SizedBox(height: 24),
                  MacrosBreakdown(
                    fatPercentage: nutritionProvider.fatPercentage,
                    proteinPercentage: nutritionProvider.proteinPercentage,
                    carbsPercentage: nutritionProvider.carbsPercentage,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Add Meal',
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