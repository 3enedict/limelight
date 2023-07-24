import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/data/variation.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class IngredientSubPage extends StatelessWidget {
  final int recipeId;

  const IngredientSubPage({
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
              title: "Ingredients",
              titleBackground: const AssetImage('assets/Ingredient.jpg'),
              gradient: limelightGradient,
              items: Consumer2<RecipeModel, VariationModel>(
                builder: (context, recipes, variations, child) {
                  final recipe = recipes.recipe(recipeId);
                  final variationGroups = recipe.variationGroups;
                  final variationList = variations.variationList(recipeId);

                  List<CompactItem> ingredients = [];
                  for (var ingredient in recipe.ingredients) {
                    ingredients.add(ingredient.toCompactItem(() {}));
                  }

                  for (var i = 0; i < variationList.length - 1; i++) {
                    for (var variation in variationGroups[i].variations) {
                      if (variationList[i] == variation.name) {
                        for (var ingredient in variation.ingredients) {
                          ingredients.add(ingredient.toCompactItem(() {}));
                        }
                      }
                    }
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ingredients[index];
                      },
                      childCount: ingredients.length,
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
