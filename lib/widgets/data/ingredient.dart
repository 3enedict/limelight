import 'package:flutter/material.dart';

import 'package:limelight/widgets/items/compact_item.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/items/button_item.dart';
import 'package:limelight/gradients.dart';

class IngredientDescription {
  final String name;
  final String season;
  final String price;
  final String unit;
  final List<Color> gradient;

  IngredientDescription({
    required this.name,
    required this.season,
    required this.price,
    required this.unit,
    required this.gradient,
  });

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: season,
      info: price,
      subInfo: unit,
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
      onPressed: onPressed,
      onLongPress: () {},
    );
  }

  ButtonItem toButtonItem() {
    return ButtonItem(
      title: name,
      subTitle: season,
      info: price,
      subInfo: unit,
      accentGradient: gradient,
      backgroundGradient: toSurfaceGradient(gradient),
    );
  }
}

class IngredientData {
  final String name;
  final String quantity;

  IngredientData({
    required this.name,
    required this.quantity,
  });

  factory IngredientData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final quantity = data['quantity'].toString();

    return IngredientData(
      name: name,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  CompactItem toCompactItem(VoidCallback onPressed) {
    return CompactItem(
      title: name,
      info: quantity,
      backgroundGradient: toSurfaceGradient(limelightGradient),
      accentGradient: limelightGradient,
      onPressed: onPressed,
      onLongPress: () {},
    );
  }
}
