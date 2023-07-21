import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class IngredientSubPage extends StatelessWidget {
  final int recipeId;
  final List<String> variations;

  const IngredientSubPage({
    super.key,
    required this.recipeId,
    required this.variations,
  });

  @override
  Widget build(BuildContext context) {
    final variationGroups = recipes[recipeId].variationGroups;

    List<CompactItem> ingredients = [];
    for (var ingredient in recipes[recipeId].ingredients) {
      ingredients.add(ingredient.toCompactItem(() {}));
    }

    for (var i = 0; i < variations.length; i++) {
      for (var variation in variationGroups[i].variations) {
        if (variations[i] == variation.name) {
          for (var ingredient in variation.ingredients) {
            ingredients.add(ingredient.toCompactItem(() {}));
          }
        }
      }
    }

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Ingredients",
              titleBackground: const AssetImage('assets/Ingredient.jpg'),
              gradient: fishGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ingredients[index];
                  },
                  childCount: ingredients.length,
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
