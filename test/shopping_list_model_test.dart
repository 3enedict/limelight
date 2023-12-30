import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/data/provider/shopping_list_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  SharedPreferences.setMockInitialValues({});

  test('Adding an ingredient to shopping list works', () {
    final ShoppingListModel model = ShoppingListModel();
    final ingredient = IngredientData(name: 'Carrot', quantity: 3, unit: '');

    model.addToShoppingList(ingredient);

    assert(model.shoppingList.contains(ingredient));
  });

  test('Adding more of an ingredient to shopping list works', () {
    final ShoppingListModel model = ShoppingListModel();
    final ingredient1 = IngredientData(name: 'Carrot', quantity: 3, unit: '');
    final ingredient2 = IngredientData(name: 'Carrot', quantity: 5, unit: '');

    model.addToShoppingList(ingredient1);
    model.addToShoppingList(ingredient2);

    final ingredient = IngredientData(name: 'Carrot', quantity: 8, unit: '');
    assert(model.shoppingList.contains(ingredient));
  });

  test('Two ingredients that have different units don\'t mix', () {
    final ShoppingListModel model = ShoppingListModel();
    final i1 = IngredientData(name: 'Carrot', quantity: 3, unit: 'bag(s)');
    final i2 = IngredientData(name: 'Carrot', quantity: 5, unit: '');

    model.addToShoppingList(i1);
    model.addToShoppingList(i2);

    assert(model.shoppingList.contains(i1) && model.shoppingList.contains(i2));
  });

  test(
      'Buying an ingredient adds it to shopped and removes it from shopping list',
      () {
    final ShoppingListModel model = ShoppingListModel();
    final ingredient = IngredientData(name: 'Carrot', quantity: 5, unit: '');

    model.addToShoppingList(ingredient);
    model.buy(ingredient);

    assert(model.shoppingList.isEmpty && model.shopped.contains(ingredient));
  });

  test(
      'Buying a portion of an ingredient adds it to shopped and removes part of it from shopping list',
      () {
    final ShoppingListModel model = ShoppingListModel();
    final i1 = IngredientData(name: 'Carrot', quantity: 5, unit: '');
    final i2 = IngredientData(name: 'Carrot', quantity: 4, unit: '');
    final i3 = IngredientData(name: 'Carrot', quantity: 1, unit: '');

    model.addToShoppingList(i1);
    model.buy(i2);

    assert(model.shoppingList.contains(i3) && model.shopped.contains(i2));
  });

  test('Unbuying an ingredient puts it back to the shopping list', () {
    final ShoppingListModel model = ShoppingListModel();
    final i1 = IngredientData(name: 'Carrot', quantity: 5, unit: '');
    final i2 = IngredientData(name: 'Carrot', quantity: 4, unit: '');
    final i3 = IngredientData(name: 'Carrot', quantity: 1, unit: '');

    model.addToShoppingList(i1);
    model.buy(i2);
    model.unbuy(i3);

    assert(
      model.shoppingList[0].quantity == 2 && model.shopped[0].quantity == 3,
    );
  });

  test('Clearing shopped work', () {
    final ShoppingListModel model = ShoppingListModel();
    final i1 = IngredientData(name: 'Carrot', quantity: 5, unit: '');
    final i2 = IngredientData(name: 'Carrot', quantity: 4, unit: '');
    final i3 = IngredientData(name: 'Carrot', quantity: 1, unit: '');

    model.addToShoppingList(i1);
    model.buy(i2);
    model.unbuy(i3);
    model.clear();

    assert(model.shoppingList[0].quantity == 2 && model.shopped.isEmpty);
  });
}
