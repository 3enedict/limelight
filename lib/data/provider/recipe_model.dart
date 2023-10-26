import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:limelight/data/provider/utils.dart';
import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/recipe.dart';

class RecipeModel extends ChangeNotifier {
  List<RecipeData> _recipes = [];

  void load() {
    if (_recipes.isEmpty) {
      rootBundle.loadString("assets/recipes.json").then(
        (jsonData) {
          final parsedJson = jsonDecode(jsonData);

          _recipes = loadRecipes(parsedJson);
        },
      );
    }
  }

  void add(RecipeData recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void removeIngredient(int recipeId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.ingredients.remove(ingredient);
    notifyListeners();
  }

  void addIngredient(int recipeId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.ingredients.add(ingredient);
    notifyListeners();
  }

  List<IngredientData> ingredientList(
    int recipeId,
    int numberOfServings,
    List<(int, int)> variationIds,
  ) {
    List<IngredientData> ingredientList =
        List.from(recipe(recipeId).ingredients);

    final nbVarGrps = numberOfVariationGroups(recipeId);

    if (variationIds.isEmpty) {
      variationIds = List.generate(nbVarGrps, (int index) => (index, 0));
    }

    if (variationIds.length != nbVarGrps) {
      List<int> ids = List.generate(nbVarGrps, (int index) => index);

      for (var (gId, _) in variationIds) {
        ids.remove(gId);
      }

      variationIds = variationIds + ids.map((e) => (e, 0)).toList();
    }

    for (var variationIdTuple in variationIds) {
      var variationGroupId = variationIdTuple.$1;
      var variationId = variationIdTuple.$2;

      ingredientList.addAll(
        variation(recipeId, variationGroupId, variationId).ingredients,
      );
    }

    return ingredientList.map(
      (e) {
        String quantity = computeIngredientQuantities(numberOfServings, e);

        if (quantity.contains('of')) {
          quantity = quantity.split(' of ')[0];
        } else {
          quantity = quantity.split(' ')[0];
        }

        return IngredientData(
          name: e.name,
          quantity: quantity,
        );
      },
    ).toList();
  }

  List<String> instructionSet(
    int recipeId,
    int numberOfServings,
    List<(int, int)> variationIds,
  ) {
    String instructions = recipe(recipeId).instructions.join("(Enter)");

    if (variationIds.isEmpty) {
      variationIds = List.filled(numberOfVariationGroups(recipeId), (0, 0));
    }

    instructions = replaceVariationInstructions(
      instructions,
      variationIds,
      recipe(recipeId).variationGroups,
    );

    instructions = replaceGlobalIngredients(
      numberOfServings,
      instructions,
      recipe(recipeId).ingredients,
    );

    instructions = replaceVariationIngredients(
      numberOfServings,
      instructions,
      variationIds,
      recipe(recipeId).variationGroups,
    );

    return instructions.split("(Enter)");
  }

  // Getters

  RecipeData recipe(int recipeId) {
    return List.from(_recipes).elementAtOrNull(recipeId) ?? RecipeData.empty();
  }

  VariationGroup variationGroup(int recipeId, int variationGroupId) {
    return recipe(recipeId).variationGroups.elementAtOrNull(variationGroupId) ??
        VariationGroup.empty();
  }

  Variation variation(int recipeId, int variationGroupId, int variationId) {
    return variationGroup(recipeId, variationGroupId)
            .variations
            .elementAtOrNull(variationId) ??
        Variation.empty();
  }

  String name(int recipeId) {
    return recipe(recipeId).name;
  }

  String difficulty(int recipeId) {
    return recipe(recipeId).difficulty;
  }

  String price(int recipeId) {
    return recipe(recipeId).price;
  }

  String variationGroupName(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).groupName;
  }

  String variationName(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).name;
  }

  String variationTime(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).time;
  }

  int get number => _recipes.length;

  int numberOfVariationGroups(int recipeId) {
    return recipe(recipeId).variationGroups.length;
  }

  int numberOfVariations(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).variations.length;
  }
}
