import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

var lettuce = IngredientDescription(
  name: 'Lettuce',
  season: 'All year',
  price: '\$1.00',
  unit: 'per head',
  category: 'Leafy green',
);

var carrot = IngredientDescription(
  name: 'Carrot',
  season: 'Fall',
  price: '\$3.00',
  unit: 'per kg',
  category: 'Vegetable',
);

var porkChops = IngredientDescription(
  name: 'Porc chops',
  season: 'All year',
  price: '\$12.00',
  unit: 'per kg',
  category: 'Meat',
);

var salmon = IngredientDescription(
  name: 'Salmon',
  season: 'All year',
  price: '\$20.00',
  unit: 'per kg',
  category: 'Fish',
);

const ingredients = """
{
  "ingredients": [
    {
      "name": "Lettuce",
      "season": "All year",
      "price": "\$1.00",
      "unit": "per head",
      "category": "Leafy green"
    },
    {
      "name": "Carrot",
      "season": "Fall",
      "price": "\$3.00",
      "unit": "per kg",
      "category": "Vegetable"
    },
    {
      "name": "Salmon",
      "season": "All year",
      "price": "\$20.00",
      "unit": "per kg",
      "category": "Fish"
    }
  ]
}
""";

void main() {
  test('Loading ingredients works', () {
    final IngredientModel model = IngredientModel();

    model.loadFromString(ingredients);

    expect(model.ingredients, [lettuce, carrot, salmon]);
  });

  test('Searching ingredients works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);

    expect(model.search("l"), [lettuce, salmon]);
  });

  test('Tagging an ingredient as selected works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);
    model.select(carrot.name);

    expect(model.namesOfSelected, [carrot.name]);
  });

  test('Unselecting an ingredient also works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);
    model.select(carrot.name);
    model.select(carrot.name);

    expect(model.namesOfSelected, []);
  });

  test('Adding an ingredient works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);
    model.add(porkChops);

    expect(model.ingredients, [lettuce, carrot, salmon, porkChops]);
  });

  test('Removing an ingredient works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);
    model.remove(lettuce.name);

    expect(model.ingredients, [carrot, salmon]);
  });

  test(
      'Removing a selected ingredient removes it from the list of selected ingredients',
      () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);

    model.select(lettuce.name);
    model.remove(lettuce.name);

    expect(model.namesOfSelected, []);
  });
}
