import 'package:flutter/material.dart';
import 'package:quamin_health_module/health_module/health_models/cycle_tracking_models/symptoms.dart';
import 'package:quamin_health_module/health_module/health_services/cycle_tracking_services/period_service.dart';
import 'symptom_dialog.dart';
import 'insights_dialog.dart';

class FeelingSection extends StatelessWidget {
  final PeriodService _periodService = PeriodService();

  FeelingSection({super.key});

  void _showSymptomDialog(BuildContext context) async {
    final symptom = await showDialog<Symptom>(
      context: context,
      builder: (context) => SymptomDialog(),
    );

    if (symptom != null) {
      await _periodService.addSymptom(symptom);
    }
  }

  void _showInsightsDialog(BuildContext context) async {
    final periodData = await _periodService.getPeriodData();
    if (periodData != null) {
      final insights = _periodService.getDailyInsights(periodData);
      showDialog(
        context: context,
        builder: (context) => InsightsDialog(insights: insights),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFeelingOption(
              Icons.edit_note,
              'Share your\nsymptoms with us',
              Color(0xff9f85ec),
              () => _showSymptomDialog(context),
            ),
            _buildFeelingOption(
              Icons.insights,
              'Here\'s your daily\ninsights',
              Color(0xffe96992),
              () => _showInsightsDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeelingOption(
    IconData icon,
    String text,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CircleAvatar(
              child: Icon(icon, size: 32, color: color),
              radius: 28,
              backgroundColor: color.withOpacity(0.2),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}