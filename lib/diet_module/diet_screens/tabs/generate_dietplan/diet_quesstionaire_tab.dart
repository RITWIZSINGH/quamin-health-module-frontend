import 'package:flutter/material.dart';
import '../../../diet_models/diet_period.dart';
import '../../../diet_models/user_info.dart';
import '../../../diet_services/diet_service.dart';
import '../../../diet_models/diet_plan_response.dart';
import '../../../diet_widgets/questionnaire/diet_form.dart';
import '../../../diet_widgets/questionnaire/diet_plan_results.dart';
import '../../../diet_screens/tabs/generate_dietplan/diet_plan_selection_screen.dart';

class DietQuestionnaireScreen extends StatefulWidget {
  const DietQuestionnaireScreen({super.key});

  @override
  State<DietQuestionnaireScreen> createState() => _DietQuestionnaireScreenState();
}

class _DietQuestionnaireScreenState extends State<DietQuestionnaireScreen> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_dietPlanResponse != null) {
      return DietPlanResults(
        response: _dietPlanResponse!,
        onBack: () => setState(() => _dietPlanResponse = null),
      );
    }

    if (_selectedPeriod == null) {
      return DietPlanSelectionScreen(
        onPlanSelected: _onPeriodSelected,
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
}