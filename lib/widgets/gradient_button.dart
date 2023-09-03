import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_container.dart';

class GradientButton extends StatelessWidget {
  final List<Color> gradient;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? diameter;
  final EdgeInsetsGeometry? padding;
  final bool outlineBorder;
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
    this.outlineBorder = false,
    this.onPressed,
    this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        foregroundColor: textColor().withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(diameter ?? borderRadius),
        ),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
    );

    if (outlineBorder) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(diameter ?? borderRadius),
          border: Border.all(color: textColor().withOpacity(0.5)),
        ),
        height: diameter ?? height,
        width: diameter ?? width,
        child: button,
      );
    }

    return GradientContainer(
      gradient: gradient,
      height: height,
      width: width,
      borderRadius: borderRadius,
      diameter: diameter,
      child: button,
    );
  }
}
