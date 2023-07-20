import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientBox extends StatelessWidget {
  final List<Color> gradient;
  final double borderRadius;
  final double? height;
  final double? width;
  final Widget child;

  const GradientBox({
    super.key,
    this.gradient = limelightGradient,
    this.borderRadius = 20,
    this.height,
    this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: toBackgroundGradient(gradient),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
