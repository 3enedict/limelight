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

  String getName(int nb) {
    if (nb == 1) return name.replaceAll(RegExp(r'\(.*\)'), '');
    return name.replaceAll('(', '').replaceAll(')', '');
  }

  String getQuantity() {
    final q = quantity.round();
    return unit == 'some' ? '' : '$q$unit';
  }

  String toEnglish(int nbServings) {
    final num = [
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten'
    ];

    final number = (quantity * nbServings).round();
    final actualName = getName(number).toLowerCase();

    if (unit == 'some') return 'some $actualName'; // some butter
    if (unit == '' && number > 10) return '$number $actualName';
    if (unit == '' && !(number > 10)) return '${num[number - 1]} $actualName';
    return '$number$unit of $actualName';
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
