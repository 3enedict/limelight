import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/data/ingredient.dart';
import 'package:limelight/widgets/items/compact_item.dart';

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
