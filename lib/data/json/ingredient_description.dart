class IngredientDescription implements Comparable<IngredientDescription> {
  String name, season, price, unit, category;

  IngredientDescription({
    required this.name,
    required this.season,
    required this.price,
    required this.unit,
    required this.category,
  });

  IngredientDescription.empty({
    this.name = '',
    this.season = '',
    this.price = '',
    this.unit = '',
    this.category = '',
  });

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final season = data['season'] as String;
    final price = data['price'] as String;
    final unit = data['unit'] as String;
    final category = data['category'] as String;

    return IngredientDescription(
      name: name,
      season: season,
      price: price,
      unit: unit,
      category: category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'season': season,
      'price': price,
      'unit': unit,
      'category': category,
    };
  }

  @override
  int get hashCode => Object.hash(name, season, price, unit, category);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientDescription &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          season == other.season &&
          price == other.price &&
          unit == other.unit &&
          category == other.category;

  @override
  String toString() {
    return """IngredientDescription(
      name: '$name', 
      season: '$season', 
      price: '$price',
      unit: '$unit',
      category: '$category',
    )""";
  }

  @override
  int compareTo(IngredientDescription other) => name.compareTo(other.name);
}
