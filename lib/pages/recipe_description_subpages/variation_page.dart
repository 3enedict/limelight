import 'package:flutter/material.dart';
import 'package:limelight/pages/variation_picker_page.dart';
import 'package:limelight/transitions.dart';
import 'package:limelight/widgets/items/compact_item.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
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
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Variations",
              titleBackground: const AssetImage('assets/Variation.jpg'),
              gradient: limelightGradient,
              items: Consumer<RecipeModel>(
                builder: (context, recipes, child) {
                  int num = recipes.numberOfVariationGroups(recipeId);
                  List<CompactItem> items = [];
                  for (var i = 0; i < num; i++) {
                    final group = recipes.variationGroup(recipeId, i);
                    items.add(group.toCompactItem(
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
