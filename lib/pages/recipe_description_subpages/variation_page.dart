import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/pages/variation_picker_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/data/variation.dart';

class VariationSubPage extends StatelessWidget {
  final int recipeId;

  const VariationSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Variations",
              titleBackground: const AssetImage('assets/Variation.jpg'),
              gradient: limelightGradient,
              items: Consumer2<RecipeModel, VariationModel>(
                builder: (context, recipes, variations, child) {
                  final variationGroups =
                      recipes.recipe(recipeId).variationGroups;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final variationGroup = variationGroups[index];
                        return variationGroup.toCompactItem(
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  VariationPickerPage(
                                recipeId: recipeId,
                                variationGroupId: index,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: variationGroups.length,
                    ),
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: GradientBackButton(),
          ),
        ],
      ),
    );
  }
}
