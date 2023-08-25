import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient/container.dart';

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
    return GradientContainer(
      gradient: gradient,
      height: height,
      width: width,
      borderRadius: borderRadius,
      diameter: diameter,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(diameter ?? borderRadius),
          ),
          splashColor: toTextGradient(gradient)[1].withOpacity(0.5),
          onTap: onPressed,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}
