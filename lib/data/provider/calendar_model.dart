import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CalendarModel extends ChangeNotifier {
  final Map<String, int> _mealIds = {};

  void load() {
    SharedPreferences.getInstance().then(
      (instance) {
        loadFromStringList(instance.getStringList("Meals") ?? []);
      },
    );
  }

  void loadFromStringList(List<String> mealList) {
    for (var meal in mealList) {
      List<int> ids = meal.split("/").map((e) => int.parse(e)).toList();

      // "year/month/day/meal" = recipeId
      _mealIds["${ids[0]}/${ids[1]}/${ids[2]}/${ids[3]}"] = ids[4];
    }
  }

  void set(int year, int month, int day, int meal, int recipeId) {
    _mealIds["$year/$month/$day/$meal"] = recipeId;

    _saveMeals();
  }

  void remove(int year, int month, int day, int meal) {
    _mealIds.remove("$year/$month/$day/$meal");

    _saveMeals();
  }

  int? get(int year, int month, int day, int meal) {
    return _mealIds["$year/$month/$day/$meal"];
  }

  void _saveMeals() {
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
}
