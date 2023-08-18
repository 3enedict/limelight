import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      fab: GradientButton(
        gradient: toSurfaceGradient(limelightGradient),
        diameter: 56,
        onPressed: () => print("Hello"),
        child: GradientIcon(
          gradient: toTextGradient(limelightGradient),
          icon: Icons.layers,
        ),
      ),
    );
  }
}
