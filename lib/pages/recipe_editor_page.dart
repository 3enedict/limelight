import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class RecipeEditor extends StatelessWidget {
  final int recipeId;

  const RecipeEditor({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        List<Widget> items = [];
        for (var i = 0; i < recipes.recipe(recipeId).ingredients.length; i++) {
          items.add(Padding(
              padding: const EdgeInsets.fromLTRB(42, 10, 42, 0),
              child: IngredientItem(
                recipeId: recipeId,
                ingredientId: i,
              )));
        }

        for (var i = 0; i < recipes.nbVarGroups(recipeId); i++) {
          for (var j = 0; j < recipes.nbVariations(recipeId, i); j++) {
            final num = recipes
                .recipe(recipeId)
                .variationGroups[i]
                .variations[j]
                .ingredients
                .length;

            items.add(
              Section(
                padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                label: recipes.variationName(recipeId, i, j),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      ...List.generate(
                        num,
                        (index) => IngredientItem(
                          recipeId: recipeId,
                          variationGroupId: i,
                          variationId: j,
                          ingredientId: index,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        return EmptyPage(
          resizeToAvoidBottomInset: true,
          appBarText: recipes.name(recipeId),
          child: ListView(
            children: items,
          ),
        );
      },
    );
  }
}

class IngredientItem extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int ingredientId;

  const IngredientItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    required this.ingredientId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        IngredientData ingredient = IngredientData.empty();
        if (variationGroupId == null || variationId == null) {
          ingredient = recipes.recipe(recipeId).ingredient(ingredientId);
        } else {
          ingredient = recipes
              .recipe(recipeId)
              .variationGroups[variationGroupId!]
              .variation(variationId!)
              .ingredient(ingredientId);
        }

        return Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
              child: GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (text) {
                  IngredientData ing = IngredientData.from(ingredient);
                  ing.name = text;
                  edit(recipes, ing);
                },
                controller: TextEditingController(text: ingredient.name),
                style: GoogleFonts.openSans(color: textColor()),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextField(
                  textAlign: TextAlign.right,
                  onSubmitted: (text) {
                    IngredientData ing = IngredientData.from(ingredient);

                    if (text == 'some') {
                      ing.quantity = 1;
                      ing.unit = 'some';
                    } else {
                      var reg = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
                      ing.quantity = reg
                          .allMatches(text)
                          .map((e) => e[0] == null ? 0.0 : double.parse(e[0]!))
                          .toList()[0];

                      ing.unit = text.replaceAll(reg, '');
                    }

                    edit(recipes, ing);
                  },
                  controller: TextEditingController(
                    text: ingredient.unit == 'some'
                        ? 'some'
                        : '${ingredient.quantity}${ingredient.unit}',
                  ),
                  style: GoogleFonts.openSans(
                    color: textColor().withOpacity(0.6),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void edit(RecipeModel recipes, IngredientData ing) {
    if (variationGroupId == null || variationId == null) {
      recipes.editIngredient(recipeId, ingredientId, ing);
    } else {
      recipes.editVarIngredient(
          recipeId, variationGroupId!, variationId!, ingredientId, ing);
    }
  }
}
