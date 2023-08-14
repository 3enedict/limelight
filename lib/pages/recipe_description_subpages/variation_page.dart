import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/pages/variation_picker_page.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/transitions.dart';
import 'package:limelight/gradients.dart';

class VariationSubPage extends StatelessWidget {
  final int recipeId;

  const VariationSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      fab: GradientButton(
        diameter: 56,
        gradient: toSurfaceGradient(limelightGradient),
        onPressed: () => Navigator.of(context).pop(),
        padding: const EdgeInsets.all(0),
        child: const Center(
          child: Icon(
            Icons.restaurant_menu,
            color: Colors.white70,
          ),
        ),
      ),
      child: ItemList(
        title: "Variations",
        titleBackground: const AssetImage('assets/Variation.jpg'),
        gradient: limelightGradient,
        items: Consumer<RecipeModel>(
          builder: (context, recipes, child) {
            int num = recipes.numberOfVariationGroups(recipeId);
            List<Item> items = [];
            for (var i = 0; i < num; i++) {
              final group = recipes.variationGroup(recipeId, i);
              items.add(group.toItem(
                () => fadeTransition(
                  context,
                  VariationPickerPage(
                    recipeId: recipeId,
                    groupId: i,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ));
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return items[index];
                },
                childCount: items.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
