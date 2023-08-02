import 'package:flutter/material.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';
import 'package:limelight/gradients.dart';

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
