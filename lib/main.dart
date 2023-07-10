import 'package:flutter/material.dart';

import 'package:limelight/pages/ingredients_page.dart';
import 'package:limelight/pages/shopping_list_page.dart';
import 'package:limelight/pages/recipes_page.dart';
import 'package:limelight/widgets/data/recipe.dart';

List<RecipeData> recipes = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  recipes = await loadAllRecipes();

  Paint.enableDithering = true;
  runApp(const Limelight());
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
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
