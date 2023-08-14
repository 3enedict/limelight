import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limelight/data/json/ingredient.dart';

import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/gradients.dart';

class RecipeModel extends ChangeNotifier {
  final List<RecipeData> _recipes = [];
  final List<IngredientDescription> _leafyGreens = [];
  final List<IngredientDescription> _vegetables = [];
  final List<IngredientDescription> _meat = [];
  final List<IngredientDescription> _fish = [];

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

        _leafyGreens.addAll(_loadDesc(parsedJson, "leafyGreens"));
        _vegetables.addAll(_loadDesc(parsedJson, "vegetables"));
        _meat.addAll(_loadDesc(parsedJson, "meat"));
        _fish.addAll(_loadDesc(parsedJson, "fish"));
      },
    );
  }

  List<IngredientDescription> _loadDesc(dynamic parsedJson, String key) {
    final data = parsedJson['leafyGreens'] as List<dynamic>?;
    return data != null
        ? data
            .map((reviewData) => IngredientDescription.fromJson(reviewData))
            .toList()
        : <IngredientDescription>[];
  }

  void add(RecipeData recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void addIngredient(IngredientDescription ingredient) {
    switch (ingredient.gradient) {
      case leafyGreensGradient:
        _leafyGreens.add(ingredient);
        break;
      case vegetablesGradient:
        _vegetables.add(ingredient);
        break;
      case meatGradient:
        _meat.add(ingredient);
        break;
      case fishGradient:
        _fish.add(ingredient);
        break;
    }

    notifyListeners();
  }

  List<IngredientDescription> get leafyGreens => List.from(_leafyGreens);
  List<IngredientDescription> get vegetables => List.from(_vegetables);
  List<IngredientDescription> get meat => List.from(_meat);
  List<IngredientDescription> get fish => List.from(_fish);
  List<IngredientDescription> get ingredients => List.from(
        [..._leafyGreens, ..._vegetables, ..._meat, ..._fish],
      );
  int get numberOfIngredients => ingredients.length;

  RecipeData recipe(int recipeId) {
    return _recipes.toList().elementAtOrNull(recipeId) ?? RecipeData.empty();
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

  int get number => _recipes.length;

  String name(int recipeId) {
    return recipe(recipeId).name;
  }

  String difficulty(int recipeId) {
    return recipe(recipeId).difficulty;
  }

  String price(int recipeId) {
    return recipe(recipeId).price;
  }

  int numberOfVariationGroups(int recipeId) {
    return recipe(recipeId).variationGroups.length;
  }

  String variationGroupName(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).groupName;
  }

  int numberOfVariations(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).variations.length;
  }

  String variationName(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).name;
  }

  String variationTime(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).time;
  }

  List<IngredientData> ingredientList(
    int recipeId,
    List<(int, int)> variationIds,
  ) {
    List<IngredientData> ingredientList =
        List.from(recipe(recipeId).ingredients);

    for (var (variationGroupId, variationId) in variationIds) {
      ingredientList.addAll(
        variation(recipeId, variationGroupId, variationId).ingredients,
      );
    }

    return ingredientList;
  }

  List<String> instructionSet(
    int recipeId,
    int numberOfServings,
    List<(int, int)> variationIds,
  ) {
    String instructions = recipe(recipeId).instructions.join("(Enter)");

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
            variation(recipeId, variationGroupId, variationId)
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
          recipe(recipeId).ingredients[instructionId],
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
          variation(recipeId, variationGroupId, variationId)
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
