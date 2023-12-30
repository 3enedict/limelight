import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/json/ingredient_data.dart';

class ShoppingListModel extends ChangeNotifier {
  List<IngredientData> _shoppingList = [];
  List<IngredientData> _shoppingCart = [];

  // Shopping cart specific to ingredients from scheduled recipes
  List<IngredientData> _recipesCart = [];

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _shoppingList = (instance.getStringList('Shopping list') ?? [])
          .map((e) => IngredientData.deserialize(e))
          .toList();

      _shoppingCart = (instance.getStringList('Shopping cart') ?? [])
          .map((e) => IngredientData.deserialize(e))
          .toList();

      _recipesCart = (instance.getStringList('Recipes cart') ?? [])
          .map((e) => IngredientData.deserialize(e))
          .toList();
    });
  }

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      SharedPreferences.getInstance().then((instance) {
        instance.setStringList(
          "Shopping list",
          _shoppingList.map((e) => e.serialize()).toList(),
        );

        instance.setStringList(
          "Shopping cart",
          _shoppingCart.map((e) => e.serialize()).toList(),
        );

        instance.setStringList(
          "Recipes cart",
          _recipesCart.map((e) => e.serialize()).toList(),
        );
      });
    }

    notifyListeners();
  }

  // Deep copy...
  List<IngredientData> get shoppingList => List.generate(
        _shoppingList.length,
        (i) => IngredientData.from(_shoppingList[i]),
      );

  List<IngredientData> get shoppingCart => List.generate(
        _shoppingCart.length,
        (i) => IngredientData.from(_shoppingCart[i]),
      );

  List<IngredientData> get recipesCart => List.generate(
        _recipesCart.length,
        (i) => IngredientData.from(_recipesCart[i]),
      );

  void addToShoppingList(IngredientData ingredient) {
    _addTo(_shoppingList, ingredient);
    notify();
  }

  void buy(IngredientData ingredient) {
    _removeFrom(_shoppingList, ingredient);
    _addTo(_shoppingCart, ingredient);

    notify();
  }

  void unbuy(IngredientData ingredient) {
    _removeFrom(_shoppingCart, ingredient);
    _addTo(_shoppingList, ingredient);

    notify();
  }

  void add(IngredientData ingredient) {
    _addTo(_recipesCart, ingredient);
    notify();
  }

  void remove(IngredientData ingredient) {
    _removeFrom(_recipesCart, ingredient);
    notify();
  }

  void clear() {
    _shoppingCart.clear();
    notify();
  }

  void _addTo(List<IngredientData> list, IngredientData ingredient) {
    int? index = find(list, ingredient);
    if (index == null) list.add(ingredient);
    if (index != null) list[index].add(ingredient.quantity);
  }

  void _removeFrom(List<IngredientData> list, IngredientData ingredient) {
    int? index = find(list, ingredient);
    if (index != null) {
      list[index].remove(ingredient.quantity);
      if (list[index].quantity == 0) list.removeAt(index);
    }
  }
}

int? find(List<IngredientData> list, IngredientData ing) {
  for (var i = 0; i < list.length; i++) {
    final item = list[i];

    if (item.name == ing.name && item.unit == ing.unit) {
      return i;
    }
  }

  return null;
}
