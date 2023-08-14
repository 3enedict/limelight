import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final List<Color> gradient;
  final double borderRadius;
  final double? height;
  final double? width;
  final double? diameter;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const GradientButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.gradient = limelightGradient,
    this.borderRadius = 20,
    this.height,
    this.width,
    this.diameter,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(diameter ?? borderRadius),
      ),
      color: Colors.transparent,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(diameter ?? borderRadius),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: diameter ?? height,
        width: diameter ?? width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(diameter ?? borderRadius),
            ),
          ),
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
