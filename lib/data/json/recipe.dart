import 'package:flutter/material.dart';

import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/gradients.dart';

class RecipeData {
  String name;
  List<IngredientData> ingredients;
  List<String> instructions;
  List<VariationGroup> variationGroups;
  List<Color> gradient;

  RecipeData({
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.variationGroups,
    this.gradient = limelightGradient,
  });

  RecipeData.empty({
    this.name = '',
  })  : ingredients = [],
        instructions = [],
        variationGroups = [],
        gradient = toBackgroundGradient(limelightGradient);

  factory RecipeData.from(RecipeData data) {
    return RecipeData(
      name: data.name,
      ingredients: data.ingredients,
      instructions: data.instructions,
      variationGroups: data.variationGroups,
      gradient: limelightGradient,
    );
  }

  factory RecipeData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;

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
      ingredients: ingredients,
      instructions: instructions,
      variationGroups: variationGroups,
      gradient: limelightGradient,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients.map((data) => data.toJson()).toList(),
      'instructions': instructions,
      'variationGroups': variationGroups.map((data) => data.toJson()).toList(),
    };
  }

  IngredientData ingredient(int id) {
    return ingredients[id];
  }
}
