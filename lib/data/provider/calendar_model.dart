import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CalendarModel extends ChangeNotifier {
  final Map<String, (int, int)> _mealIds = {};
  List<List<int>> _mealList = [];

  void load() {
    SharedPreferences.getInstance().then(
      (instance) {
        loadCalendar(instance.getStringList("Meals") ?? []);
        loadMealList(instance.getStringList("Meal list") ?? []);
      },
    );
  }

  void loadCalendar(List<String> meals) {
    for (var meal in meals) {
      List<int> ids = meal.split("/").map((e) => int.parse(e)).toList();
      final key = '${ids[0]}/${ids[1]}/${ids[2]}/${ids[3]}';

      // "year/month/day/meal" = recipeId
      _mealIds[key] = (ids[4], ids[5]);
    }
  }

  void loadMealList(List<String> meals) {
    _mealList = []; // Prevents hot reload reusing previous mealList

    for (var meal in meals) {
      List<int> ids = meal.split('/').map((e) => int.parse(e)).toList();

      _mealList.add(ids);
    }
  }

  void set(int year, int month, int day, int meal, int servings, int recipeId) {
    _mealIds['$year/$month/$day/$meal'] = (servings, recipeId);
    _saveCalendar();
  }

  void remove(int year, int month, int day, int meal) {
    _mealIds.remove('$year/$month/$day/$meal');
    _saveCalendar();
  }

  void add(int recipeId, int servings) {
    _fillMealListTo(recipeId, servings);
    _mealList[recipeId][servings] = _mealList[recipeId][servings] + 1;
    _saveList();
  }

  void addIfNone(int recipeId, int servings) {
    _fillMealListTo(recipeId, servings);
    if (_mealList[recipeId][servings] == 0) _mealList[recipeId][servings] = 1;
  }

  void removeFromList(int recipeId, int servings) {
    _fillMealListTo(recipeId, servings);
    _mealList[recipeId][servings] = _mealList[recipeId][servings] - 1;
    _saveList();
  }

  (int, int)? get(int year, int month, int day, int meal) {
    return _mealIds['$year/$month/$day/$meal'];
  }

  List<List<int>> get mealList => List.from(_mealList);

  void _fillMealListTo(int recipeId, int servings) {
    while (_mealList.length < recipeId + 1) {
      _mealList.add([]);
    }

    while (_mealList[recipeId].length < servings + 1) {
      _mealList[recipeId].add(0);
    }
  }

  void _saveCalendar() {
    SharedPreferences.getInstance().then(
      (instance) {
        // {"y/m/d/meal": recipeId} => "y/m/d/meal/recipeId"

        instance.setStringList(
          "Meals",
          _mealIds.entries
              .toList()
              .map((e) => '${e.key}/${e.value.$1}/${e.value.$2}')
              .toList(),
        );
      },
    );

    notifyListeners();
  }

  void _saveList() {
    SharedPreferences.getInstance().then((instance) {
      instance.setStringList(
        "Meal list",
        _mealList.map((e) => e.join('/')).toList(),
      );
    });

    notifyListeners();
  }
}
