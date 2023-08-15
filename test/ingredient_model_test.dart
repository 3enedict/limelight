import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

var lettuce = IngredientDescription(
  name: "Lettuce",
  season: "All year",
  price: "1€",
  unit: "per head",
  group: 0,
);

var salmon = IngredientDescription(
  name: "Salmon",
  season: "All year",
  price: "20€",
  unit: "per kg",
  group: 3,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Ingredient model, adding ingredients', () {
    test('adding an ingredient updates the number of ingredients', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);

      expect(model.number(0), 1);
    });

    test('An ingredient can be added and retrieved', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);

      expect(model.getGroup(0), [lettuce]);
    });

    test('Retrieving a certain type of ingredient works', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);
      model.add(salmon);

      expect(model.getGroup(3), [salmon]);
    });
  });

  group('Ingredient model, tagging ingredients', () {
    test('Setting an ingredient as enabled works', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);
      model.add(salmon);

      model.enable(3, 0);

      expect(model.isEnabled(3, 0), true);
    });

    test('If in "deletion" mode, remove ingredient when enabling it', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);
      model.add(salmon);

      model.enable(3, 0);

      expect(model.isEnabled(3, 0), true);
    });

    test('If in "deletion" mode, remove ingredient when enabling it', () {
      final IngredientModel model = IngredientModel();
      model.add(lettuce);
      model.add(salmon);

      model.toggleDeletionMode();
      model.enable(3, 0);

      expect(model.getGroup(3), []);
    });
  });
}
