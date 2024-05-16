class IngredientDescription implements Comparable<IngredientDescription> {
  String name;

  IngredientDescription({
    required this.name,
  });

  IngredientDescription.empty({
    this.name = '',
  });

  factory IngredientDescription.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;

    return IngredientDescription(
      name: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return """IngredientDescription(
      name: '$name', 
    )""";
  }

  @override
  int compareTo(IngredientDescription other) => name.compareTo(other.name);
}
