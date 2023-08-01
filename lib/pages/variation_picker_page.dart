import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/items/compact_item.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class VariationPickerPage extends StatelessWidget {
  final int recipeId;
  final int groupId;
  final VoidCallback? onPressed;

  const VariationPickerPage({
    super.key,
    required this.recipeId,
    required this.groupId,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeModel>(context, listen: false);
    final variations = Provider.of<VariationModel>(context, listen: false);

    int num = recipes.numberOfVariations(recipeId, groupId);
    List<CompactItem> variationButtons = [];
    for (var i = 0; i < num; i++) {
      Variation variation = recipes.variation(recipeId, groupId, i);
      CompactItem item = variation.toCompactItem(
        () {
          variations.set(recipeId, groupId, i);
          onPressed!();
        },
      );

      variationButtons.add(item);
    }

    return EmptyPage(
      gradient: limelightGradient,
      child: Center(
        child: GradientBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  recipes.variationGroup(recipeId, groupId).groupName,
                  style: GoogleFonts.workSans(
                    fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.2,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ...variationButtons,
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
