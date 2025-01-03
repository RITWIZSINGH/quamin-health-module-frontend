import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../health_providers/nutrition_provider.dart';

class HealthDataItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isNutrition;

  const HealthDataItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.onTap,
    this.isNutrition = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: isNutrition
            ? Consumer<NutritionProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${provider.totalCalories.toStringAsFixed(0)} / ${provider.target.calorieTarget.toStringAsFixed(0)} kcal',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              )
            : Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}