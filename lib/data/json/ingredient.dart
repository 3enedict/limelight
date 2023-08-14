import 'package:flutter/material.dart';

import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/button_item.dart';
import 'package:limelight/gradients.dart';

final leafyGreens = [];
final vegetables = [];
final meats = [];
final fish = [];

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

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final season = data['season'] as String;
    final price = data['price'] as String;
    final unit = data['unit'] as String;
    final gradient = switch (data['gradient'] as String) {
      "leafyGreens" => leafyGreensGradient,
      "vegetables" => vegetablesGradient,
      "meat" => meatGradient,
      "fish" => fishGradient,
      _ => limelightGradient,
    };

    return IngredientDescription(
      name: name,
      season: season,
      price: price,
      unit: unit,
      gradient: gradient,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'season': season,
      'price': price,
      'unit': unit,
      'gradient': switch (gradient) {
        leafyGreensGradient => "leafyGreens",
        vegetablesGradient => "vegetables",
        meatGradient => "meat",
        fishGradient => "fish",
        _ => "",
      },
    };
  }

  Item toItem(VoidCallback onPressed) {
    return Item(
      title: name,
      subTitle: season,
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
