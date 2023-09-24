import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

const unitSystems = ["International", "Imperial"];
const units = {
  "International": ["per kg", "per unit"],
  "Imperial": ["per lb", "per unit"],
};

const currencies = ["Euro", "Dollar"];
const currencySymbols = {"Euro": "€", "Dollar": "\$"};

class PreferencesModel extends ChangeNotifier {
  String _unitSystem = unitSystems[0];
  String _currency = currencies[0];
  int _plannerMode = 0;

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _unitSystem = instance.getString("Unit system") ?? _unitSystem;
      _currency = instance.getString("Currency") ?? _currency;
      _plannerMode = instance.getInt("Planner mode") ?? _plannerMode;
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

  int get plannerMode => _plannerMode;
  void setPlannerMode(int plannerMode) {
    _plannerMode = plannerMode;
    _setInt("plannerMode", plannerMode);
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
