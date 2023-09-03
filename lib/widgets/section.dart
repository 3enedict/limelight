import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/gradients.dart';

class Section extends StatelessWidget {
  final List<Color> gradient;
  final String label;
  final Widget child;

  const Section({
    super.key,
    this.gradient = limelightGradient,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...generateLabel(label),
          GradientContainer(
            gradient: toSurfaceGradient(gradient),
            borderRadius: 20,
            child: child,
          ),
        ],
      ),
    );
  }
}

List<Widget> generateLabel(String label) {
  return [
    CustomText(
      text: " $label",
      opacity: 0.5,
      weight: FontWeight.w300,
    ),
    const SizedBox(height: 8),
  ];
}
