import 'package:flutter/material.dart';
import 'package:quamin_health_module/diet_module/diet_widgets/common/animated_salad_bowl.dart';
import '../../diet_models/user_info.dart';

class DietForm extends StatefulWidget {
  final Function(UserInfo) onSubmit;

  const DietForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<DietForm> createState() => _DietFormState();
}

class _DietFormState extends State<DietForm> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _medicalConditionsController = TextEditingController();
  String _activityLevel = 'Moderate';
  String _dietaryPreferences = 'Vegetarian';
  final _preferredCuisineController = TextEditingController();
  final _sleepPatternController = TextEditingController();
  String _stressLevel = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AnimatedSaladBowl(),
          const SizedBox(height: 24),
          _buildTextField(
            controller: _ageController,
            label: 'Age',
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            controller: _weightController,
            label: 'Weight (kg)',
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            controller: _heightController,
            label: 'Height (cm)',
            keyboardType: TextInputType.number,
          ),
          _buildTextField(
            controller: _symptomsController,
            label: 'Symptoms',
            maxLines: 3,
          ),
          _buildTextField(
            controller: _medicalConditionsController,
            label: 'Medical Conditions',
            maxLines: 3,
          ),
          _buildDropdown(
            value: _activityLevel,
            label: 'Activity Level',
            items: const ['Low', 'Moderate', 'High'],
            onChanged: (value) => setState(() => _activityLevel = value!),
          ),
          _buildDropdown(
            value: _dietaryPreferences,
            label: 'Dietary Preferences',
            items: const ['Vegetarian', 'Vegan', 'Non-vegetarian'],
            onChanged: (value) => setState(() => _dietaryPreferences = value!),
          ),
          _buildTextField(
            controller: _preferredCuisineController,
            label: 'Preferred Cuisine',
          ),
          _buildTextField(
            controller: _sleepPatternController,
            label: 'Sleep Pattern',
          ),
          _buildDropdown(
            value: _stressLevel,
            label: 'Stress Level',
            items: const ['Low', 'Medium', 'High'],
            onChanged: (value) => setState(() => _stressLevel = value!),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Generate Diet Plan',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        validator: (value) => value?.isEmpty ?? true ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final userInfo = UserInfo(
        age: int.parse(_ageController.text),
        weight: double.parse(_weightController.text),
        height: double.parse(_heightController.text),
        symptoms: _symptomsController.text,
        medicalConditions: _medicalConditionsController.text,
        activityLevel: _activityLevel,
        dietaryPreferences: _dietaryPreferences,
        preferredCuisine: _preferredCuisineController.text,
        sleepPattern: _sleepPatternController.text,
        stressLevel: _stressLevel,
      );
      widget.onSubmit(userInfo);
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _symptomsController.dispose();
    _medicalConditionsController.dispose();
    _preferredCuisineController.dispose();
    _sleepPatternController.dispose();
    super.dispose();
  }
}