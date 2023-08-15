import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/page.dart';

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
    return EmptyPage(
      child: Center(
        child: GradientBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Consumer2<RecipeModel, VariationModel>(
            builder: (context, recipes, variations, child) {
              int num = recipes.numberOfVariations(recipeId, groupId);
              List<Item> variationButtons = [];
              for (var i = 0; i < num; i++) {
                Item item = recipes.variation(recipeId, groupId, i).toItem(
                  () {
                    variations.set(recipeId, groupId, i);
                    if (onPressed != null) onPressed!();
                  },
                );

                variationButtons.add(item);
              }

              final name = recipes.variationGroup(recipeId, groupId).groupName;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      name,
                      style: GoogleFonts.workSans(
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 1.2,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ...variationButtons,
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
