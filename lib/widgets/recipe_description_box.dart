import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/gradients.dart';

class RecipeDescriptionBox extends StatelessWidget {
  final List<Widget> items;
  final bool reverse;

  const RecipeDescriptionBox({
    super.key,
    required this.items,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> localItems = items;

    if (reverse) {
      localItems = items.reversed.toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: GradientContainer(
        gradient: toSurfaceGradient(limelightGradient),
        borderRadius: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            reverse: reverse,
            children: addDividers(40, 0, localItems),
          ),
        ),
      ),
    );
  }
}
