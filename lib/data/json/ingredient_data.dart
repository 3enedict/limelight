import 'package:limelight/languages.dart';

class IngredientData {
  String name;
  double quantity;
  String unit;

  IngredientData({
    required this.name,
    this.quantity = 1,
    this.unit = '',
  });

  IngredientData.empty({
    this.name = '',
    this.quantity = 0,
    this.unit = '',
  });

  factory IngredientData.from(IngredientData old) {
    return IngredientData(
      name: old.name,
      quantity: old.quantity,
      unit: old.unit,
    );
  }

  factory IngredientData.fromJson(Map<String, dynamic> data) {
    final name = data['name'].toString();
    final quantity = double.tryParse(data['quantity'].toString());
    final unit = data['unit'].toString();

    return IngredientData(
      name: name,
      quantity: quantity ?? 1,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  String serialize() {
    return '$name:$quantity:$unit';
  }

  factory IngredientData.deserialize(String data) {
    final ingredient = data.split(':');

    return IngredientData(
      name: ingredient[0],
      quantity: double.tryParse(ingredient[1]) ?? 1,
      unit: ingredient[2],
    );
  }

  void multiply(int num) {
    quantity = quantity * num;
  }

  void add(double num) {
    quantity = quantity + num;
  }

  void remove(double num) {
    quantity = quantity - num;
    if (quantity < 0) quantity = 0;
  }

  String getUnit(int nb) {
    if (nb == 1) return unit.replaceAll(RegExp(r'\(.*\)'), '');
    return unit.replaceAll('(', '').replaceAll(')', '');
  }

  String getName(int nb) {
    if (unit != '') return name;
    if (nb == 1) return name.replaceAll(RegExp(r'\(.*\)'), '');
    return name.replaceAll('(', '').replaceAll(')', '');
  }

  String getQuantity() {
    final isSubjective =
        unit == words['toTaste']![0] || unit == words['asNeeded']![0];

    if (isSubjective) {
      return '';
    } else if (unit != '') {
      return '$quantity$unit';
    } else if (quantity > 0.3 && quantity < 0.7) {
      return '0.5';
    } else if (quantity <= 0.3) {
      return '0.25';
    } else {
      return '${quantity.round()}';
    }
  }

  String toEnglish(int nbServings) {
    final num = [
      '1', // Que choisir entre un et une...
      words['two']![0],
      words['three']![0],
      words['four']![0],
      words['five']![0],
      words['six']![0],
      words['seven']![0],
      words['eight']![0],
      words['nine']![0],
      words['ten']![0]
    ];

    final isSubjective =
        unit == words['toTaste']![0] || unit == words['asNeeded']![0];

    int number = (quantity * nbServings).round();
    if (number == 0) number = 1;
    final actualName = getName(number).toLowerCase();
    final actualUnit = getUnit(number);

    if (isSubjective) return actualName;
    if (actualUnit == '' && number > 10) return '$number $actualName';

    double q = quantity * nbServings;
    if (actualUnit == '' && q > 0.3 && q < 0.7) {
      return '0.5 $actualName'; // Ça devrait être la moitié (d'une botte de radis)
    }

    if (actualUnit == '' && q <= 0.3) {
      return '0.25 $actualName'; // Ça devrait être le quart (d'un chou)
    }

    if (actualUnit == '' && !(number > 10)) {
      return '${num[number - 1]} $actualName';
    }

    // Only in french
    if (actualName.startsWith('a') ||
        actualName.startsWith('e') ||
        actualName.startsWith('é') ||
        actualName.startsWith('y') ||
        actualName.startsWith('oe') ||
        actualName.startsWith('o') ||
        actualName.startsWith('u') ||
        actualName.startsWith('i')) {
      return "$number$actualUnit d'$actualName";
    }

    return '$number$actualUnit ${words['of']![0]} $actualName';
  }

  @override
  int get hashCode => Object.hash(name, quantity);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientData &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          quantity == other.quantity;

  @override
  String toString() {
    return "IngredientData(name: $name, quantity: $quantity, unit: $unit)";
  }
}
