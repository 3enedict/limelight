import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/page.dart';

class RecipeView extends StatelessWidget {
  final RecipeId id;
  final RecipeModel recipes;

  const RecipeView({
    super.key,
    required this.id,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: recipes.name(id.recipeId),
      child: Content(
        id: id,
        recipes: recipes,
      ),
    );
  }
}

class Content extends StatelessWidget {
  final RecipeId id;
  final RecipeModel recipes;

  const Content({
    super.key,
    required this.id,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20 * 2 * 2;

    final ingredients = recipes.ingredientList(id);
    final instructions = recipes.instructionSet(id);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Center(
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
      ),
    );
  }
}

/*
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
*/
