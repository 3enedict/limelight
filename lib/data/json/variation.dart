import 'package:limelight/data/json/ingredient_data.dart';

class Variation {
  String name;
  List<IngredientData> ingredients;
  List<List<String>> instructionGroups;

  Variation({
    required this.name,
    required this.ingredients,
    required this.instructionGroups,
  });

  Variation.empty({
    this.name = '',
  })  : ingredients = [],
        instructionGroups = [];

  factory Variation.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;

    final ingredientsData = data['ingredients'] as List<dynamic>?;
    final ingredients = ingredientsData != null
        ? ingredientsData
            .map((reviewData) => IngredientData.fromJson(reviewData))
            .toList()
        : <IngredientData>[];

    final List<List<String>> instructionGroups = [];

    final instructionGroupsData =
        data['instructionGroups'] as List<dynamic>? ?? [];
    for (var instructions in instructionGroupsData) {
      instructionGroups.add(List<String>.from(instructions));
    }

    return Variation(
      name: name,
      ingredients: ingredients,
      instructionGroups: instructionGroups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "ingredients": ingredients.map((data) => data.toJson()).toList(),
      "instructionGroups": instructionGroups,
    };
  }

  List<String> instructionGroup(int id) {
    return instructionGroups.elementAtOrNull(id) ?? [];
  }

  IngredientData ingredient(int id) {
    return ingredients.elementAtOrNull(id) ?? IngredientData.empty();
  }
}
