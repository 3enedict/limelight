import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientIcon extends StatelessWidget {
  final List<Color> gradient;
  final VoidCallback? onPressed;
  final double? size;
  final double? weight;
  final double buttonPadding;
  final EdgeInsetsGeometry padding;
  final IconData icon;

  const GradientIcon({
    super.key,
    this.gradient = limelightGradient,
    this.onPressed,
    this.size,
    this.weight,
    this.buttonPadding = 10,
    this.padding = const EdgeInsets.all(0),
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Widget gradientIcon = ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
        ).createShader(bounds);
      },
      child: Icon(icon, size: size, color: Colors.white, weight: weight),
    );

    if (onPressed != null) {
      gradientIcon = InkWell(
        customBorder: const CircleBorder(),
        splashColor: toTextGradient(gradient)[1].withOpacity(0.25),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(buttonPadding),
          child: gradientIcon,
        ),
      );
    }

    return Padding(
      padding: padding,
      child: gradientIcon,
    );
  }
}
