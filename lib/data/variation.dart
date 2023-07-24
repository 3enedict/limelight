import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/data/ingredient.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class VariationModel extends ChangeNotifier {
  final List<String> _variations = [];

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _variations.addAll(instance.getStringList("Variations") ?? []);
    });
  }

  void add(int recipeId, int variationGroupId, int variationId) {
    final list = fillPotentialUninitializedVariations(
      recipeId,
      variationGroupId,
    );

    list.insert(variationGroupId, "$variationId");
    _variations.insert(recipeId, list.join(":"));

    SharedPreferences.getInstance().then(
      (instance) {
        instance.setStringList("Variations", _variations);
      },
    );

    notifyListeners();
  }

  int findUninitializedVariation(
    int recipeId,
    int numberOfVariationGroupsInRecipe,
  ) {
    final list = getVarationIdsForEachGroup(recipeId);
    if (list.length < numberOfVariationGroupsInRecipe) return list.length;

    return list.indexWhere((element) => element == "");
  }

  List<String> fillPotentialUninitializedVariations(int recipeId, int end) {
    final list = getVarationIdsForEachGroup(recipeId);

    for (var i = list.length; i < end; i++) {
      list.add("");
    }

    return list;
  }

  List<String> getVarationIdsForEachGroup(int recipeId) {
    return (_variations.elementAtOrNull(recipeId) ?? "").split(":");
  }
}

class Variation {
  final String name;
  final String time;
  final List<IngredientData> ingredients;
  final List<List<String>> instructionGroups;

  const Variation({
    required this.name,
    required this.time,
    required this.ingredients,
    required this.instructionGroups,
  });

  factory Variation.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final time = data['time'] as String;

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
      time: time,
      ingredients: ingredients,
      instructionGroups: instructionGroups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "time": time,
      "ingredients": ingredients,
      "instructionGroups": instructionGroups,
    };
  }

  CompactItem toCompactItem(VoidCallback onPressed) {
    return CompactItem(
      title: name,
      info: time,
      accentGradient: limelightGradient,
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: onPressed,
      onLongPress: () {},
    );
  }
}
