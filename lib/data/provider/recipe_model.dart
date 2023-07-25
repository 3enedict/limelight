import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:limelight/data/json/recipe.dart';

class RecipeModel extends ChangeNotifier {
  final List<RecipeData> _recipes = [];

  void loadDefaultRecipes() {
    loadFromAssets('recipes.json');
  }

  void loadFromAssets(String path) {
    rootBundle.loadString("assets/$path").then(
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

  int get number => _recipes.length;

  String name(int recipeId) {
    return (_recipes.elementAtOrNull(recipeId) ?? RecipeData.empty()).name;
  }

  String difficulty(int recipeId) {
    return (_recipes.elementAtOrNull(recipeId) ?? RecipeData.empty())
        .difficulty;
  }

  String price(int recipeId) {
    return (_recipes.elementAtOrNull(recipeId) ?? RecipeData.empty()).price;
  }
}
