import 'package:flutter/material.dart';

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
      height: 200,
      child: CustomPaint(
        painter: NutritionRingPainter(
          fatPercentage: fatPercentage,
          proteinPercentage: proteinPercentage,
          carbsPercentage: carbsPercentage,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '60%',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8), // Added spacing
              const Text(
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
    final radius = size.width * 0.35;
    final strokeWidth = 20.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Added rounded ends

    // Background rings
    paint.color = Colors.grey[200]!;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      6.28,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth - 5),
      -1.57,
      6.28,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth + 5) * 2),
      -1.57,
      6.28,
      false,
      paint,
    );

    // Progress rings
    paint.color = Colors.blue[400]!;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      6.28 * fatPercentage,
      false,
      paint,
    );

    paint.color = Colors.orange[300]!;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth - 5),
      -1.57,
      6.28 * proteinPercentage,
      false,
      paint,
    );

    paint.color = Colors.blue[200]!;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth + 5) * 2),
      -1.57,
      6.28 * carbsPercentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}