import 'package:flutter/material.dart';

import 'package:limelight/pages/recipe_description_subpages/ingredient_page.dart';
import 'package:limelight/pages/recipe_description_subpages/recipe_page.dart';
import 'package:limelight/pages/recipe_description_subpages/variation_page.dart';

class RecipeDescriptionPage extends StatefulWidget {
  final int recipeId;

  const RecipeDescriptionPage({super.key, required this.recipeId});

  @override
  State<RecipeDescriptionPage> createState() => RecipeDescriptionPageState();
}

class RecipeDescriptionPageState extends State<RecipeDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(
        initialPage: 1,
      ),
      children: [
        VariationSubPage(recipeId: widget.recipeId),
        IngredientSubPage(recipeId: widget.recipeId),
        RecipeSubPage(recipeId: widget.recipeId),
      ],
    );
  }
}
