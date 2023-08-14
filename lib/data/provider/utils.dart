import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/json/variation_group.dart';

List<RecipeData> loadRecipes(dynamic parsedJson) {
  final data = parsedJson["recipes"] as List<dynamic>?;
  return data != null
      ? data.map((reviewData) => RecipeData.fromJson(reviewData)).toList()
      : <RecipeData>[];
}

List<IngredientDescription> loadIngredients(dynamic parsedJson, String key) {
  final data = parsedJson[key] as List<dynamic>?;
  return data != null
      ? data
          .map((reviewData) => IngredientDescription.fromJson(reviewData))
          .toList()
      : <IngredientDescription>[];
}

String replaceVariationInstructions(
  String recipeWideInstructions,
  List<(int, int)> enabledVariationIds,
  List<VariationGroup> recipeVariations,
) {
  String localInstructions = recipeWideInstructions;
  final regex = RegExp(r'\{([0-9]+):([0-9]+):([0-9]+):instruction\}');

  for (var match in regex.allMatches(recipeWideInstructions)) {
    final variationGroupId = int.parse(match.group(1) ?? "-1");
    final variationId = int.parse(match.group(2) ?? "-1");
    final instructionId = int.parse(match.group(3) ?? "-1");

    final old = "{$variationGroupId:$variationId:$instructionId:instruction}";

    if (enabledVariationIds.contains((variationGroupId, variationId))) {
      final group = recipeVariations.elementAtOrNull(variationGroupId) ??
          VariationGroup.empty();

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
  int numberOfServings,
  String instructions,
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
      computeIngredientQuantities(
        numberOfServings,
        ingredients.elementAtOrNull(instructionId) ?? IngredientData.empty(),
      ),
    );
  }

  return localInstructions;
}

String replaceVariationIngredients(
  int numberOfServings,
  String instructions,
  List<(int, int)> variationIds,
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

    final group = recipeVariations.elementAtOrNull(variationGroupId) ??
        VariationGroup.empty();

    localInstructions = localInstructions.replaceAll(
      "{$variationGroupId:$variationId:$instructionId:quantity}",
      computeIngredientQuantities(
        numberOfServings,
        group.variation(variationId).ingredient(instructionId),
      ),
    );
  }

  return localInstructions;
}

String computeIngredientQuantities(
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
