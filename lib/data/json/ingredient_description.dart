class IngredientDescription implements Comparable<IngredientDescription> {
  String name, season, price, unit;

  IngredientDescription({
    required this.name,
    required this.season,
    required this.price,
    required this.unit,
  });

  IngredientDescription.empty({
    this.name = '',
    this.season = '',
    this.price = '',
    this.unit = '',
  });

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final season = data['season'] as String;
    final price = data['price'] as String;
    final unit = data['unit'] as String;

    return IngredientDescription(
      name: name,
      season: season,
      price: price,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'season': season,
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
          season == other.season &&
          price == other.price &&
          unit == other.unit;

  @override
  String toString() {
    return """IngredientDescription(
      name: '$name', 
      season: '$season', 
      price: '$price',
      unit: '$unit',
    )""";
  }

  @override
  int compareTo(IngredientDescription other) => name.compareTo(other.name);
}
