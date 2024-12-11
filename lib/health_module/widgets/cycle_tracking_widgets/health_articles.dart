import 'package:flutter/material.dart';

class HealthArticles extends StatelessWidget {
  const HealthArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Menstrual health',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View more'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildArticleCard(
                'assets/sweets.jpg',
                'Craving sweets on your period? Here\'s why & what to do about it',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildArticleCard(
                'assets/pills.jpg',
                'Is birth control good for your menstrual health?',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleCard(String imagePath, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey[300],
              // Image would go here in a real app
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}