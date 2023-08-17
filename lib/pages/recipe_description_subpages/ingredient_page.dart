import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/pages/ingredients_search_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/items/ingredient_data.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/transitions.dart';
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
        title: "Ingredients",
        titleBackground: const AssetImage('assets/Ingredient.jpg'),
        gradient: limelightGradient,
        items: Consumer2<RecipeModel, VariationModel>(
          builder: (context, recipes, variations, child) {
            List<IngredientData> ingredients = recipes.ingredientList(
              recipeId,
              variations.variationIds(recipeId),
            );

            var items = List<Widget>.from(
              ingredients
                  .map((e) => IngredientDataItem(
                        recipeId: recipeId,
                        ingredient: e,
                      ))
                  .toList(),
            );

            final pad = (MediaQuery.of(context).size.width - 80) / 2;
            items.add(
              Padding(
                padding: EdgeInsets.fromLTRB(pad, 25, pad, 0),
                child: GradientButton(
                  borderRadius: 23,
                  height: 46,
                  onPressed: () => fadeTransition(
                    context,
                    SearchPage(
                      onSubmitted: (desc) => recipes.addIngredient(
                        recipeId,
                        IngredientData(
                          name: desc.name,
                          quantity: "1",
                        ),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            );

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
