import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> gradient;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? diameter;
  final Widget child;

  const GradientContainer({
    super.key,
    this.gradient = limelightGradient,
    this.height,
    this.width,
    this.borderRadius = 20,
    this.diameter,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(diameter ?? borderRadius),
        boxShadow: [
          BoxShadow(
            color: modifyColor(gradient[1], 0.08, 0.1),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(1, 1),
          ),
        ],
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      height: diameter ?? height,
      width: diameter ?? width,
      child: child,
    );
  }
}
