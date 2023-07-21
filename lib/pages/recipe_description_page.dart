import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/pages/recipe_description_subpages/ingredient_page.dart';
import 'package:limelight/pages/recipe_description_subpages/recipe_page.dart';
import 'package:limelight/pages/recipe_description_subpages/variation_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/recipe.dart';

class RecipeDescriptionPage extends StatefulWidget {
  final int recipeId;

  const RecipeDescriptionPage({super.key, required this.recipeId});

  @override
  State<RecipeDescriptionPage> createState() => RecipeDescriptionPageState();
}

class RecipeDescriptionPageState extends State<RecipeDescriptionPage> {
  List<String>? _variations;

  @override
  void initState() {
    super.initState();
    getVariations(widget.recipeId).then(
      (variations) => setState(() {
        _variations = variations;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_variations == null) {
      return const EmptyPage();
    }

    return PageView(
      controller: PageController(
        initialPage: 1,
      ),
      children: [
        VariationSubPage(recipeId: widget.recipeId),
        IngredientSubPage(
          recipeId: widget.recipeId,
          variations: _variations!,
        ),
        RecipeSubPage(recipeId: widget.recipeId),
      ],
    );
  }
}
