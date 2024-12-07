import 'package:flutter/material.dart';

class SleepSummary extends StatelessWidget {
  const SleepSummary({super.key});

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
                    text: '7h 31min',
                    style: TextStyle(
                      color: Colors.blue[400],
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
