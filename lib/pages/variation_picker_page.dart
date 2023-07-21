import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/items/compact_item.dart';
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
    if (_variationNumber >
        recipes[widget.recipeId].variationGroups.length - 1) {
      return Calendar(
        recipeId: widget.recipeId,
      );
    }

    var variationGroup =
        recipes[widget.recipeId].variationGroups[_variationNumber];

    List<CompactItem> variationButtons = [];
    for (var variation in variationGroup.variations) {
      variationButtons.add(
        variation.toCompactItem(
          () => setState(() {
            setVariation(widget.recipeId, variation.name);
            _variationNumber += 1;
          }),
        ),
      );
    }

    return EmptyPage(
      gradient: limelightGradient,
      child: Center(
        child: variationGroup.toVariationPicker(
          (variation) => setState(() {
            setVariation(widget.recipeId, variation.name);
            _variationNumber += 1;
          }),
        ),
      ),
    );
  }
}
