import 'package:flutter/material.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/gradients.dart';

List<Widget> addDividers(List<Widget> items) {
  for (var i = items.length - 1; i > 0; i--) {
    items.insert(
      i,
      Divider(
        color: textColor().withOpacity(0.2),
        indent: 40,
        height: 0,
      ),
    );
  }

  return items;
}

List<Widget> generateIngredients(int recipeId, RecipeModel recipes) {
  var ingredientList = recipes.ingredientList(
    recipeId,
    generateVariations(recipes, recipeId),
  );

  List<Widget> ingredients = [];
  for (var ingredient in ingredientList) {
    ingredients.add(Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
          child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
        ),
        CustomText(text: ingredient.name),
        const Expanded(child: SizedBox()),
        CustomText(
          text: ingredient.quantity,
          opacity: 0.6,
          weight: FontWeight.w400,
        ),
      ],
    ));
  }

  return addDividers(ingredients);
}

List<Widget> generateInstructions(int recipeId, RecipeModel recipes) {
  var instructionList = recipes.instructionSet(
    recipeId,
    3,
    generateVariations(recipes, recipeId),
  );

  List<Widget> instructions = [];
  for (var instruction in instructionList) {
    instructions.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
        ),
        Flexible(
          child: CustomText(
            text: instruction,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            alignement: TextAlign.justify,
            size: 13,
            weight: FontWeight.w300,
          ),
        ),
      ],
    ));
  }

  return addDividers(instructions);
}

// This is a temporary measure...
List<(int, int)> generateVariations(RecipeModel recipes, int recipeId) {
  return List.generate(
    recipes.numberOfVariationGroups(recipeId),
    (int groupId) => (groupId, 0),
  );
}
