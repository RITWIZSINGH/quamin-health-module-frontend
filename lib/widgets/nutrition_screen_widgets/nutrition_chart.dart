import 'package:flutter/material.dart';

class NutritionChart extends StatelessWidget {
  const NutritionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: CustomPaint(
          painter: NutritionRingPainter(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 12,
                ),
                Text(
                  '60%',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'of 1300 kcal',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NutritionRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;
    final strokeWidth = 20.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Background rings
    paint.color = Colors.grey[200]!;
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius - strokeWidth - 5, paint);
    canvas.drawCircle(center, radius - (strokeWidth + 5) * 2, paint);

    // Progress rings
    final rect = Rect.fromCircle(center: center, radius: radius);
    final innerRect =
        Rect.fromCircle(center: center, radius: radius - strokeWidth - 5);
    final innermostRect =
        Rect.fromCircle(center: center, radius: radius - (strokeWidth + 5) * 2);

    paint.color = Color(0XFF878CED);
    canvas.drawArc(rect, -1.57, 3.14 * 1.24, false, paint);

    paint.color = Color(0xFFefa98d);
    canvas.drawArc(innerRect, -1.57, 3.14 * 1.12, false, paint);

    paint.color = Color(0XFF9D7EE7);
    canvas.drawArc(innermostRect, -1.57, 3.14 * 0.8, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
