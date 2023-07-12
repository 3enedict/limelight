import 'package:limelight/widgets/data/ingredient.dart';

class Variation {
  final String name;
  final List<IngredientData> ingredients;
  final List<List<String>> instructionGroups;

  const Variation({
    required this.name,
    required this.ingredients,
    required this.instructionGroups,
  });

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
      "ingredients": ingredients,
      "instructionGroups": instructionGroups,
    };
  }
}
