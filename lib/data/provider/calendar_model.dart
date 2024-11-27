import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/recipe_id.dart';

class CalendarModel extends ChangeNotifier {
  final Map<String, RecipeId> _mealIds = {};
  List<RecipeId> _mealList = [];

  void load() {
    SharedPreferences.getInstance().then(
      (instance) {
        loadCalendar(instance.getStringList('Meals') ?? []);
        loadMealList(instance.getStringList('Meal list') ?? []);
      },
    );
  }

  void loadCalendar(List<String> meals) {
    for (var meal in meals) {
      // 'year:month:day:meal/RecipeId'
      List<String> ids = meal.split('/');
      _mealIds[ids[0]] = RecipeId.fromString(ids[1]);
    }
  }

  void loadMealList(List<String> meals) {
    _mealList = meals.map((e) => RecipeId.fromString(e)).toList();
  }

  void set(int year, int month, int day, int meal, RecipeId recipe) {
    recipe.times = 1;
    _mealIds['$year:$month:$day:$meal'] = recipe;
    _saveCalendar();
  }

  void remove(int year, int month, int day, int meal) {
    _mealIds.remove('$year:$month:$day:$meal');
    _saveCalendar();
  }

  void addToList(RecipeId recipe) {
    final id = _mealList.indexWhere((e) => e.hasSameSignatureAs(recipe));

    if (id == -1) {
      recipe.times = 1;
      final index =
          _mealList.indexWhere((e) => e.servings == recipe.servings + 1);

      if (index == -1) {
        _mealList.add(recipe);
      } else {
        _mealList.insert(index, recipe);
      }
    } else {
      _mealList[id].times = _mealList[id].times + 1;
    }

    _saveList();
  }

  void removeFromList(RecipeId recipe) {
    final id = _mealList.indexWhere((e) => e.hasSameSignatureAs(recipe));

    if (id != -1) {
      _mealList[id].times = _mealList[id].times - 1;
      if (_mealList[id].times == 0) _mealList.removeAt(id);
      _saveList();
    }
  }

  RecipeId? get(int year, int month, int day, int meal) {
    return _mealIds['$year:$month:$day:$meal'];
  }

  List<RecipeId> get mealList => List.from(_mealList);
  List<RecipeId> get meals {
    final calendarList = getFutureMeals().values.toList();

    return mealList + List.from(calendarList);
  }

  Map<String, RecipeId> getFutureMeals() {
    DateTime now = DateTime.now();
    Map<String, RecipeId> newIds = Map.from(_mealIds);

    newIds.removeWhere(
      (key, value) {
        final ids = key.split(':');
        final year = int.parse(ids[0]);
        final month = int.parse(ids[1]);
        final day = int.parse(ids[2]);

        if (day >= now.day && month == now.month && year == now.year ||
            month > now.month && year == now.year ||
            year > now.year) {
          return false;
        }

        return true;
      },
    );

    return newIds;
  }

  Map<String, RecipeId> get mealIds => _mealIds;

  void _saveCalendar() {
    SharedPreferences.getInstance().then(
      (instance) {
        // {"y:m:d:meal": RecipeId} => "y:m:d:meal/RecipeId"

        instance.setStringList(
          'Meals',
          _mealIds.entries
              .map((e) => '${e.key}/${e.value.toString()}')
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
        _mealList.map((e) => e.toString()).toList(),
      );
    });

    notifyListeners();
  }
}
