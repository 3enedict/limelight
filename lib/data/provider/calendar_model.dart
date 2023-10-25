import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RecipeId {
  int recipeId;
  int servings;
  int times;
  List<int> variationIds;

  RecipeId({
    required this.recipeId,
    this.servings = 1,
    this.times = 1,
    variationIds,
  }) : variationIds = variationIds ?? [];

  factory RecipeId.fromString(String data) {
    final ids = data.split(':').map((e) => int.parse(e)).toList();

    return RecipeId(
      recipeId: ids[0],
      servings: ids[1],
      times: ids[2],
      variationIds: ids.sublist(3, ids.length),
    );
  }

  bool hasSameSignatureAs(RecipeId recipe) {
    return recipeId == recipe.recipeId &&
        servings == recipe.servings &&
        variationIds.join(':') == recipe.variationIds.join(':');
  }

  @override
  String toString() {
    final vIds = variationIds.join(':');
    return '$recipeId:$servings:$times:$vIds';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeId &&
          runtimeType == other.runtimeType &&
          toString() == other.toString();

  @override
  int get hashCode => Object.hash(recipeId, variationIds, servings, times);
}

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
      _mealList.add(recipe);
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
  List<RecipeId> get meals =>
      mealList + List.from(_mealIds.entries.map((e) => e.value).toList());

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
