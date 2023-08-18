import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: GradientIcon(
            gradient: toTextGradient(limelightGradient),
            icon: Icons.expand_less,
          ),
        ),
      ),
    );
  }
}
