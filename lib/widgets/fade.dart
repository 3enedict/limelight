import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class Fade extends StatelessWidget {
  final List<Color> gradient;
  final Widget child;

  const Fade({
    super.key,
    this.gradient = limelightGradient,
    this.child = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final Color color = toSurfaceGradient(gradient)[1];

    return ShaderMask(
      shaderCallback: (bound) {
        return LinearGradient(
            end: FractionalOffset.topCenter,
            begin: FractionalOffset.bottomCenter,
            colors: [
              color.withAlpha(220),
              color.withAlpha(0),
            ],
            stops: const [
              0.0,
              0.3,
            ]).createShader(bound);
      },
      blendMode: BlendMode.srcOver,
      child: child,
    );
  }
}
