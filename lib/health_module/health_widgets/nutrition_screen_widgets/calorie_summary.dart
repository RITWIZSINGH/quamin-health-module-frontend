import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../health_providers/nutrition_provider.dart';

class CalorieSummary extends StatelessWidget {
  const CalorieSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final nutritionProvider = Provider.of<NutritionProvider>(context);
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sh / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text(
                'You have consumed',
                style: TextStyle(fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 24),
                  children: [
                    TextSpan(
                      text: '${nutritionProvider.totalCalories.toStringAsFixed(0)} kcal ',
                      style: const TextStyle(
                        color: Color(0xff878ced),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'today',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Text(
                'of ${nutritionProvider.target.calorieTarget.toStringAsFixed(0)} kcal target',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}