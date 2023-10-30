import 'package:flutter/material.dart';
import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/widgets/custom_text.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/widgets/variation_picker_dialog.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  final PageController controller;

  const RecipesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeModel, IngredientModel>(
      builder: (context, recipes, ingredients, child) {
        final variations = Provider.of<VariationModel>(context, listen: false);

        List<RecipeId?> ids = [];
        List<String> selected = ingredients.selected;

        RegExp regex = RegExp(r'\(.*\)');

        for (var i = 0; i < recipes.number; i++) {
          ids.add(null);

          final ing = recipes
              .recipe(i)
              .ingredients
              .map((e) => e.name.replaceAll(regex, ''))
              .toList();

          for (var s in selected) {
            if (ing.contains(s)) {
              ids[i] = RecipeId(recipeId: i);
              break;
            }
          }

          if (ids[i] == null) {
            for (var groupId = 0;
                groupId < recipes.numberOfVariationGroups(i);
                groupId++) {
              for (var varId = 0;
                  varId < recipes.numberOfVariations(i, groupId);
                  varId++) {
                final ing = recipes
                    .variation(i, groupId, varId)
                    .ingredients
                    .map((e) => e.name.replaceAll(regex, ''))
                    .toList();

                for (var s in selected) {
                  if (ing.contains(s)) {
                    List<int> vIds =
                        List.filled(recipes.numberOfVariationGroups(i), 0);
                    vIds[groupId] = varId;

                    variations.setLocal(i, groupId, varId);

                    ids[i] = RecipeId(recipeId: i, variationIds: vIds);
                    break;
                  }
                }

                if (ids[i] != null) break;
              }

              if (ids[i] != null) break;
            }
          }
        }

        ids.removeWhere((e) => e == null);

        final pages = ids.isEmpty
            ? [
                const EmptyPage(
                  child: Center(
                    child: CustomText(text: 'No recipes found...'),
                  ),
                ),
              ]
            : List.generate(
                ids.length,
                (int index) {
                  return EmptyPage(
                    appBarText: recipes.name(index),
                    child: Column(
                      children: [
                        Expanded(
                          child: Content(
                            recipeId: ids[index]!.recipeId,
                            recipes: recipes,
                          ),
                        ),
                        ActionButtons(
                          recipeId: ids[index]!.recipeId,
                          recipes: recipes,
                          controller: controller,
                        ),
                      ],
                    ),
                  );
                },
              );

        return PageView(children: pages);
      },
    );
  }
}

class Content extends StatelessWidget {
  final int recipeId;
  final RecipeModel recipes;

  const Content({
    super.key,
    required this.recipeId,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Consumer2<VariationModel, PreferencesModel>(
        builder: (context, variations, preferences, child) {
          final width = MediaQuery.of(context).size.width - 20 * 2 * 2;

          final vIds = variations.variationIds(recipeId);
          final servings = (preferences.nbServingsLocal(recipeId)).abs();

          final ingredients = recipes.ingredientList(recipeId, servings, vIds);
          final instructions = recipes.instructionSet(recipeId, servings, vIds);

          return Center(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.5,
                  ),
                  child: RecipeDescriptionBox(
                    label: "Ingredients",
                    items: generateIngredients(ingredients),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: RecipeDescriptionBox(
                    label: "Instructions",
                    items: generateInstructions(instructions, width),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final int recipeId;
  final RecipeModel recipes;
  final PageController controller;

  const ActionButtons({
    super.key,
    required this.recipeId,
    required this.recipes,
    required this.controller,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: toBackgroundGradient(limelightGradient)[1],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return VariationPickerDialog(
                    recipeId: widget.recipeId,
                    recipes: widget.recipes,
                  );
                },
              ),
              child: Center(
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.layers,
                ),
              ),
            ),
            const SizedBox(width: 53 / 3),
            Consumer2<PreferencesModel, VariationModel>(
              builder: (context, preferences, variations, child) {
                List<int> vIds = [];

                final ids = variations.variationIds(widget.recipeId);
                for (var (groupId, variationId) in ids) {
                  while (!(vIds.length > groupId)) {
                    vIds.add(0);
                  }

                  vIds[groupId] = variationId;
                }

                preferences.setFinalScreenId(
                  RecipeId(
                    recipeId: widget.recipeId,
                    servings: preferences.nbServingsLocal(widget.recipeId),
                    variationIds: vIds,
                  ),
                );

                return GradientButton(
                  diameter: 53,
                  gradient:
                      limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
                  onPressed: () {
                    preferences.setFinalScreenIsCalendar(true);

                    widget.controller.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Center(
                    child: GradientIcon(
                      gradient: toSurfaceGradient(limelightGradient),
                      icon: UniconsLine.calender,
                      size: 26,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 53 / 3),
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () {
                final preferences =
                    Provider.of<PreferencesModel>(context, listen: false);

                preferences.setFinalScreenIsCalendar(false);

                widget.controller.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: const Center(
                child: GradientIcon(
                  gradient: limelightGradient,
                  icon: UniconsLine.shopping_basket,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
