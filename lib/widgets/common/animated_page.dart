import 'package:flutter/material.dart';

class AnimatedPage extends StatelessWidget {
  final Widget child;
  final int index;

  const AnimatedPage({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(index),
      child: child,
    );
  }
}