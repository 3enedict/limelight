class IngredientDescription {
  final String name;
  final String price;
  final String unit;

  IngredientDescription({
    required this.name,
    required this.price,
    required this.unit,
  });

  IngredientDescription.empty({
    this.name = '',
    this.price = '',
    this.unit = '',
  });

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final price = data['price'] as String;
    final unit = data['unit'] as String;

    return IngredientDescription(
      name: name,
      price: price,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'unit': unit,
    };
  }

  @override
  int get hashCode => Object.hash(name, price, unit);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientDescription &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          unit == other.unit;

  @override
  String toString() {
    return """IngredientDescription(
      name: '$name', 
      price: '$price',
      unit: '$unit',
    )""";
  }
}
