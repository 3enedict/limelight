import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';
import 'package:limelight/gradients.dart';

class RecipeData {
  final String name;
  final String time;
  final String price;
  final List<Color> gradient;

  RecipeData({
    required this.name,
    required this.time,
    required this.price,
    required this.gradient,
  });

  RecipeData.empty({
    this.name = 'Empty',
    this.time = '',
    this.price = '',
    this.gradient = limelightGradient,
  });

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: time,
      info: price,
      subInfo: "per person",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
    );
  }

  ButtonItem toButtonItem() {
    return ButtonItem(
      title: name,
      subTitle: time,
      info: price,
      subInfo: "per person",
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}
