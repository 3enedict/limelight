import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';
import 'package:limelight/gradients.dart';

class IngredientData {
  final String name;
  final String season;
  final String price;
  final String cheapness;
  final List<Color> gradient;

  IngredientData({
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
    required this.gradient,
  });

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: season,
      info: price,
      subInfo: cheapness,
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
    );
  }

  ButtonItem toButtonItem() {
    return ButtonItem(
      title: name,
      subTitle: season,
      info: price,
      subInfo: cheapness,
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}
