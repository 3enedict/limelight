import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'package:limelight/data/json/ingredient.dart';

List<IngredientDescription> loadIngredients(dynamic jsonData) {
  final parsedJson = jsonDecode(jsonData);
  final groups = parsedJson['ingredients'] as List<dynamic>? ?? [];

  return groups.map((e) => IngredientDescription.fromJson(e)).toList();
}

class IngredientModel extends ChangeNotifier {
  final _ingredients = <IngredientDescription>[];
  List<String> _enabled = [];

  int _numberOfIngredientsFromAssets = 0;

  void load() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      SharedPreferences.getInstance().then((instance) {
        _enabled = instance.getStringList("Enabled") ?? [];
        final masked = instance.getStringList("Masked") ?? [];

        rootBundle.loadString("assets/ingredients.json").then(
          (jsonData) {
            _ingredients.addAll(loadIngredients(jsonData));
            _ingredients.removeWhere(
              (element) => masked.contains(element.name),
            );

            _numberOfIngredientsFromAssets = _ingredients.length;

            getApplicationDocumentsDirectory().then(
              (dir) => File("${dir.path}/ingredients.json").readAsString().then(
                (file) {
                  _ingredients.addAll(loadIngredients(file));
                  notifyListeners();
                },
              ),
            );
          },
        );
      });
    }
  }

  void add(IngredientDescription ingredient) {
    _ingredients.add(ingredient);
    notify();
  }

  void remove(int id) {
    if (id < _numberOfIngredientsFromAssets) mask(_ingredients[id].name);
    _ingredients.removeAt(id);

    notify();
  }

  void toggle(int id) {
    final enabled = isEnabled(id);

    if (!enabled) _enabled.add(get(id).name);
    if (enabled) _enabled.remove(get(id).name);

    notifyListeners();
  }

  bool isEnabled(int id) {
    return _enabled.contains(get(id).name);
  }

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final strippedIngredients = getAll();
      if (_numberOfIngredientsFromAssets != 0) {
        strippedIngredients.removeRange(0, _numberOfIngredientsFromAssets - 1);
      }

      final data = strippedIngredients.map((e) => e.toJson());

      getApplicationDocumentsDirectory().then(
        (dir) {
          final file = File("${dir.path}/ingredients.json");

          file.writeAsString(
            jsonEncode({'ingredients': data}),
          );
        },
      );

      SharedPreferences.getInstance().then((instance) {
        instance.setStringList("Enabled", _enabled);
      });
    }

    notifyListeners();
  }

  void mask(String name) {
    _numberOfIngredientsFromAssets--;

    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      SharedPreferences.getInstance().then((instance) {
        final old = (instance.getStringList("Masked") ?? <String>[]);
        final masked = [...old, name];

        instance.setStringList("Masked", masked);
      });
    }
  }

  List<IngredientDescription> getAll() {
    return List.from(_ingredients);
  }

  List<IngredientDescription> getGroup(int groupId) {
    var ingredients = getAll();
    ingredients.removeWhere((element) => element.group != groupId);

    return ingredients;
  }

  List<int> getGroupIds(int groupId) {
    List<int> ids = [];
    for (var i = 0; i < _ingredients.length; i++) {
      if (_ingredients[i].group == groupId) ids.add(i);
    }

    return ids;
  }

  IngredientDescription get(int id) {
    final ingredient = getAll().elementAtOrNull(id);
    return ingredient ?? IngredientDescription.empty();
  }

  int number(int groupId) {
    return getGroup(groupId).length;
  }
}
