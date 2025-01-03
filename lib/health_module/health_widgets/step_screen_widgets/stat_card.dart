import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../health_services/step_services/step_tracking_service.dart';

class StatCard extends StatelessWidget {
  final String type;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.type,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: StepTrackingService().stepStream,
      builder: (context, snapshot) {
        final steps = snapshot.data ?? 0;
        final service = StepTrackingService();

        String value = '';
        String unit = '';
        double progress = 0.0;

        switch (type) {
          case 'calories':
            final calories = service.calculateCalories();
            value = calories.toStringAsFixed(0);
            unit = 'kcal';
            progress = calories / 1000; // Assuming 1000 kcal is the goal
            break;
          case 'distance':
            final miles = service.calculateMiles();
            value = miles.toStringAsFixed(1);
            unit = 'miles';
            progress = miles / 5; // Assuming 10km is the goal
            break;
          case 'duration':
            final duration = service.calculateDuration();
            value = duration.toStringAsFixed(0);
            unit = 'min';
            progress = duration / 60; // Assuming 180 min is the goal
            break;
        }

        return Container(
          width: MediaQuery.of(context).size.width * 0.28,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: CircularProgressPainter(
                    progress: progress,
                    color: color,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: color, size: 24),
                        const SizedBox(height: 8),
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 0),
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  CircularProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 8;
    final strokeWidth = 8.0;

    // Background ring (full circle with low opacity)
    final backgroundPaint = Paint()
      ..color =
          color.withValues(alpha: 0.1) // Very low opacity for background ring
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Progress ring
    final progressPaint = Paint()
      ..color =
          color.withValues(alpha: 0.7) // Slightly more opaque for the progress
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Draw full background ring
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
