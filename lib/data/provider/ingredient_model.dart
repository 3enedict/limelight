import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'package:limelight/data/json/ingredient.dart';

List<List<IngredientDescription>> loadIngredients(dynamic jsonData) {
  List<List<IngredientDescription>> ingredients = [];

  final parsedJson = jsonDecode(jsonData);
  final groups = parsedJson['groups'] as List<dynamic>? ?? [];
  for (var group in groups) {
    ingredients.add(
      List<dynamic>.from(group)
          .map((e) => IngredientDescription.fromJson(e))
          .toList(),
    );
  }

  return ingredients;
}

class IngredientModel extends ChangeNotifier {
  List<List<IngredientDescription>> _assetIngredients = [];
  List<List<IngredientDescription>> _userIngredients = [];
  List<(int, int)> _enabled = [];

  bool _deletionMode = false;

  void load() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      rootBundle.loadString("assets/ingredients.json").then(
            (jsonData) => _assetIngredients = loadIngredients(jsonData),
          );

      getApplicationDocumentsDirectory().then(
        (dir) => File("${dir.path}/ingredients.json").readAsString().then(
              (file) => _userIngredients = loadIngredients(file),
            ),
      );

      SharedPreferences.getInstance().then((instance) {
        _enabled = (instance.getStringList("Enabled") ?? []).map(
          (stringIds) {
            final ids = stringIds.split(":");
            return (int.parse(ids[0]), int.parse(ids[1]));
          },
        ).toList();
      });
    }
  }

  void add(IngredientDescription ingredient) {
    while (_userIngredients.elementAtOrNull(ingredient.group) == null) {
      _userIngredients.add([]);
    }

    _userIngredients[ingredient.group].add(ingredient);
    notify();
  }

  void enable(int groupId, int ingredientId) {
    if (_deletionMode) {
      if (ingredientId < _assetIngredients.length) {
        _assetIngredients.removeAt(ingredientId);
      } else {
        _userIngredients.removeAt(ingredientId - _assetIngredients.length);
      }

      notify();
    } else {
      _enabled.add((groupId, ingredientId));

      notifyListeners();
    }
  }

  void disable(int groupId, int ingredientId) {
    _enabled.remove((groupId, ingredientId));
    notifyListeners();
  }

  bool isEnabled(int groupId, int ingredientId) {
    return _enabled.contains((groupId, ingredientId));
  }

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final data = _userIngredients
          .map((grp) => grp.map((ingredient) => ingredient.toJson()).toList())
          .toList();

      getApplicationDocumentsDirectory().then(
        (dir) {
          final file = File("${dir.path}/ingredients.json");

          file.writeAsString(
            jsonEncode({
              'groups': [data]
            }),
          );
        },
      );

      SharedPreferences.getInstance().then((instance) {
        instance.setStringList(
          "Enabled",
          _enabled.map((e) => "${e.$1}:${e.$2}").toList(),
        );
      });
    }

    notifyListeners();
  }

  List<IngredientDescription> getGroup(int groupId) {
    final assetGroup = _assetIngredients.elementAtOrNull(groupId) ?? [];
    final userGroup = _userIngredients.elementAtOrNull(groupId) ?? [];

    return List.from([...assetGroup, ...userGroup]);
  }

  IngredientDescription get(int groupId, int ingredientId) {
    final ingredient = getGroup(groupId).elementAtOrNull(ingredientId);
    return ingredient ?? IngredientDescription.empty();
  }

  void toggleDeletionMode() => _deletionMode = !_deletionMode;

  int number(int groupId) {
    return getGroup(groupId).length;
  }
}
