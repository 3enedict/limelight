import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/gradients.dart';

class RecipeDescriptionBox extends StatelessWidget {
  final String label;
  final List<Widget> items;

  const RecipeDescriptionBox({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(text: ' $label', opacity: 0.5, weight: FontWeight.w300),
        const SizedBox(height: 7),
        Flexible(
          child: GradientContainer(
            gradient: toSurfaceGradient(limelightGradient),
            borderRadius: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: addDividers(items),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
