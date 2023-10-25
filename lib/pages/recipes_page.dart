import 'package:flutter/material.dart';
import 'package:limelight/pages/shopping_list_page.dart';

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
import 'package:limelight/main.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        final pages = List.generate(
          recipes.number,
          (int index) {
            return EmptyPage(
              appBarText: recipes.name(index),
              child: Column(
                children: [
                  Expanded(child: Content(recipeId: index, recipes: recipes)),
                  ActionButtons(recipeId: index, recipes: recipes),
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

  const ActionButtons({
    super.key,
    required this.recipeId,
    required this.recipes,
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
            GradientButton(
              diameter: 53,
              gradient:
                  limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
              onPressed: () =>
                  goto(context, CalendarPage(recipeId: widget.recipeId)),
              child: Center(
                child: GradientIcon(
                  gradient: toSurfaceGradient(limelightGradient),
                  icon: UniconsLine.calender,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 53 / 3),
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () => goto(context, const ShoppingListPage()),
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
