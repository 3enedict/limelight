class RecipeId {
  int recipeId;
  int servings;
  int times;
  List<int> variationIds;

  RecipeId({
    required this.recipeId,
    this.servings = 1,
    this.times = 1,
    variationIds,
  }) : variationIds = variationIds ?? [];

  factory RecipeId.fromString(String data) {
    final ids = data.split(':').map((e) => int.parse(e)).toList();

    return RecipeId(
      recipeId: ids[0],
      servings: ids[1],
      times: ids[2],
      variationIds: ids.length > 3 ? ids.sublist(3, ids.length) : <int>[],
    );
  }

  bool hasSameSignatureAs(RecipeId recipe) {
    return recipeId == recipe.recipeId &&
        servings == recipe.servings &&
        variationIds.join(':') == recipe.variationIds.join(':');
  }

  @override
  String toString() {
    if (variationIds.isEmpty) return '$recipeId:$servings:$times';

    final vIds = variationIds.join(':');
    return '$recipeId:$servings:$times:$vIds';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeId &&
          runtimeType == other.runtimeType &&
          toString() == other.toString();

  @override
  int get hashCode => Object.hash(recipeId, variationIds, servings, times);
}
