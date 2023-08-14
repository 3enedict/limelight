import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';

import 'package:limelight/data/provider/utils.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/gradients.dart';

class IngredientStorage {
  List<IngredientDescription> leafyGreens = [];
  List<IngredientDescription> vegetables = [];
  List<IngredientDescription> meat = [];
  List<IngredientDescription> fish = [];

  void load(String jsonData) {
    final parsedJson = jsonDecode(jsonData);

    leafyGreens = loadIngredients(parsedJson, "leafyGreens");
    vegetables = loadIngredients(parsedJson, "vegetables");
    meat = loadIngredients(parsedJson, "meat");
    fish = loadIngredients(parsedJson, "fish");
  }

  Map<String, dynamic> toJson() {
    return {
      "leafyGreens": leafyGreens,
      "vegetables": vegetables,
      "meat": meat,
      "fish": fish,
    };
  }

  void add(IngredientDescription ingredient) {
    switch (ingredient.gradient) {
      case leafyGreensGradient:
        leafyGreens.add(ingredient);
        break;
      case vegetablesGradient:
        vegetables.add(ingredient);
        break;
      case meatGradient:
        meat.add(ingredient);
        break;
      case fishGradient:
        fish.add(ingredient);
        break;
    }
  }
}

class IngredientModel extends ChangeNotifier {
  final assetStorage = IngredientStorage();
  final userStorage = IngredientStorage();

  void load() {
    rootBundle.loadString("assets/ingredients.json").then(
          (jsonData) => assetStorage.load(jsonData),
        );

    getApplicationDocumentsDirectory().then(
      (dir) => File("${dir.path}/ingredients.json").readAsString().then(
            (file) => userStorage.load(file),
          ),
    );
  }

  void addIngredient(IngredientDescription ingredient) {
    userStorage.add(ingredient);
    notify();
  }

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      getApplicationDocumentsDirectory().then((dir) {
        final file = File("${dir.path}/ingredients.json");
        file.writeAsString(jsonEncode(userStorage.toJson()));
      });
    }

    notifyListeners();
  }

  int get numberOfIngredients => ingredients.length;

  List<IngredientDescription> get leafyGreens =>
      List.from([...assetStorage.leafyGreens, ...userStorage.leafyGreens]);
  List<IngredientDescription> get vegetables =>
      List.from([...assetStorage.vegetables, ...userStorage.vegetables]);
  List<IngredientDescription> get meat =>
      List.from([...assetStorage.meat, ...userStorage.meat]);
  List<IngredientDescription> get fish =>
      List.from([...assetStorage.fish, ...userStorage.fish]);

  List<IngredientDescription> get ingredients => List.from(
        [...leafyGreens, ...vegetables, ...meat, ...fish],
      );
}
