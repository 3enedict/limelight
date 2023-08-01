import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/provider/variation_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  SharedPreferences.setMockInitialValues({});

  group('Variation model, adding variations', () {
    test('A variation can be added and retrieved', () {
      final VariationModel model = VariationModel();
      int recipeId = 3;
      model.set(recipeId, 2, 1);

      expect(model.variationIds(recipeId), [(2, 1)]);
    });

    test('If querying for a non-existant variations, return empty list', () {
      final VariationModel model = VariationModel();

      expect(model.variationIds(3), []);
    });

    test(
        'Replacing a variation works as expected (even if multiple places for the id can be found)',
        () {
      final VariationModel model = VariationModel();
      int recipeId = 3;
      model.set(recipeId, 3, 2);
      model.set(recipeId, 2, 2);

      //                    <->
      // _variationIds = "3:2:2:2"
      //                      <->

      model.set(recipeId, 2, 1);

      expect(model.variationIds(recipeId), [(3, 2), (2, 1)]);
    });
  });

  group('Variation model, missing variations', () {
    test('Checking for available variations works as expected', () {
      final VariationModel model = VariationModel();

      int recipeId = 3;
      int numberOfVariationsInRecipe = 4;
      model.set(recipeId, 0, 3);
      model.set(recipeId, 2, 1);

      expect(
        model.missingVariations(recipeId, numberOfVariationsInRecipe),
        [1, 3],
      );
    });

    test(
        'If querying missing variations for recipe with none set, return all of them',
        () {
      final VariationModel model = VariationModel();

      int recipeId = 3;
      int numberOfVariationsInRecipe = 4;

      expect(
        model.missingVariations(recipeId, numberOfVariationsInRecipe),
        [0, 1, 2, 3],
      );
    });
  });
}
