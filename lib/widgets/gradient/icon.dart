import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientIcon extends StatelessWidget {
  final List<Color> gradient;
  final IconData icon;

  const GradientIcon({
    super.key,
    this.gradient = limelightGradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
        ).createShader(bounds);
      },
      child: Icon(icon, color: Colors.white),
    );
  }
}
