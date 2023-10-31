import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'package:limelight/data/json/ingredient_description.dart';

class IngredientModel extends ChangeNotifier {
  List<IngredientDescription> _ingredients = [];
  List<String> _selected = [];
  List<String> _shoppingList = [];

  List<String> _shopped = [];

  void load() {
    getApplicationDocumentsDirectory().then(
      (dir) => File("${dir.path}/ingredients.json")
          .readAsString()
          .onError((_, __) => Future.value(''))
          .then((file) {
        if (file == "") {
          rootBundle.loadString("assets/ingredients.json").then(
                (assetFile) => loadFromString(assetFile),
              );

          return;
        }

        loadFromString(file);
      }),
    );

    SharedPreferences.getInstance().then((instance) {
      _selected = instance.getStringList("Selected") ?? [];
      _shoppingList = instance.getStringList("Shopping list") ?? [];
      _shopped = instance.getStringList("Shopped") ?? [];
    });
  }

  void add(IngredientDescription ingredient) {
    _ingredients.add(ingredient);
    notify();
  }

  void remove(String name) {
    _ingredients.removeWhere((e) => e.name == name);
    _selected.remove(name);
    notify();
  }

  List<IngredientDescription> search(String rawQuery) {
    List<IngredientDescription> results = [];
    List<List<IngredientDescription>> secondaryResults = [];

    final query = rawQuery.toLowerCase();
    for (var ingredient in ingredients) {
      final name = ingredient.name.toLowerCase();
      if (name.startsWith(query)) {
        results.insert(0, ingredient);
      } else if (name.contains(query)) {
        results.add(ingredient);
      } else {
        int num = _checkCharacterMatches(query, name);
        _addSecondaryResult(secondaryResults, num, ingredient);
      }
    }

    _addResultsByPriority(results, secondaryResults);

    return results;
  }

  void select(String name) {
    if (_selected.contains(name)) {
      _selected.remove(name);
    } else {
      _selected.add(name);
    }

    notify();
  }

  void addToShoppingList(String name, String quantity) {
    final list = _shoppingList.map((e) => e.split(':')[0]).toList();

    if (list.contains(name)) {
      final index = list.indexOf(name);
      final oldQuantity =
          _shoppingList[index].split(':')[1].replaceAll(RegExp(r"\D"), "");
      final newQuantity = quantity.replaceAll(RegExp(r"\D"), "");

      String finalQuantity;
      if (oldQuantity == '' || newQuantity == '') {
        finalQuantity = '';
      } else {
        finalQuantity = '${int.parse(oldQuantity) + int.parse(newQuantity)}';
      }

      final unit = quantity.replaceAll(RegExp(r"\d"), "");

      _shoppingList[index] = '$name:$finalQuantity$unit';
    } else {
      _shoppingList.add('$name:$quantity');
    }

    notify();
  }

  void shop(String name, String quantity) {
    final list = _shopped.map((e) => e.split(':')[0]).toList();

    if (list.contains(name)) {
      final index = list.indexOf(name);
      final oldQuantity =
          _shopped[index].split(':')[1].replaceAll(RegExp(r"\D"), "");
      final newQuantity = quantity.replaceAll(RegExp(r"\D"), "");

      String finalQuantity;
      if (oldQuantity == '' || newQuantity == '') {
        finalQuantity = '';
      } else {
        finalQuantity = '${int.parse(oldQuantity) + int.parse(newQuantity)}';
      }

      final unit = quantity.replaceAll(RegExp(r"\d"), "");

      _shopped[index] = '$name:$finalQuantity$unit';
    } else {
      _shopped.add('$name:$quantity');
    }

    if (_shoppingList.contains('$name:$quantity')) {
      _shoppingList[_shoppingList.indexOf('$name:$quantity')] =
          '-$name:$quantity';
    }

    notify();
  }

  void unshop(int index) {
    if (_shoppingList.contains('-${_shopped[index]}')) {
      _shoppingList[_shoppingList.indexOf('-${_shopped[index]}')] =
          _shopped[index];
    }

    _shopped.removeAt(index);
    notify();
  }

  void clearShopped() {
    _shopped = [];
    notify();
  }

  void notify() {
    final data = _ingredients.map((e) => e.toJson()).toList();

    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      getApplicationDocumentsDirectory().then(
        (dir) {
          final file = File("${dir.path}/ingredients.json");

          file.writeAsString(
            jsonEncode({'ingredients': data}),
          );
        },
      );

      SharedPreferences.getInstance().then((instance) {
        instance.setStringList("Selected", _selected);
        instance.setStringList("Shopping list", _shoppingList);
        instance.setStringList("Shopped", _shopped);
      });
    }

    notifyListeners();
  }

  List<String> get selected => List.from(_selected);
  List<String> get shoppingList => List.from(_shoppingList);
  List<String> get shopped => List.from(_shopped);
  List<IngredientDescription> get ingredients => List.from(_ingredients);

  // Utilities

  void loadFromString(String data) {
    if (data == "") return;

    final parsedJson = jsonDecode(data);
    final groups = parsedJson['ingredients'] as List<dynamic>? ?? [];

    _ingredients =
        groups.map((e) => IngredientDescription.fromJson(e)).toList();

    notifyListeners();
  }

  int _checkCharacterMatches(String query, String name) {
    int numberOfMatches = -1;
    for (var rune in query.runes) {
      final character = String.fromCharCode(rune);

      if (name.contains(character)) numberOfMatches++;
    }

    return numberOfMatches;
  }

  void _addSecondaryResult(
    List<List<IngredientDescription>> secondaryResults,
    int numberOfMatches,
    IngredientDescription ingredient,
  ) {
    if (numberOfMatches != -1) {
      while (secondaryResults.elementAtOrNull(numberOfMatches) == null) {
        secondaryResults.add([]);
      }

      secondaryResults[numberOfMatches].add(ingredient);
    }
  }

  void _addResultsByPriority(
    List<IngredientDescription> results,
    List<List<IngredientDescription>> secondaryResults,
  ) {
    for (var resultList in secondaryResults.reversed) {
      results.addAll(resultList);
    }
  }
}
