import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/widgets/page.dart';

class CookingPage extends StatelessWidget {
  const CookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeModel, CalendarModel>(
      builder: (context, recipes, calendar, child) {
        List<RecipeId> ids = [];
        final meals = calendar.getFutureMeals;
        print(meals.keys);

        DateTime now = DateTime.now();
        for (var i = 0; i < 30; i++) {
          final day = now.add(Duration(days: i));
          final string = '${day.year}:${day.month}:${day.day}';
          print(string);
          if (meals.containsKey('$string:0')) ids.add(meals['$string:0']!);
          if (meals.containsKey('$string:1')) ids.add(meals['$string:1']!);
        }

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
                    appBarText: recipes.name(ids[index].recipeId),
                    child: Content(
                      recipeId: ids[index],
                      recipes: recipes,
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
  final RecipeId recipeId;
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

          final id = recipeId.recipeId;
          final servings = recipeId.servings;
          final vIds =
              recipeId.variationIds.mapIndexed((i, e) => (i, e)).toList();

          final ingredients = recipes.ingredientList(id, servings, vIds);
          final instructions = recipes.instructionSet(id, servings, vIds);

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
