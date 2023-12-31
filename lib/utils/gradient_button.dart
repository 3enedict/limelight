import 'package:flutter/material.dart';

import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/gradients.dart';

class GradientButton extends StatelessWidget {
  final List<Color> gradient;
  final Alignment begin;
  final Alignment end;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? diameter;
  final EdgeInsetsGeometry? padding;
  final bool outlineBorder;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool ink;
  final Widget child;

  const GradientButton({
    super.key,
    this.gradient = limelightGradient,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.height,
    this.width,
    this.borderRadius = 20,
    this.diameter,
    this.padding,
    this.outlineBorder = false,
    this.onPressed,
    this.onLongPress,
    this.ink = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final button = TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        splashFactory: ink ? null : NoSplash.splashFactory,
        foregroundColor: ink ? textColor().withOpacity(0.25) : null,
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
      begin: begin,
      end: end,
      height: height,
      width: width,
      borderRadius: borderRadius,
      diameter: diameter,
      child: button,
    );
  }
}
