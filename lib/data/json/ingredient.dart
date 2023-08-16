import 'package:flutter/material.dart';

import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

class IngredientDescription {
  final String name;
  final String season;
  final String price;
  final String unit;
  final int group;

  IngredientDescription({
    required this.name,
    required this.season,
    required this.price,
    required this.unit,
    required this.group,
  });

  IngredientDescription.empty({
    this.name = '',
    this.season = '',
    this.price = '',
    this.unit = '',
    this.group = 0,
  });

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final season = data['season'] as String;
    final price = data['price'] as String;
    final unit = data['unit'] as String;
    final group = data['group'] as int;

    return IngredientDescription(
      name: name,
      season: season,
      price: price,
      unit: unit,
      group: group,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'season': season,
      'price': price,
      'unit': unit,
      'group': group,
    };
  }

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: season,
      info: price,
      subInfo: unit,
      accentGradient: limelightGradient,
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: onPressed,
    );
  }

  @override
  String toString() {
    return """IngredientDescription(
      name: $name, 
      season: $season,
      price: $price,
      unit: $unit,
      group: $group,
    )""";
  }
}

class IngredientData {
  final String name;
  final String quantity;

  IngredientData({
    required this.name,
    required this.quantity,
  });

  IngredientData.empty({
    this.name = '',
    this.quantity = '',
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

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      info: quantity,
      onPressed: onPressed,
    );
  }

  @override
  int get hashCode => Object.hash(name, quantity);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          quantity == other.quantity;

  @override
  String toString() {
    return "IngredientData(name: $name, quantity: $quantity)";
  }
}
