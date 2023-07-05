import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/items/button_item.dart';
import 'package:limelight/data/recipes.dart';
import 'package:limelight/gradients.dart';

class RecipeData {
  final String difficulty;
  final String price;
  final List<IngredientData> ingredientList;
  final List<String> instructionSet;
  final List<Color> gradient;

  const RecipeData({
    required this.difficulty,
    required this.price,
    required this.ingredientList,
    required this.instructionSet,
    this.gradient = limelightGradient,
  });

  RecipeData.empty({
    this.difficulty = '',
    this.price = '',
  })  : gradient =
            toBackgroundGradientWithReducedColorChange(limelightGradient),
        ingredientList = [],
        instructionSet = [];

  Item toItem(String name, VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: difficulty,
      info: price,
      subInfo: "per person",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
    );
  }

  ButtonItem toButtonItem(String name) {
    return ButtonItem(
      title: name,
      subTitle: difficulty,
      info: price,
      subInfo: "per person",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}

Future<RecipeData> getRecipeData(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final recipe = prefs.getString(key);

  if (recipe == null) {
    return RecipeData.empty();
  } else {
    return recipes[recipe] ?? RecipeData.empty();
  }
}

Future<bool> setRecipe(String key, String name) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, name);
}

Future<bool> removeRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
