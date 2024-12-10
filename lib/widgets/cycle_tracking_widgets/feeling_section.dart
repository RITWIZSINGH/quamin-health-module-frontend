// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class FeelingSection extends StatelessWidget {
  const FeelingSection({super.key});

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
            _buildFeelingOption(Icons.edit_note, 'Share your\nsymtoms with us',
                Color(0xff9f85ec)),
            _buildFeelingOption(Icons.insights, 'Here\'s your daily\ninsights',
                Color(0xffe96992)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeelingOption(IconData icon, String text, Color color) {
    return Container(
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
            backgroundColor: color.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
