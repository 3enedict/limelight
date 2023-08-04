import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/pages/recipes_page.dart';

void main() async {
  Paint.enableDithering = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          var model = RecipeModel();
          model.load();
          return model;
        }),
        ChangeNotifierProvider(create: (context) {
          var model = VariationModel();
          model.load();
          return model;
        }),
      ],
      child: const Limelight(),
    ),
  );
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
    // Build providers
    Provider.of<RecipeModel>(context);
    Provider.of<VariationModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      theme: ThemeData(useMaterial3: true),
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
