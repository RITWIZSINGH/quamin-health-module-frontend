import 'package:flutter/material.dart';

class HealthDataItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final VoidCallback onTap;

  const HealthDataItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
