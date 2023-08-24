import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

var lettuce = IngredientDescription(
  name: "Lettuce",
  season: "All year",
  price: "\$1.00",
  unit: "per head",
);

var carrot = IngredientDescription(
  name: "Carrot",
  season: "Fall",
  price: "\$3.00",
  unit: "per kg",
);

var porkChops = IngredientDescription(
  name: "Porc chops",
  season: "All year",
  price: "\$12.00",
  unit: "per kg",
);

var salmon = IngredientDescription(
  name: "Salmon",
  season: "All year",
  price: "\$20.00",
  unit: "per kg",
);

const ingredients = """
{
  "ingredients": [
    {
      "name": "Lettuce",
      "season": "All year",
      "price": "\$1.00",
      "unit": "per head"
    },
    {
      "name": "Carrot",
      "season": "Fall",
      "price": "\$3.00",
      "unit": "per kg"
    },
    {
      "name": "Salmon",
      "season": "All year",
      "price": "\$20.00",
      "unit": "per kg"
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
    model.select("Carrot");

    expect(model.selected, ["Carrot"]);
  });

  test('Unselecting an ingredient also works', () {
    final IngredientModel model = IngredientModel();
    model.loadFromString(ingredients);
    model.select("Carrot");
    model.select("Carrot");

    expect(model.selected, []);
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
}
