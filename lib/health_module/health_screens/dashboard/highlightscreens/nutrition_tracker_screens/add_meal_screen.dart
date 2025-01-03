import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../health_models/meal.dart';
import '../../../../health_providers/meal_provider.dart';
import '../../../../health_widgets/common/primary_button.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNutrientInput('Fat (g)', Color(0xff878ced), (value) {
                setState(() => _fat = double.parse(value));
              }),
              const SizedBox(height: 16),
              _buildNutrientInput('Protein (g)', Color(0xffefa98d), (value) {
                setState(() => _protein = double.parse(value));
              }),
              const SizedBox(height: 16),
              _buildNutrientInput('Carbs (g)', Color(0xff9d7ee7), (value) {
                setState(() => _carbs = double.parse(value));
              }),
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

                    context.read<MealProvider>().addMeal(meal);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientInput(
      String label, Color color, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: color),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
