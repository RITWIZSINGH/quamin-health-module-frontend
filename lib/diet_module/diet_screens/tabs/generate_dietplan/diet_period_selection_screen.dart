import 'package:flutter/material.dart';
import '../../../diet_models/diet_period.dart';
import '../../../diet_widgets/common/animated_salad_bowl.dart';

class DietPeriodSelectionScreen extends StatelessWidget {
  final Function(DietPeriod) onPeriodSelected;

  const DietPeriodSelectionScreen({
    super.key,
    required this.onPeriodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const AnimatedSaladBowl(),
            const SizedBox(height: 32),
            const Text(
              'Choose Your Diet Plan Duration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: DietPeriod.values.length,
                itemBuilder: (context, index) {
                  final period = DietPeriod.values[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    child: InkWell(
                      onTap: () => onPeriodSelected(period),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              period.displayName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              period.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
