import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> gradient;
  final List<Color>? borderGradient;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? diameter;
  final Widget child;

  const GradientContainer({
    super.key,
    this.gradient = limelightGradient,
    this.borderGradient,
    this.height,
    this.width,
    this.borderRadius,
    this.diameter,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(diameter ?? borderRadius ?? 0),
        boxShadow: [
          BoxShadow(
            color: modifyColor(gradient[1], 0.08, 0.1),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
        ],
        gradient: LinearGradient(
          colors: borderGradient ?? gradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      height: diameter ?? height,
      width: diameter ?? width,
      child: borderGradient == null
          ? child
          : Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    diameter ?? borderRadius ?? 0,
                  ),
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: child,
              ),
            ),
    );
  }
}
