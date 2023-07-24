import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/items/compact_item.dart';

import 'package:provider/provider.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/variation.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/gradients.dart';

class VariationPickerPage extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;

  const VariationPickerPage({
    super.key,
    required this.recipeId,
    this.variationGroupId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeModel, VariationModel>(
      builder: (context, recipes, variations, child) {
        var groupId = variationGroupId ??
            variations.findUninitializedVariation(
              recipeId,
              recipes.numberOfVariationGroups(recipeId),
            );

        if (groupId == -1) Navigator.of(context).pop();

        final variationGroup = recipes.variationGroup(
          recipeId,
          groupId,
        );

        List<CompactItem> variationButtons = [];
        for (var id = 0; id < variationGroup.variations.length; id++) {
          variationButtons.add(
            variationGroup.variations[id].toCompactItem(
              () {
                variations.add(recipeId, groupId, id);
                if (variationGroupId != null) Navigator.of(context).pop();
              },
            ),
          );
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
                      variationGroup.groupName,
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
