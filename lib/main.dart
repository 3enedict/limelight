import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_view.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/pages/home_page.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        // Don't forget to call load() if need be in loadModelDataFromLocalFiles() at the bottom of this file
        ChangeNotifierProvider(create: (context) => IngredientModel()),
        ChangeNotifierProvider(create: (context) => RecipeModel()),
      ],
      child: const Limelight(),
    ),
  );
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

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
      home: Consumer2<IngredientModel, RecipeModel>(
        builder: (context, ingredients, recipes, child) {
          final matches = recipes.search(ingredients.namesOfSelected);

          final pages = matches.isEmpty
              ? [
                  const EmptyPage(
                    child: Center(
                      child: CustomText(text: 'No recipes found...'),
                    ),
                  ),
                ]
              : matches
                  .map((e) => RecipeView(id: e, recipes: recipes))
                  .toList();

          return PageView(
            children: [const HomePage(), ...pages],
          );
        },
      ),
    );
  }
}

void loadModelDataFromLocalFiles(BuildContext context) {
  Provider.of<IngredientModel>(context, listen: false).load();
  Provider.of<RecipeModel>(context, listen: false).load();
}
