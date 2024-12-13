import 'package:flutter/material.dart';
import '../../diet_models/user_info.dart';
import '../../diet_services/diet_service.dart';
import '../../diet_models/diet_plan_response.dart';

class DietQuestionnaireTab extends StatefulWidget {
  const DietQuestionnaireTab({super.key});

  @override
  State<DietQuestionnaireTab> createState() => _DietQuestionnaireTabState();
}

class _DietQuestionnaireTabState extends State<DietQuestionnaireTab> {
  final _formKey = GlobalKey<FormState>();
  final _dietService = DietService();
  DietPlanResponse? _dietPlanResponse;
  bool _isLoading = false;

  // Form controllers
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
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

        final response = await _dietService.getDietRecommendations(userInfo);
        setState(() => _dietPlanResponse = response);
      } catch (e) {
        print(e);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _dietPlanResponse == null ? _buildForm() : _buildResults(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your age' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your weight' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your height' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _symptomsController,
              decoration: const InputDecoration(labelText: 'Symptoms'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your symptoms' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _medicalConditionsController,
              decoration:
                  const InputDecoration(labelText: 'Medical Conditions'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _activityLevel,
              decoration: const InputDecoration(labelText: 'Activity Level'),
              items: ['Low', 'Moderate', 'High'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => _activityLevel = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _dietaryPreferences,
              decoration:
                  const InputDecoration(labelText: 'Dietary Preferences'),
              items:
                  ['Vegetarian', 'Vegan', 'Non-vegetarian'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) =>
                  setState(() => _dietaryPreferences = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _preferredCuisineController,
              decoration: const InputDecoration(labelText: 'Preferred Cuisine'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your preferred cuisine'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _sleepPatternController,
              decoration: const InputDecoration(labelText: 'Sleep Pattern'),
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your sleep pattern'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _stressLevel,
              decoration: const InputDecoration(labelText: 'Stress Level'),
              items: ['Low', 'Medium', 'High'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => _stressLevel = value!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Generate Diet Plan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Your Diet Plan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(_dietPlanResponse?.dailyNutrientRequirements.recommendations ??
              ''),
          const SizedBox(height: 24),
          const Text(
            'Summary in Hindi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(_dietPlanResponse?.summaryInHindi ?? ''),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => setState(() => _dietPlanResponse = null),
            child: const Text('Generate New Plan'),
          ),
        ],
      ),
    );
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
