import 'package:flutter/material.dart';
import '../../models/sleep_data.dart';

class SleepSummary extends StatelessWidget {
  final SleepData data;

  const SleepSummary({
    super.key,
    required this.data,
  });

  String _formatDuration(double hours) {
    final totalMinutes = (hours * 60).round();
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    return '${h}h ${m}min';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your average time of',
              style: TextStyle(fontSize: 18),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 24),
                children: [
                  const TextSpan(
                    text: 'sleep a day is ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: _formatDuration(data.hours),
                    style: const TextStyle(
                      color: Color(0xFF888CEF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}