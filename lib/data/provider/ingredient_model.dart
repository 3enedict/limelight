import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:limelight/data/provider/utils.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/gradients.dart';

class IngredientModel extends ChangeNotifier {
  List<IngredientDescription> _leafyGreens = [];
  List<IngredientDescription> _vegetables = [];
  List<IngredientDescription> _meat = [];
  List<IngredientDescription> _fish = [];

  void load() {
    rootBundle.loadString("assets/ingredients.json").then(
      (jsonData) {
        final parsedJson = jsonDecode(jsonData);

        _leafyGreens = loadIngredients(parsedJson, "leafyGreens");
        _vegetables = loadIngredients(parsedJson, "vegetables");
        _meat = loadIngredients(parsedJson, "meat");
        _fish = loadIngredients(parsedJson, "fish");
      },
    );
  }

  void addIngredient(IngredientDescription ingredient) {
    switch (ingredient.gradient) {
      case leafyGreensGradient:
        _leafyGreens.add(ingredient);
        break;
      case vegetablesGradient:
        _vegetables.add(ingredient);
        break;
      case meatGradient:
        _meat.add(ingredient);
        break;
      case fishGradient:
        _fish.add(ingredient);
        break;
    }

    notifyListeners();
  }

  List<IngredientDescription> get leafyGreens => List.from(_leafyGreens);
  List<IngredientDescription> get vegetables => List.from(_vegetables);
  List<IngredientDescription> get meat => List.from(_meat);
  List<IngredientDescription> get fish => List.from(_fish);

  List<IngredientDescription> get ingredients => List.from(
        [..._leafyGreens, ..._vegetables, ..._meat, ..._fish],
      );

  int get numberOfIngredients => ingredients.length;
}
