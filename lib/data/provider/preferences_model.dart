import 'package:flutter/material.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/pages/calendar_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

const unitSystems = ["International", "Imperial"];
const units = {
  "International": ["per kg", "per unit"],
  "Imperial": ["per lb", "per unit"],
};

const currencies = ["Euro", "Dollar"];
const currencySymbols = {"Euro": "€", "Dollar": "\$"};

const categories = [
  'Vegetables',
  'Leafy greens',
  'Fish',
  'Dairy',
  'Meat',
  'Misc',
];

class PreferencesModel extends ChangeNotifier {
  String _unitSystem = unitSystems[0];
  String _currency = currencies[0];

  int _nbServingsGlobal = 3;
  final List<int> _nbServingsLocal = [];

  Widget _finalScreen = CalendarPage(recipe: RecipeId(recipeId: 0));

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _unitSystem = instance.getString("Unit system") ?? _unitSystem;
      _currency = instance.getString("Currency") ?? _currency;

      _nbServingsGlobal = instance.getInt("Servings") ?? _nbServingsGlobal;
    });
  }

  String get unitSystem => _unitSystem;
  void setUnitSystem(String unitSystem) {
    _unitSystem = unitSystem;
    _set("Unit system", unitSystem);
  }

  String get currency => _currency;
  void setCurrency(String currency) {
    _currency = currency;
    _set("Currency", currency);
  }

  int get nbServingsGlobal => _nbServingsGlobal;
  void setNbServingsGlobal(int nbServingsGlobal) {
    _nbServingsGlobal = nbServingsGlobal;
    _setInt("Servings", nbServingsGlobal);
  }

  int nbServingsLocal(int recipeId) =>
      _nbServingsLocal.elementAtOrNull(recipeId) ?? _nbServingsGlobal;
  void setNbServingsLocal(int nbServingsLocal, int recipeId) {
    while (_nbServingsLocal.length < recipeId + 1) {
      _nbServingsLocal.add(nbServingsGlobal);
    }

    _nbServingsLocal[recipeId] = nbServingsLocal;
    notifyListeners();
  }

  Widget get getFinalScreen => _finalScreen;
  void setFinalScreen(Widget screen) {
    _finalScreen = screen;
    notifyListeners();
  }

  void _set(String key, String value) {
    notifyListeners();

    SharedPreferences.getInstance().then(
      (instance) => instance.setString(key, value),
    );
  }

  void _setInt(String key, int value) {
    notifyListeners();

    SharedPreferences.getInstance().then(
      (instance) => instance.setInt(key, value),
    );
  }
}
