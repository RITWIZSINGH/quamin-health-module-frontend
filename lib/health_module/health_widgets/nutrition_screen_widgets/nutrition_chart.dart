import 'package:flutter/material.dart';
import 'dart:math';

class NutritionChart extends StatelessWidget {
  final double fatPercentage;
  final double proteinPercentage;
  final double carbsPercentage;

  const NutritionChart({
    super.key,
    required this.fatPercentage,
    required this.proteinPercentage,
    required this.carbsPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Increased height to accommodate more space
      child: CustomPaint(
        painter: NutritionRingPainter(
          fatPercentage: fatPercentage,
          proteinPercentage: proteinPercentage,
          carbsPercentage: carbsPercentage,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 10), // Added space above the text
              Text(
                '60%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'of 1300 kcal',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutritionRingPainter extends CustomPainter {
  final double fatPercentage;
  final double proteinPercentage;
  final double carbsPercentage;

  NutritionRingPainter({
    required this.fatPercentage,
    required this.proteinPercentage,
    required this.carbsPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.375;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    _drawBackgroundRings(canvas, center, radius, paint);
    _drawProgressRings(canvas, center, radius, paint);
  }

  void _drawBackgroundRings(
      Canvas canvas, Offset center, double radius, Paint paint) {
    paint.color = Colors.grey[200]!;

    for (int i = 0; i < 3; i++) {
      final currentRadius = radius - (20.0 + 5.0) * i;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: currentRadius),
        -1.57,
        2 * pi,
        false,
        paint,
      );
    }
  }

  void _drawProgressRings(
      Canvas canvas, Offset center, double radius, Paint paint) {
    // Fat ring
    paint.color = const Color(0xff878ced);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      2 * pi * fatPercentage,
      false,
      paint,
    );

    // Protein ring
    paint.color = const Color(0xffefa98d);
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius - 20.0 - 5.0,
      ),
      -1.57,
      2 * pi * proteinPercentage,
      false,
      paint,
    );

    // Carbs ring
    paint.color = const Color(0xff9d7ee7);
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius - (20.0 + 5.0) * 2,
      ),
      -1.57,
      2 * pi * carbsPercentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
