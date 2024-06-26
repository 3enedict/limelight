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

  void edit(String oldName, String newName) {
    _ingredients.removeWhere((e) => e.name == oldName);
    _ingredients.add(IngredientDescription(name: newName));

    if (_selected.contains(oldName)) {
      _selected[_selected.indexOf(oldName)] = newName;
    }

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

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final data = _ingredients.map((e) => e.toJson()).toList();

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
      });
    }

    notifyListeners();
  }

  List<String> get namesOfSelected => List.from(_selected);
  List<IngredientDescription> get ingredients => List.from(_ingredients);

  List<IngredientDescription> get selected {
    List<IngredientDescription> descriptions = [];

    List<String> selected = namesOfSelected.reversed.toList();
    descriptions = List.filled(
      selected.length,
      IngredientDescription.empty(),
    );

    for (var ingredient in ingredients) {
      final index = selected.indexOf(ingredient.name);
      if (index != -1) descriptions[index] = ingredient;
    }

    return descriptions;
  }

  void clear() {
    _selected.clear();
    notify();
  }

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
