import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/items/button_item.dart';
import 'package:limelight/gradients.dart';

class RecipeData {
  final String name;
  final String time;
  final String price;
  final String unit;
  final List<Color> gradient;

  const RecipeData({
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

Future<RecipeData> getRecipeData(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final recipe = prefs.getStringList(key);

  if (recipe == null) {
    return RecipeData.empty();
  } else {
    return RecipeData(
      name: recipe[0],
      time: recipe[1],
      price: recipe[2],
    );
  }
}

Future<bool> setRecipe(String key, RecipeData value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setStringList(key, [value.name, value.time, value.price]);
}

Future<bool> removeRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
