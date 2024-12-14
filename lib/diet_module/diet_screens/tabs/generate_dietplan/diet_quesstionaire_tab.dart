import 'package:flutter/material.dart';
import 'package:quamin_health_module/diet_module/diet_widgets/common/animated_salad_bowl.dart';
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
  State<DietQuestionnaireScreen> createState() =>
      _DietQuestionnaireScreenState();
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffe1f1cf), Color(0xffa8dfc9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => setState(() => _selectedPeriod = null),
                    ),
                    Expanded(
                      child: Text(
                        '${_selectedPeriod!.displayName} Diet Plan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded to allow scrolling and full view of form
              Expanded(
                child: Stack(
                  children: [
                    // Form with padding and scrollview
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DietForm(
                        onSubmit: _onFormSubmit,
                      ),
                    ),

                    // Loading indicator
                    if (_isLoading)
                      Container(
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
