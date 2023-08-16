import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/ingredient_groups.dart';
import 'package:limelight/gradients.dart';

class IngredientItem extends StatelessWidget {
  final int groupId;
  final int ingredientId;

  const IngredientItem({
    super.key,
    required this.groupId,
    required this.ingredientId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final enabled = ingredients.isEnabled(groupId, ingredientId);
        final desc = ingredients.get(groupId, ingredientId);
        final gradient = gradients[desc.group];

        return Item(
          title: desc.name,
          subTitle: desc.season,
          info: desc.price,
          subInfo: desc.unit,
          accentGradient:
              enabled ? const [Color(0xFF222222), Color(0xFF222222)] : gradient,
          backgroundGradient:
              enabled ? gradient : toBackgroundGradient(gradient),
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
