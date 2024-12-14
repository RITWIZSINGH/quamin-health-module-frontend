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

  String _dietGoal = 'Weight Loss';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AnimatedSaladBowl(),
          const SizedBox(height: 24),
          Text(
            'Welcome to Your Personalized Diet Journey! ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildPlayfulTextField(
            controller: _ageController,
            label: '🎂 How many candles will light up your next birthday cake?',
            hint: 'Enter your age with a smile!',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Oops! We need to know how many candles to buy 🕯️';
              }
              final age = int.tryParse(value);
              return age == null || age < 1 || age > 120
                  ? 'A real age between 1 and 120, please! 😉'
                  : null;
            },
          ),
          _buildPlayfulTextField(
            controller: _weightController,
            label: '⚖️ What does the scale whisper to you? (No judgment zone!)',
            hint: 'Your weight in kg (our little secret)',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'The scale is feeling shy! Help it speak up 🤫';
              }
              final weight = double.tryParse(value);
              return weight == null || weight < 20 || weight > 300
                  ? 'Let\'s keep it real, superhuman! 💪'
                  : null;
            },
          ),
          _buildPlayfulTextField(
            controller: _heightController,
            label: '📏 How tall are you in the kingdom of nutrition?',
            hint: 'Height in cm (stand proud!)',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Height is playing hide and seek 🙈';
              }
              final height = double.tryParse(value);
              return height == null || height < 50 || height > 250
                  ? 'Are you a secret giant or a playful elf? 🧝'
                  : null;
            },
          ),
          _buildPlayfulTextField(
            controller: _foodCrazyController,
            label: '🍔 On a scale of salad to pizza, how food crazy are you?',
            hint: 'Tell us about your food adventures',
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Share your food love story! 🍽️';
              }
              return null;
            },
          ),
          _buildPlayfulTextField(
            controller: _favoriteFoodController,
            label: '❤️ Your ride-or-die food that makes you happiest?',
            hint: 'The ultimate comfort food champion',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Every food has a story! What\'s yours? 🍲';
              }
              return null;
            },
          ),
          _buildDropdown(
            value: _dietGoal,
            label: '🎯 Your Diet Mission, Should You Choose to Accept It',
            items: const [
              'Weight Loss',
              'Muscle Gain',
              'Maintain',
              'Get Healthy'
            ],
            onChanged: (value) => setState(() => _dietGoal = value!),
          ),
          _buildPlayfulTextField(
            controller: _gymFrequencyController,
            label: '💪 How often do you dance with weights?',
            hint: 'Gym visits per week (be honest!)',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Exercise frequency is calling! 🏋️‍♀️';
              }
              final visits = int.tryParse(value);
              return visits == null || visits < 0 || visits > 7
                  ? 'Let\'s keep it between 0 and 7 days, fitness ninja!'
                  : null;
            },
          ),
          _buildPlayfulTextField(
            controller: _sleepHoursController,
            label: '😴 How many hours do you spend in dreamland?',
            hint: 'Average sleep hours',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Sleepy time stats needed! 🛌';
              }
              final sleep = double.tryParse(value);
              return sleep == null || sleep < 2 || sleep > 14
                  ? 'Between 2 and 14 hours, sleep champion!'
                  : null;
            },
          ),
          const SizedBox(height: 24),
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
              'Unlock My Diet Destiny! 🚀',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayfulTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.green[50],
        ),
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        validator: validator,
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
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.green[50],
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
        symptoms: _foodCrazyController.text,
        medicalConditions: _favoriteFoodController.text,
        activityLevel: _gymFrequencyController.text, // Repurposed gym visits
        dietaryPreferences: _dietGoal,
        preferredCuisine: '', // Left empty as not directly captured
        sleepPattern: _sleepHoursController.text,
        stressLevel: 'Medium', // Default value
      );
      widget.onSubmit(userInfo);
    }
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
    super.dispose();
  }
}
