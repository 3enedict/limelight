import 'package:flutter/material.dart';
import 'package:limelight/pages/meal_list_page.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/shopping_list_model.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/pages/settings_page.dart';
import 'package:limelight/pages/recipe_page.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/pages/home_page.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        // Don't forget to call load() if need be in loadModelDataFromLocalFiles() at the bottom of this file
        ChangeNotifierProvider(create: (context) => IngredientModel()),
        ChangeNotifierProvider(create: (context) => RecipeModel()),
        ChangeNotifierProvider(create: (context) => CalendarModel()),
        ChangeNotifierProvider(create: (context) => ShoppingListModel()),
        ChangeNotifierProvider(create: (context) => PreferencesModel()),
      ],
      child: const Limelight(),
    ),
  );
}

class Limelight extends StatefulWidget {
  const Limelight({super.key});

  @override
  LimelightState createState() => LimelightState();
}

class LimelightState extends State<Limelight> {
  final _controller = PageController(initialPage: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadModelDataFromLocalFiles(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: textColor(),
          selectionColor: modifyColor(limelightGradient[1], 0.4, 0.5),
          selectionHandleColor: modifyColor(limelightGradient[1], 0.7, 0.7),
        ),
      ),
      home: Consumer4<IngredientModel, RecipeModel, CalendarModel,
          PreferencesModel>(
        builder: (context, ingredients, recipes, calendar, preferences, child) {
          List<Widget> pages = [];

          if (ingredients.selected.isEmpty && preferences.planner == 0) {
            final meals = calendar.getFutureMeals();
            final scheduledRecipes = meals.values.isEmpty
                ? [
                    EmptyPage(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CustomText(
                          text: words['noIngredientSelected']![0],
                          alignement: TextAlign.center,
                        ),
                      ),
                    )
                  ]
                : meals.entries.map(
                    (e) {
                      final ids =
                          e.key.split(':').map((e) => int.parse(e)).toList();

                      final date = DateTime.utc(ids[0], ids[1], ids[2]);
                      final meal = ids[3] == 0 ? 'midi' : 'soir';

                      return EmptyPage(
                        appBar: GradientAppBar(
                          gradient: limelightGradient,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 19),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: recipes.name(e.value.recipeId),
                                  alignement: TextAlign.center,
                                  size: 20,
                                  weight: FontWeight.w700,
                                ),
                                const SizedBox(height: 1),
                                CustomText(
                                  text:
                                      '${words["${date.weekday - 1}"]![0]} $meal',
                                  alignement: TextAlign.center,
                                  size: 16,
                                  weight: FontWeight.w500,
                                  style: FontStyle.italic,
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: Content(id: e.value),
                      );
                    },
                  ).toList();

            pages = scheduledRecipes;
          } else if (ingredients.selected.isEmpty && preferences.planner == 1) {
            pages = [const MealListPage()];
          } else {
            List<RecipeId?> matches = recipes.search(
              ingredients.namesOfSelected,
              preferences.nbServings,
            );

            if (preferences.planner == 0) {
              final now = DateTime.now();
              for (var i = 30; i > 0; i--) {
                final iDaysAgo = now.subtract(Duration(days: i));
                String id =
                    "${iDaysAgo.year}:${iDaysAgo.month}:${iDaysAgo.day}:1";
                if (calendar.mealIds[id] != null &&
                    matches[calendar.mealIds[id]!.recipeId] != null) {
                  matches.add(matches[calendar.mealIds[id]!.recipeId]);
                  matches[calendar.mealIds[id]!.recipeId] = null;
                }

                id = "${iDaysAgo.year}:${iDaysAgo.month}:${iDaysAgo.day}:0";
                if (calendar.mealIds[id] != null &&
                    matches[calendar.mealIds[id]!.recipeId] != null) {
                  matches.add(matches[calendar.mealIds[id]!.recipeId]);
                  matches[calendar.mealIds[id]!.recipeId] = null;
                }
              }
            }

            matches.removeWhere((e) => e == null);

            final proposals = matches.isEmpty
                ? [
                    EmptyPage(
                      child: CustomText(
                        text: words['noIngredientsFound']![0],
                        alignement: TextAlign.center,
                      ),
                    )
                  ]
                : matches
                    .map((e) => RecipePage(key: Key('$e'), id: e!))
                    .toList();

            pages = proposals;
          }

          return PageView(
            controller: _controller,
            children: [
              const SettingsPage(),
              HomePage(pageController: _controller),
              ...pages,
            ],
          );
        },
      ),
    );
  }
}

void loadModelDataFromLocalFiles(BuildContext context) {
  Provider.of<IngredientModel>(context, listen: false).load();
  Provider.of<RecipeModel>(context, listen: false).load();
  Provider.of<CalendarModel>(context, listen: false).load();
  Provider.of<ShoppingListModel>(context, listen: false).load();
  Provider.of<PreferencesModel>(context, listen: false).load();
}
