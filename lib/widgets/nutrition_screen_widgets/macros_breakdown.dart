import 'package:flutter/material.dart';

class MacrosBreakdown extends StatelessWidget {
  final double fatPercentage;
  final double proteinPercentage;
  final double carbsPercentage;

  const MacrosBreakdown({
    super.key,
    required this.fatPercentage,
    required this.proteinPercentage,
    required this.carbsPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMacroRow('Fat', '${(fatPercentage * 65).toStringAsFixed(1)}g', 
          '${(fatPercentage * 100).toStringAsFixed(0)}%', Colors.blue[400]!),
        const SizedBox(height: 16),
        _buildMacroRow('Protein', '${(proteinPercentage * 50).toStringAsFixed(1)}g',
          '${(proteinPercentage * 100).toStringAsFixed(0)}%', Colors.orange[300]!),
        const SizedBox(height: 16),
        _buildMacroRow('Carbs', '${(carbsPercentage * 300).toStringAsFixed(1)}g',
          '${(carbsPercentage * 100).toStringAsFixed(0)}%', Colors.blue[200]!),
      ],
    );
  }

  Widget _buildMacroRow(String name, String grams, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        const Spacer(),
        Text(
          grams,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 24),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}