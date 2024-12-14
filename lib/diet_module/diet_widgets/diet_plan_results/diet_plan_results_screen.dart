import 'package:flutter/material.dart';
import '../../diet_models/diet_plan_response.dart';
import 'nutrient_requirements_card.dart';
import 'hindi_summary_card.dart';

class DietPlanResults extends StatelessWidget {
  final DietPlanResponse response;
  final VoidCallback onBack;

  const DietPlanResults({
    super.key,
    required this.response,
    required this.onBack,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: onBack,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Your Personalized Diet Plan',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NutrientRequirementsCard(
                        recommendations: response.dailyNutrientRequirements.recommendations,
                      ),
                      const SizedBox(height: 16),
                      HindiSummaryCard(
                        summary: response.summaryInHindi,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}