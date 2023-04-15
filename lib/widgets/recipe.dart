import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';
import 'package:limelight/gradients.dart';

class RecipeData {
  final String name;
  final String time;
  final String price;
  final String unit;
  final List<Color> gradient;

  RecipeData({
    required this.name,
    required this.time,
    required this.price,
    this.unit = "per person",
    this.gradient = limelightGradient,
  });

  RecipeData.empty({
    this.name = '',
    this.time = '',
    this.price = '',
    this.unit = '',
  }) : gradient = toBackgroundGradient(limelightGradient);

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: time,
      info: price,
      subInfo: unit,
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
      subInfo: unit,
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}
