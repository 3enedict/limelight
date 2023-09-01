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

  void load() {
    SharedPreferences.getInstance().then((instance) {
      _unitSystem = instance.getString("Unit system") ?? _unitSystem;
      _currency = instance.getString("Currency") ?? _currency;
    });
  }

  String get unitSystem => _unitSystem;
  void setUnitSystem(String unitSystem) {
    _unitSystem = unitSystem;
    notifyListeners();

    SharedPreferences.getInstance().then(
      (instance) => instance.setString("Unit system", unitSystem),
    );
  }

  String get currency => _currency;
  void setCurrency(String currency) {
    _currency = currency;
    notifyListeners();

    SharedPreferences.getInstance().then(
      (instance) => instance.setString("Currency", currency),
    );
  }
}
