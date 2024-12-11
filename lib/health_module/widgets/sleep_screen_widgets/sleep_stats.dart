import 'package:flutter/material.dart';
import '../../models/sleep_data.dart';

class SleepStats extends StatelessWidget {
  final SleepData data;

  const SleepStats({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStat(
          '⭐ Sleep rate',
          '${data.sleepRate.round()}%',
        ),
        _buildStat(
          '😴 Deepsleep',
          '${data.deepSleepMinutes ~/ 60}h ${data.deepSleepMinutes % 60}min',
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}