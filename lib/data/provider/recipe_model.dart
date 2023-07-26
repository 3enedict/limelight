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

  List<String> instructionSet(
    int recipeId,
    int numberOfServings,
    List<(int, int)> variationIds,
  ) {
    String instructions = _recipe(recipeId).instructions.join("(Enter)");

    instructions =
        _replaceVariationInstructions(recipeId, instructions, variationIds);
    instructions =
        _replaceGlobalIngredients(recipeId, numberOfServings, instructions);
    instructions = _replaceVariationIngredients(
        recipeId, numberOfServings, instructions, variationIds);

    return instructions.split("(Enter)");
  }

  String _replaceVariationInstructions(
    int recipeId,
    String instructions,
    List<(int, int)> variationIds,
  ) {
    String localInstructions = instructions;
    final variationInstructionsRegex = RegExp(
      r'\{([0-9]+):([0-9]+):([0-9]+):instruction\}',
    );

    for (var match in variationInstructionsRegex.allMatches(instructions)) {
      final variationGroupId = int.parse(match.group(1) ?? "-1");
      final variationId = int.parse(match.group(2) ?? "-1");
      final instructionId = int.parse(match.group(3) ?? "-1");

      final old = "{$variationGroupId:$variationId:$instructionId:instruction}";

      if (variationIds.contains((variationGroupId, variationId))) {
        final newInstructions =
            _variation(recipeId, variationGroupId, variationId)
                .instructionGroups[instructionId]
                .join("(Enter)");

        localInstructions = localInstructions.replaceAll(old, newInstructions);
      } else {
        localInstructions = localInstructions.replaceAll("$old(Enter)", "");
      }
    }

    return localInstructions;
  }

  String _replaceGlobalIngredients(
    int recipeId,
    int numberOfServings,
    String instructions,
  ) {
    String localInstructions = instructions;
    final ingredientsRegex = RegExp(
      r'\{([0-9]+):quantity\}',
    );

    for (var match in ingredientsRegex.allMatches(instructions)) {
      final instructionId = int.parse(match.group(1) ?? "-1");

      localInstructions = localInstructions.replaceAll(
        "{$instructionId:quantity}",
        _computeIngredientQuantities(
          numberOfServings,
          _recipe(recipeId).ingredients[instructionId],
        ),
      );
    }

    return localInstructions;
  }

  String _replaceVariationIngredients(
    int recipeId,
    int numberOfServings,
    String instructions,
    List<(int, int)> variationIds,
  ) {
    String localInstructions = instructions;
    final variationIngredientsRegex = RegExp(
      r'\{([0-9]+):([0-9]+):([0-9]+):quantity\}',
    );

    for (var match in variationIngredientsRegex.allMatches(instructions)) {
      final variationGroupId = int.parse(match.group(1) ?? "-1");
      final variationId = int.parse(match.group(2) ?? "-1");
      final instructionId = int.parse(match.group(3) ?? "-1");

      localInstructions = localInstructions.replaceAll(
        "{$variationGroupId:$variationId:$instructionId:quantity}",
        _computeIngredientQuantities(
          numberOfServings,
          _variation(recipeId, variationGroupId, variationId)
              .ingredients[instructionId],
        ),
      );
    }

    return localInstructions;
  }

  String _computeIngredientQuantities(
    int numberOfServings,
    IngredientData ingredient,
  ) {
    double? quantity = double.tryParse(ingredient.quantity);

    if (quantity == null) {
      String quantity = ingredient.quantity.replaceAll(RegExp(r'[^0-9]'), '');
      if (quantity == "") {
        return "${ingredient.quantity.toLowerCase()} of ${ingredient.name.toLowerCase()}";
      }

      int number = (numberOfServings * double.parse(quantity)).floor();
      if (number == 0) number = 1;

      String unit = ingredient.quantity.replaceAll(quantity, "");
      String name = ingredient.name;

      return "$number$unit of $name".toLowerCase();
    } else {
      int number = (numberOfServings * quantity).floor();
      if (number == 0) number = 1;

      String ingredientName = number == 1
          ? ingredient.name.replaceAll(RegExp(r'\(.*\)'), '')
          : ingredient.name.replaceAll('(', '').replaceAll(')', '');

      return "$number $ingredientName".toLowerCase();
    }
  }
}
