import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CalendarModel extends ChangeNotifier {
  final Map<String, int> _mealIds = {};
  List<int> _mealList = [];

  void load() {
    SharedPreferences.getInstance().then(
      (instance) {
        loadCalendar(instance.getStringList("Meals") ?? []);
        loadMealList(instance.getString("Meal list") ?? '');
      },
    );
  }

  void loadCalendar(List<String> meals) {
    for (var meal in meals) {
      List<int> ids = meal.split("/").map((e) => int.parse(e)).toList();

      // "year/month/day/meal" = recipeId
      _mealIds["${ids[0]}/${ids[1]}/${ids[2]}/${ids[3]}"] = ids[4];
    }
  }

  void loadMealList(String meals) {
    List<String> list = meals.split(":");
    _mealList = []; // Prevents hot reload reusing previous mealList

    for (var item in list) {
      if (item != '') _mealList.add(int.parse(item));
    }
  }

  void set(int year, int month, int day, int meal, int recipeId) {
    _mealIds["$year/$month/$day/$meal"] = recipeId;
    _saveCalendar();
  }

  void remove(int year, int month, int day, int meal) {
    _mealIds.remove("$year/$month/$day/$meal");
    _saveCalendar();
  }

  void add(int recipeId) {
    _fillMealListTo(recipeId);
    _mealList[recipeId] = _mealList[recipeId] + 1;
    _saveList();
  }

  void addIfNone(int recipeId) {
    _fillMealListTo(recipeId);
    if (_mealList[recipeId] == 0) _mealList[recipeId] = 1;
  }

  void removeFromList(int recipeId) {
    _fillMealListTo(recipeId);
    _mealList[recipeId] = _mealList[recipeId] - 1;
    _saveList();
  }

  int? get(int year, int month, int day, int meal) {
    return _mealIds["$year/$month/$day/$meal"];
  }

  List<int> get mealList => List.from(_mealList);

  void _fillMealListTo(int recipeId) {
    while (_mealList.length < recipeId + 1) {
      _mealList.add(0);
    }
  }

  void _saveCalendar() {
    SharedPreferences.getInstance().then(
      (instance) {
        // {"y/m/d/meal": recipeId} => "y/m/d/meal/recipeId"

        instance.setStringList(
          "Meals",
          _mealIds.entries.toList().map((e) => "${e.key}/${e.value}").toList(),
        );
      },
    );

    notifyListeners();
  }

  void _saveList() {
    SharedPreferences.getInstance().then((instance) {
      instance.setString("Meal list", _mealList.join(':'));
    });

    notifyListeners();
  }
}
