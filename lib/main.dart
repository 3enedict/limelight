import 'package:flutter/material.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/recipes_page.dart';

void main() async {
  Paint.enableDithering = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeModel()),
        ChangeNotifierProvider(create: (context) => IngredientModel()),
        ChangeNotifierProvider(create: (context) => VariationModel()),
        ChangeNotifierProvider(create: (context) => CalendarModel()),
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
      theme: ThemeData.dark(useMaterial3: true),
      home: PageView(
        controller: PageController(
          initialPage: 1,
        ),
        children: const [
          ShoppingListPage(),
          IngredientsPage(),
          RecipesPage(),
        ],
      ),
    );
  }
}

void loadModelDataFromLocalFiles(BuildContext context) {
  Provider.of<RecipeModel>(context, listen: false).load();
  Provider.of<IngredientModel>(context, listen: false).load();
  Provider.of<VariationModel>(context, listen: false).load();
  Provider.of<CalendarModel>(context, listen: false).load();
}
