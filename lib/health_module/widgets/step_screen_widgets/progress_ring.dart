// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:lucide_icons/lucide_icons.dart';

import '../../services/step_services/step_tracking_service.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final int steps;
  final int goal;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.steps,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: StepTrackingService().stepStream,
      builder: (context, snapshot) {
        final currentSteps = snapshot.data ?? 0;
        final currentProgress =
            currentSteps / StepTrackingService().currentGoal;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.5,
          child: CustomPaint(
            painter: ProgressRingPainter(progress: currentProgress),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LucideIcons.footprints,
                    color: Color(0xff636ae8),
                    size: 26,
                  ),
                  Text(
                    currentSteps.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Steps out of ${StepTrackingService().currentGoal ~/ 1000}k',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProgressRingPainter extends CustomPainter {
  final double progress;

  ProgressRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round;

    // Draw background ring
    paint.color = Colors.grey[200]!;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi,
      false,
      paint,
    );

    // Draw progress ring
    paint.color = Color(0xFF636AE8);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
