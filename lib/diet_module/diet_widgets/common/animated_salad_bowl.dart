import 'package:flutter/material.dart';

class AnimatedSaladBowl extends StatelessWidget {
  const AnimatedSaladBowl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: Image.asset(
        'assets/images/salad_bowl.gif',
        fit: BoxFit.contain,
      ),
    );
  }
}