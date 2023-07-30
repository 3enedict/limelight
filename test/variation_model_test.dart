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
      model.set(3, 2, 1);

      expect(model.variationIds(3), [(2, 1)]);
    });

    test('If querying for a non-existant variations, return empty list', () {
      final VariationModel model = VariationModel();

      expect(model.variationIds(3), []);
    });

    test(
        'Replacing a variation works as expected (even if multiple places for the id can be found)',
        () {
      final VariationModel model = VariationModel();
      model.set(3, 3, 2);
      model.set(3, 2, 2);

      //                    <->
      // _variationIds = "3:2:2:2"
      //                      <->

      model.set(3, 2, 1);

      expect(model.variationIds(3), [(3, 2), (2, 1)]);
    });
  });
}
