import 'dart:math';

import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';

class GradientCircle extends CustomPainter {
  final Offset center;
  GradientCircle({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect boundingBox = center & size;

    const LinearGradient gradient = LinearGradient(
      colors: limelightGradient,
      begin: Alignment.topCenter,
    );

    canvas.drawCircle(
      center,
      size.width,
      Paint()
        ..shader = gradient.createShader(boundingBox)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..colorFilter = const ColorFilter.mode(
          Colors.black26,
          BlendMode.srcOver,
        ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Circles extends StatelessWidget {
  final Widget child;

  const Circles({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const numberOfCircles = 4;

    final sectionHeight = (height + 2 * width) / numberOfCircles;

    return ClipRect(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            ...List.generate(
              numberOfCircles,
              (int index) {
                final dim = width + random.nextDouble() * width;
                final dx = -width + random.nextDouble() * width * 3;

                final rSecHeight = random.nextDouble() * sectionHeight;
                final dy = -width + rSecHeight + sectionHeight * index;

                return CustomPaint(
                  size: Size.square(dim / 2),
                  painter: GradientCircle(
                    center: Offset(dx, dy),
                  ),
                );
              },
            ),
            child,
          ],
        ),
      ),
    );
  }
}
