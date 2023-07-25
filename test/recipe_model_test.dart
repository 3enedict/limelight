import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/provider/recipe_model.dart';

final simpleRecipe = RecipeData(
  name: "Salad",
  difficulty: "Easy",
  price: "\$0.5",
  ingredients: [
    IngredientData(
      name: "Head(s) of salad",
      quantity: "1",
    ),
    IngredientData(
      name: "Dressing",
      quantity: "1",
    ),
  ],
  instructions: [
    "Clean and chop up {Head(s) of salad:quantity}",
    "Mix with your dressing of choice",
    "Enjoy !",
  ],
  variationGroups: [],
);

final normalRecipe = RecipeData(
  name: "Fettucine Alfredo",
  difficulty: "Moderate",
  price: "\$1.0",
  ingredients: [
    IngredientData(
      name: "Egg(s)",
      quantity: "1",
    ),
    IngredientData(
      name: "Flour",
      quantity: "100g",
    ),
    IngredientData(
      name: "Parmesan",
      quantity: "A good handful",
    ),
    IngredientData(
      name: "Butter",
      quantity: "A good knob",
    ),
  ],
  instructions: [
    "Knead {Flour:quantity}, some salt and {Egg(s):quantity} into a smooth dough that springs back to the touch.",
    "After waiting for at least 30 minutes, roll out the dough.",
    "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
    "After having rolled up the dough, cut it into small strips.",
    "Finely grate {Parmesan:quantity}.",
    "Cook the pasta in a small amount of boiling water.",
    "Put {Butter:quantity} in a cold pan and stir your cooked pasta, some of the water, and your parmesan.",
  ],
  variationGroups: [],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Recipe Model', () {
    test('loading a recipe updates the number of recipes', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("pasta_with_tomato_sauce.json");

      model.addListener(() => expect(model.number, 1));
    });

    test('loaded recipe\'s name can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("pasta_with_tomato_sauce.json");

      model.addListener(() => expect(model.name(0), "Pasta with tomato sauce"));
    });

    test('loaded recipe\'s difficulty can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("pasta_with_tomato_sauce.json");

      model.addListener(() => expect(model.difficulty(0), "Easy"));
    });

    test('loaded recipe\'s price can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("pasta_with_tomato_sauce.json");

      model.addListener(() => expect(model.price(0), "\$1"));
    });
  });
}
