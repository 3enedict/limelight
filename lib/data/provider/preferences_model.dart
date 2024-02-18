import 'package:flutter/material.dart';

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
  int _nbServings = 3;

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _unitSystem = instance.getString("Unit system") ?? _unitSystem;
      _currency = instance.getString("Currency") ?? _currency;
      _nbServings = instance.getInt("Servings") ?? _nbServings;
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

  int get nbServings => _nbServings;
  void setNbServings(int nbServings) {
    _nbServings = nbServings;
    _setInt("Servings", nbServings);
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
