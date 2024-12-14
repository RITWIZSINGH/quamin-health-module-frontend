import 'package:flutter/material.dart';
import '../../diet_models/diet_plan_response.dart';

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
      appBar: AppBar(
        title: const Text('Your Diet Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildResultCard(
            'Daily Nutrient Requirements',
            response.dailyNutrientRequirements.recommendations,
          ),
          const SizedBox(height: 16),
          _buildResultCard(
            'हिंदी में सारांश',
            response.summaryInHindi,
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(content),
          ],
        ),
      ),
    );
  }
}