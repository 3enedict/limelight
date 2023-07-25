import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:limelight/data/json/ingredient.dart';

import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/variation_group.dart';

class RecipeModel extends ChangeNotifier {
  final List<RecipeData> _recipes = [];

  void load() {
    rootBundle.loadString("assets/recipes.json").then(
      (jsonData) {
        final parsedJson = jsonDecode(jsonData);
        final recipeData = parsedJson['recipes'] as List<dynamic>?;
        final recipes = recipeData != null
            ? recipeData
                .map((reviewData) => RecipeData.fromJson(reviewData))
                .toList()
            : <RecipeData>[];

        _recipes.addAll(recipes);
        notifyListeners();
      },
    );
  }

  void add(RecipeData recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  RecipeData _recipe(int recipeId) {
    return _recipes.elementAtOrNull(recipeId) ?? RecipeData.empty();
  }

  VariationGroup _variationGroup(int recipeId, int variationGroupId) {
    return _recipe(recipeId)
            .variationGroups
            .elementAtOrNull(variationGroupId) ??
        VariationGroup.empty();
  }

  Variation _variation(int recipeId, int variationGroupId, int variationId) {
    return _variationGroup(recipeId, variationGroupId)
            .variations
            .elementAtOrNull(variationId) ??
        Variation.empty();
  }

  int get number => _recipes.length;

  String name(int recipeId) {
    return _recipe(recipeId).name;
  }

  String difficulty(int recipeId) {
    return _recipe(recipeId).difficulty;
  }

  String price(int recipeId) {
    return _recipe(recipeId).price;
  }

  int numberOfVariationGroups(int recipeId) {
    return _recipe(recipeId).variationGroups.length;
  }

  String variationGroupName(int recipeId, int variationGroupId) {
    return _variationGroup(recipeId, variationGroupId).groupName;
  }

  int numberOfVariations(int recipeId, int variationGroupId) {
    return _variationGroup(recipeId, variationGroupId).variations.length;
  }

  String variationName(int recipeId, int variationGroupId, int variationId) {
    return _variation(recipeId, variationGroupId, variationId).name;
  }

  String variationTime(int recipeId, int variationGroupId, int variationId) {
    return _variation(recipeId, variationGroupId, variationId).time;
  }

  List<IngredientData> ingredientList(
    int recipeId,
    List<(int, int)> variationIds,
  ) {
    List<IngredientData> ingredients = _recipe(recipeId).ingredients;
    for (var (variationGroupId, variationId) in variationIds) {
      ingredients.addAll(
        _variation(recipeId, variationGroupId, variationId).ingredients,
      );
    }

    return ingredients;
  }
}
