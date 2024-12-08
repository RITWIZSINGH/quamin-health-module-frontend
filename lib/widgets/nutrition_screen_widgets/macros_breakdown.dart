import 'package:flutter/material.dart';

class MacrosBreakdown extends StatelessWidget {
  const MacrosBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: Column(
        children: [
          _buildMacroRow('Fat', '80g', '40%', Colors.blue[400]!),
          const SizedBox(height: 16),
          _buildMacroRow('Protein', '160g', '56%', Colors.orange[300]!),
          const SizedBox(height: 16),
          _buildMacroRow('Carbs', '230g', '62%', Colors.blue[200]!),
        ],
      ),
    );
  }

  Widget _buildMacroRow(
      String name, String grams, String percentage, Color color) {
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
