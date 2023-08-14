import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/gradients.dart';

var lettuce = IngredientDescription(
  name: "Lettuce",
  season: "All year",
  price: "1€",
  unit: "per head",
  gradient: leafyGreensGradient,
);

var salmon = IngredientDescription(
  name: "Salmon",
  season: "All year",
  price: "20€",
  unit: "per kg",
  gradient: fishGradient,
);

void main() {
  group('Ingredient model, adding ingredients', () {
    test('adding an ingredient updates the number of ingredients', () {
      final IngredientModel model = IngredientModel();
      model.addIngredient(lettuce);

      expect(model.numberOfIngredients, 1);
    });

    test('An ingredient can be added and retrieved', () {
      final IngredientModel model = IngredientModel();
      model.addIngredient(lettuce);

      expect(model.ingredients, [lettuce]);
    });

    test('Retrieving a certain type of ingredient works', () {
      final IngredientModel model = IngredientModel();
      model.addIngredient(lettuce);
      model.addIngredient(salmon);

      expect(model.fish, [salmon]);
    });
  });
}
