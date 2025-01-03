import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quamin_health_module/health_module/health_models/nutrition_target.dart';
import 'package:quamin_health_module/health_module/health_providers/nutrition_provider.dart';
import 'package:quamin_health_module/health_module/health_widgets/common/primary_button.dart';

class SetTargetScreen extends StatefulWidget {
  const SetTargetScreen({super.key});

  @override
  State<SetTargetScreen> createState() => _SetTargetScreenState();
}

class _SetTargetScreenState extends State<SetTargetScreen> {
  final _formKey = GlobalKey<FormState>();
  late double _calories;
  late double _fat;
  late double _protein;
  late double _carbs;

  @override
  void initState() {
    super.initState();
    final target = context.read<NutritionProvider>().target;
    _calories = target.calorieTarget;
    _fat = target.fatTarget;
    _protein = target.proteinTarget;
    _carbs = target.carbsTarget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Set Nutrition Targets',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildTargetInput(
              'Daily Calorie Target',
              Colors.blue,
              _calories,
              (value) => setState(() => _calories = value),
            ),
            const SizedBox(height: 24),
            _buildTargetInput(
              'Fat Target (g)',
              const Color(0xff878ced),
              _fat,
              (value) => setState(() => _fat = value),
            ),
            const SizedBox(height: 24),
            _buildTargetInput(
              'Protein Target (g)',
              const Color(0xffefa98d),
              _protein,
              (value) => setState(() => _protein = value),
            ),
            const SizedBox(height: 24),
            _buildTargetInput(
              'Carbs Target (g)',
              const Color(0xff9d7ee7),
              _carbs,
              (value) => setState(() => _carbs = value),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Save Targets',
              onPressed: _saveTargets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetInput(
    String label,
    Color color,
    double initialValue,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
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
          initialValue: initialValue.toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            final number = double.tryParse(value);
            if (number == null || number <= 0) {
              return 'Please enter a valid number';
            }
            return null;
          },
          onChanged: (value) {
            final number = double.tryParse(value);
            if (number != null) {
              onChanged(number);
            }
          },
        ),
      ],
    );
  }

  void _saveTargets() {
    if (_formKey.currentState!.validate()) {
      final newTarget = NutritionTarget(
        calorieTarget: _calories,
        fatTarget: _fat,
        proteinTarget: _protein,
        carbsTarget: _carbs,
      );
      
      context.read<NutritionProvider>().updateTarget(newTarget);
      Navigator.pop(context);
    }
  }
}