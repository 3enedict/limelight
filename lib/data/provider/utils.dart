import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/recipe_id.dart';

List<RecipeData> loadRecipes(dynamic parsedJson) {
  final data = parsedJson["recipes"] as List<dynamic>?;
  return data != null
      ? data.map((reviewData) => RecipeData.fromJson(reviewData)).toList()
      : <RecipeData>[];
}

String replaceVariationInstructions(
  String recipeWideInstructions,
  RecipeId id,
  List<VariationGroup> recipeVariations,
) {
  String localInstructions = recipeWideInstructions;
  final regex = RegExp(r'\{([0-9]+):([0-9]+):([0-9]+):instruction\}');

  for (var match in regex.allMatches(recipeWideInstructions)) {
    final variationGroupId = int.parse(match.group(1) ?? "-1");
    final variationId = int.parse(match.group(2) ?? "-1");
    final instructionId = int.parse(match.group(3) ?? "-1");

    final old = "{$variationGroupId:$variationId:$instructionId:instruction}";

    if (id.variationIds[variationGroupId] == variationId) {
      final group = recipeVariations[variationGroupId];

      final newInstructions = group
          .variation(variationId)
          .instructionGroup(instructionId)
          .join("(Enter)");

      localInstructions = localInstructions.replaceAll(old, newInstructions);
    } else {
      localInstructions = localInstructions.replaceAll("$old(Enter)", "");
    }
  }

  return localInstructions;
}

String replaceGlobalIngredients(
  String instructions,
  RecipeId id,
  List<IngredientData> ingredients,
) {
  String localInstructions = instructions;
  final ingredientsRegex = RegExp(
    r'\{([0-9]+):quantity\}',
  );

  for (var match in ingredientsRegex.allMatches(instructions)) {
    final instructionId = int.parse(match.group(1) ?? "-1");

    localInstructions = localInstructions.replaceAll(
      "{$instructionId:quantity}",
      ingredients[instructionId].toEnglish(id.servings),
    );
  }

  return localInstructions;
}

String replaceVariationIngredients(
  String instructions,
  RecipeId id,
  List<VariationGroup> recipeVariations,
) {
  String localInstructions = instructions;
  final variationIngredientsRegex = RegExp(
    r'\{([0-9]+):([0-9]+):([0-9]+):quantity\}',
  );

  for (var match in variationIngredientsRegex.allMatches(instructions)) {
    final variationGroupId = int.parse(match.group(1) ?? "-1");
    final variationId = int.parse(match.group(2) ?? "-1");
    final instructionId = int.parse(match.group(3) ?? "-1");

    final group = recipeVariations[variationGroupId];
    final ingredient = group.variation(variationId).ingredient(instructionId);

    localInstructions = localInstructions.replaceAll(
      "{$variationGroupId:$variationId:$instructionId:quantity}",
      ingredient.toEnglish(id.servings),
    );
  }

  return localInstructions;
}
