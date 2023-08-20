import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientButton extends StatelessWidget {
  final List<Color> gradient;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? diameter;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget child;

  const GradientButton({
    super.key,
    this.gradient = limelightGradient,
    this.height,
    this.width,
    this.borderRadius = 20,
    this.diameter,
    this.padding,
    this.onPressed,
    this.onLongPress,
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
            offset: const Offset(0.5, 0.5),
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
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: diameter == null ? padding : const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(diameter ?? borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
