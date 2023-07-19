import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/widgets/data/variation_group.dart';
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
  final List<IngredientData> ingredients;
  final List<String> instructions;
  final List<VariationGroup> variationGroups;
  final List<Color> gradient;

  const RecipeData({
    required this.name,
    required this.difficulty,
    required this.price,
    required this.ingredients,
    required this.instructions,
    required this.variationGroups,
    this.gradient = limelightGradient,
  });

  RecipeData.empty({
    this.name = '',
    this.difficulty = '',
    this.price = '',
  })  : ingredients = [],
        instructions = [],
        variationGroups = [],
        gradient =
            toBackgroundGradientWithReducedColorChange(limelightGradient);

  factory RecipeData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final difficulty = data['difficulty'] as String;
    final price = data['price'] as String;

    final ingredientsData = data['ingredients'] as List<dynamic>?;
    final ingredients = ingredientsData != null
        ? ingredientsData
            .map((reviewData) => IngredientData.fromJson(reviewData))
            .toList()
        : <IngredientData>[];

    final instructions = List<String>.from(data['instructions']);

    final variationGroupsData = data['variationGroups'] as List<dynamic>?;
    final variationGroups = variationGroupsData != null
        ? variationGroupsData
            .map((reviewData) => VariationGroup.fromJson(reviewData))
            .toList()
        : <VariationGroup>[];

    return RecipeData(
      name: name,
      difficulty: difficulty,
      price: price,
      ingredients: ingredients,
      instructions: instructions,
      variationGroups: variationGroups,
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

  Item toItem(VoidCallback onPressed, VoidCallback onLongPress) {
    return Item(
      title: name,
      subTitle: difficulty,
      info: price,
      subInfo: "per serving",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
      onLongPress: onLongPress,
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

Future<bool> chechForVariations(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("Variations for $id") == null;
}

Future<bool> setVariation(int id, String variation) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final variations = prefs.getStringList("Variations for $id") ?? [];

  return prefs.setStringList("Variations for $id", [...variations, variation]);
}

Future<List<String>> getVariations(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("Variations for $id") ?? [];
}
