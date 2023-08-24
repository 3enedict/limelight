import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientIcon extends StatelessWidget {
  final List<Color> gradient;
  final VoidCallback? onPressed;
  final double? size;
  final double padding;
  final IconData icon;

  const GradientIcon({
    super.key,
    this.gradient = limelightGradient,
    this.onPressed,
    this.size,
    this.padding = 10,
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
      child: Icon(icon, size: size, color: Colors.white),
    );

    if (onPressed != null) {
      gradientIcon = InkWell(
        customBorder: const CircleBorder(),
        splashColor: toTextGradient(gradient)[1].withOpacity(0.5),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: gradientIcon,
        ),
      );
    }

    return gradientIcon;
  }
}
