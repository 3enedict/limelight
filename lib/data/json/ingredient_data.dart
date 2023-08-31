class IngredientData {
  final String name;
  final String quantity;

  IngredientData({
    required this.name,
    required this.quantity,
  });

  IngredientData.empty({
    this.name = '',
    this.quantity = '',
  });

  factory IngredientData.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final quantity = data['quantity'].toString();

    return IngredientData(
      name: name,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
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
    return "IngredientData(name: $name, quantity: $quantity)";
  }
}
