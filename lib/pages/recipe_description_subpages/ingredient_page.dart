import 'package:flutter/material.dart';
import 'package:limelight/data/json/ingredient.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/gradients.dart';

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
                  List<IngredientData> ingredients = recipes.ingredientList(
                    recipeId,
                    variations.variationIds(recipeId),
                  );

                  List<Item> items =
                      ingredients.map((e) => e.toItem(() {})).toList();

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
