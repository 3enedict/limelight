/*
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/widgets/items/item.dart';

class Ingredient extends StatelessWidget {
  final IngredientDescription desc;

  const Ingredient({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final enabled = ingredients.enabled()
        return Item(
          title: desc.name,
          subTitle: desc.season,
          info: desc.price,
          subInfo: desc.unit,
          accentGradient: enabled
              ? const [Color(0xFF222222), Color(0xFF222222)]
              : accentGradient,
          backgroundGradient: enabled ? accentGradient : backgroundGradient,
          textColor:
              enabled ? const Color(0xFF111111) : const Color(0xFFEEEEEE),
          subTextColor:
              enabled ? const Color(0xFF222222) : const Color(0xFFDDDDDD),
          onPressed: () {},
          onLongPress: () {},
        );
      },
    );
  }
}
*/