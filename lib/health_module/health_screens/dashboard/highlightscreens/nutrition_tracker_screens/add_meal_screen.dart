import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/health_module/health_models/meal.dart';
import 'package:quamin_health_module/health_module/health_providers/nutrition_provider.dart';
import 'package:quamin_health_module/health_module/health_widgets/common/primary_button.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  double _fat = 0;
  double _protein = 0;
  double _carbs = 0;

  @override
  Widget build(BuildContext context) {
    final nutritionProvider = Provider.of<NutritionProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Add Meal',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Macronutrients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildNutrientInput(
                      'Fat (g)',
                      const Color(0xff878ced),
                      nutritionProvider.target.fatTarget,
                      (value) => setState(() => _fat = double.parse(value)),
                    ),
                    const SizedBox(height: 16),
                    _buildNutrientInput(
                      'Protein (g)',
                      const Color(0xffefa98d),
                      nutritionProvider.target.proteinTarget,
                      (value) => setState(() => _protein = double.parse(value)),
                    ),
                    const SizedBox(height: 16),
                    _buildNutrientInput(
                      'Carbs (g)',
                      const Color(0xff9d7ee7),
                      nutritionProvider.target.carbsTarget,
                      (value) => setState(() => _carbs = double.parse(value)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimated Calories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${((_fat * 9) + (_protein * 4) + (_carbs * 4)).toStringAsFixed(0)} kcal',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xff878ced),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Add Meal',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final meal = Meal(
                    fat: _fat,
                    protein: _protein,
                    carbs: _carbs,
                    timestamp: DateTime.now(),
                  );

                  context.read<NutritionProvider>().addMeal(meal);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInput(
    String label,
    Color color,
    double target,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Target: ${target.toStringAsFixed(0)}g',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Enter amount',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
          onChanged: onChanged,
        ),
      ],
    );
  }
}