import 'package:flutter/material.dart';
import '../../../diet_models/diet_period.dart';
import '../../../diet_models/user_info.dart';
import '../../../diet_services/diet_service.dart';
import '../../../diet_models/diet_plan_response.dart';
import 'package:quamin_health_module/diet_module/diet_screens/tabs/generate_dietplan/diet_period_selection_screen.dart';
import '../../../diet_widgets/questionnaire/diet_form.dart';

class DietQuestionnaireTab extends StatefulWidget {
  const DietQuestionnaireTab({super.key});

  @override
  State<DietQuestionnaireTab> createState() => _DietQuestionnaireTabState();
}

class _DietQuestionnaireTabState extends State<DietQuestionnaireTab> {
  final _dietService = DietService();
  DietPlanResponse? _dietPlanResponse;
  DietPeriod? _selectedPeriod;
  bool _isLoading = false;
  String? _errorMessage;

  void _onPeriodSelected(DietPeriod period) {
    setState(() => _selectedPeriod = period);
  }

  Future<void> _onFormSubmit(UserInfo userInfo) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final response = await _dietService.getDietRecommendations(userInfo);
      setState(() {
        _dietPlanResponse = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      
      print(_errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dietPlanResponse != null) {
      return _buildResults();
    }

    if (_selectedPeriod == null) {
      return DietPeriodSelectionScreen(
        onPeriodSelected: _onPeriodSelected,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_selectedPeriod!.displayName} Diet Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _selectedPeriod = null),
        ),
      ),
      body: Stack(
        children: [
          DietForm(onSubmit: _onFormSubmit),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Diet Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _dietPlanResponse = null),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Nutrient Requirements',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_dietPlanResponse!.dailyNutrientRequirements.recommendations),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'हिंदी में सारांश',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_dietPlanResponse!.summaryInHindi),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}