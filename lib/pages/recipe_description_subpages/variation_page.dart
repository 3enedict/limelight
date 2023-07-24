import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/gradients.dart';
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
    final variationGroup = Provider.of<RecipeModel>(context, listen: false)
        .recipe(recipeId)
        .variationGroups;

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Variations",
              titleBackground: const AssetImage('assets/Variation.jpg'),
              gradient: limelightGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: variationGroup[index]
                            .toVariationPicker((variation) {
                          Provider.of<VariationModel>(context)
                              .add(recipeId, variation.name);
                        }),
                      ),
                    );
                  },
                  childCount: variationGroup.length,
                ),
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
