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
  final _foodCrazyController = TextEditingController();
  final _favoriteFoodController = TextEditingController();
  final _gymFrequencyController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _medicalConditionsController = TextEditingController();
  final _dietaryPreferencesController = TextEditingController();
  final _preferredCuisineController = TextEditingController();
  final _stressLevelController = TextEditingController();
  final _activityLevelController = TextEditingController();

  String _dietGoal = 'Weight Loss';
  String _gender = 'Prefer not to say';

  // Diet Goal Options
  final List<String> _dietGoalOptions = [
    'Weight Loss',
    'Muscle Gain',
    'Maintain Weight',
    'Improve Nutrition',
    'Athletic Performance'
  ];

  // Gender Options
  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-Binary',
    'Prefer not to say'
  ];

  Widget _buildQuestionField({
    required String question,
    required TextEditingController controller,
    String? hint,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          validator: validator,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDropdownQuestion({
    required String question,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedSaladBowl(),
            Text(
              'WELCOME! \nTo Your \nPersonalized Diet Journey! ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Age Question
            _buildQuestionField(
              question:
                  '🎂 How many candles will light up your next birthday cake?',
              controller: _ageController,
              hint: 'Enter your age',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age is required';
                }
                final age = int.tryParse(value);
                return age == null || age < 1 || age > 120
                    ? 'Please enter a valid age between 1 and 120'
                    : null;
              },
            ),

            // Gender Dropdown
            _buildDropdownQuestion(
              question: '👥 How do you identify?',
              value: _gender,
              items: _genderOptions,
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
            ),

            // Weight Question
            _buildQuestionField(
              question: '⚖️ What does the scale whisper to you?',
              controller: _weightController,
              hint: 'Weight in kg',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Weight is required';
                }
                final weight = double.tryParse(value);
                return weight == null || weight < 20 || weight > 300
                    ? 'Please enter a valid weight between 20 and 300 kg'
                    : null;
              },
            ),

            // Height Question
            _buildQuestionField(
              question: '📏 How tall are you standing proud?',
              controller: _heightController,
              hint: 'Height in cm',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Height is required';
                }
                final height = double.tryParse(value);
                return height == null || height < 50 || height > 250
                    ? 'Please enter a valid height between 50 and 250 cm'
                    : null;
              },
            ),

            // Diet Goal Dropdown
            _buildDropdownQuestion(
              question: '🎯 What\'s your nutrition mission?',
              value: _dietGoal,
              items: _dietGoalOptions,
              onChanged: (newValue) {
                setState(() {
                  _dietGoal = newValue!;
                });
              },
            ),

            // Food Craziness Question
            _buildQuestionField(
              question:
                  '🍽️ On a scale of "meh" to "foodie fanatic", how food-crazy are you?',
              controller: _foodCrazyController,
              hint: 'Describe your relationship with food',
              maxLines: 2,
            ),

            // Favorite Food Question
            _buildQuestionField(
              question:
                  '🍕 If you could only eat one food for the rest of your life?',
              controller: _favoriteFoodController,
              hint: 'Your ultimate comfort food',
            ),

            // Gym Frequency Question
            _buildQuestionField(
              question: '💪 How often do you dance with dumbbells?',
              controller: _gymFrequencyController,
              hint: 'Times per week you exercise',
              keyboardType: TextInputType.number,
            ),

            // Sleep Hours Question
            _buildQuestionField(
              question: '😴 How many hours do you drift in dreamland?',
              controller: _sleepHoursController,
              hint: 'Average hours of sleep',
              keyboardType: TextInputType.number,
            ),

            // Symptoms Question
            _buildQuestionField(
              question: '🩺 Any health whispers your body wants to share?',
              controller: _symptomsController,
              hint: 'Current health concerns or symptoms',
              maxLines: 2,
            ),

            // Medical Conditions Question
            _buildQuestionField(
              question: '⚕️ Any ongoing health adventures?',
              controller: _medicalConditionsController,
              hint: 'Diagnosed medical conditions',
              maxLines: 2,
            ),

            // Dietary Preferences Question
            _buildQuestionField(
              question: '🥗 What\'s your food philosophy?',
              controller: _dietaryPreferencesController,
              hint: 'Vegetarian, vegan, gluten-free, etc.',
            ),

            // Preferred Cuisine Question
            _buildQuestionField(
              question: '🌍 Which cuisine makes your taste buds dance?',
              controller: _preferredCuisineController,
              hint: 'Favorite type of cuisine',
            ),

            // Stress Level Question
            _buildQuestionField(
              question: '😓 How much stress is your constant companion?',
              controller: _stressLevelController,
              hint: 'Low, Medium, or High',
            ),

            // Activity Level Question
            _buildQuestionField(
              question: '🚶 How active is your daily adventure?',
              controller: _activityLevelController,
              hint: 'Sedentary, Moderate, or Very Active',
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Unlock My Diet Plan 🚀',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showIncompleteFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Oops! Almost There 🚧',
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Please fill out all the required fields to unlock your personalized diet plan. Every detail helps us create the perfect nutrition journey for you!',
            style: TextStyle(
              color: Colors.green[700],
            ),
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade800),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Got It! ✨',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.green[50],
        );
      },
    );
  }

  void _submitForm() {
    // Check if any of the required fields are empty
    final requiredControllers = [
      _ageController,
      _weightController,
      _heightController,
      _symptomsController,
      _medicalConditionsController,
      _dietaryPreferencesController,
      _preferredCuisineController,
      _sleepHoursController,
      _stressLevelController,
      _activityLevelController,
    ];

    // Check if any required field is empty
    bool hasEmptyField =
        requiredControllers.any((controller) => controller.text.trim().isEmpty);

    // If form is not valid or has empty fields, show dialog
    if (!_formKey.currentState!.validate() || hasEmptyField) {
      _showIncompleteFormDialog();
      return;
    }

    // If all validations pass, create UserInfo and submit
    final userInfo = UserInfo(
      symptoms: _symptomsController.text,
      age: int.parse(_ageController.text),
      weight: double.parse(_weightController.text),
      height: double.parse(_heightController.text),
      medicalConditions: _medicalConditionsController.text,
      dietaryPreferences: _dietaryPreferencesController.text,
      preferredCuisine: _preferredCuisineController.text,
      sleepPattern: _sleepHoursController.text,
      stressLevel: _stressLevelController.text,
      activityLevel: _activityLevelController.text,
    );
    widget.onSubmit(userInfo);
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _foodCrazyController.dispose();
    _favoriteFoodController.dispose();
    _gymFrequencyController.dispose();
    _sleepHoursController.dispose();
    _symptomsController.dispose();
    _medicalConditionsController.dispose();
    _dietaryPreferencesController.dispose();
    _preferredCuisineController.dispose();
    _stressLevelController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }
}
