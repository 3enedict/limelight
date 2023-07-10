import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/main.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/items/button_item.dart';
import 'package:limelight/gradients.dart';

class Recipes {
  Recipes({required this.recipes});
  final List<RecipeData> recipes;

  factory Recipes.fromJson(Map<String, dynamic> data) {
    final recipesData = data['recipes'] as List<dynamic>?;
    final recipes = recipesData != null
        ? recipesData
            .map((reviewData) => RecipeData.fromJson(reviewData))
            .toList()
        : <RecipeData>[];

    return Recipes(
      recipes: recipes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviews': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }
}

class RecipeData {
  final String name;
  final String difficulty;
  final String price;
  final List<Color> gradient;

  const RecipeData({
    required this.name,
    required this.difficulty,
    required this.price,
    this.gradient = limelightGradient,
  });

  RecipeData.empty({
    this.name = '',
    this.difficulty = '',
    this.price = '',
  }) : gradient = toBackgroundGradientWithReducedColorChange(limelightGradient);

  factory RecipeData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final difficulty = data['difficulty'] as String;
    final price = data['price'] as String;

    return RecipeData(
      name: name,
      difficulty: difficulty,
      price: price,
      gradient: limelightGradient,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'difficulty': difficulty,
      'price': price,
    };
  }

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: difficulty,
      info: price,
      subInfo: "per serving",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
    );
  }

  ButtonItem toButtonItem() {
    return ButtonItem(
      title: name,
      subTitle: difficulty,
      info: price,
      subInfo: "per serving",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}

Future<List<RecipeData>> loadAllRecipes() async {
  final jsonData = await rootBundle.loadString('assets/recipes.json');
  final parsedJson = jsonDecode(jsonData);

  return Recipes.fromJson(parsedJson).recipes;
}

Future<int?> getRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final recipeId = prefs.getInt(key);
  return recipeId;
}

Future<bool> setRecipe(String key, int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt(key, id);
}

Future<bool> removeRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
