import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';

class RecipeData {
  final String name;
  final String creator;
  final String time;
  final String easiness;
  final List<Color> gradient;

  RecipeData({
    required this.name,
    required this.creator,
    required this.time,
    required this.easiness,
    required this.gradient,
  });

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: creator,
      info: time,
      subInfo: easiness,
      accentGradient: gradient,
      onPressed: onPressed,
    );
  }

  ButtonItem toButtonItem() {
    return ButtonItem(
      title: name,
      subTitle: creator,
      info: time,
      subInfo: easiness,
      accentGradient: gradient,
    );
  }
}
