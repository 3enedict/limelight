import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/variation.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/gradients.dart';

class VariationPickerPage extends StatefulWidget {
  final int recipeId;

  const VariationPickerPage({super.key, required this.recipeId});

  @override
  State<VariationPickerPage> createState() => VariationPickerPageState();
}

class VariationPickerPageState extends State<VariationPickerPage> {
  int _variationNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeModel, VariationModel>(
      builder: (context, recipes, variations, child) {
        final varNum = recipes.numberOfVariationGroups(widget.recipeId);
        if (_variationNumber > varNum - 1) {
          return Calendar(
            recipeId: widget.recipeId,
            needToAskForVariations: false,
          );
        }

        final variationGroup = recipes.variationGroup(
          widget.recipeId,
          _variationNumber,
        );

        return EmptyPage(
          gradient: limelightGradient,
          child: Center(
            child: variationGroup.toVariationPicker(
              (variation) => setState(() {
                variations.add(widget.recipeId, variation.name);

                _variationNumber += 1;
              }),
            ),
          ),
        );
      },
    );
  }
}
