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

  group('Recipe model: Loading recipes', () {
    test('loading a recipe updates the number of recipes', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.number, 1));
    });

    test('loaded recipe\'s name can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.name(0), "Pasta with tomato sauce"));
    });

    test('loaded recipe\'s difficulty can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.difficulty(0), "Easy"));
    });

    test('loaded recipe\'s price can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.price(0), "\$1"));
    });
  });

  group('Recipe model: Adding recipes', () {
    test('adding a recipe updates the number of recipes', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.number, 1);
    });

    test('added recipe\'s name can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.name(0), "Salad");
    });

    test('added recipe\'s difficulty can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.difficulty(0), "Easy");
    });

    test('added recipe\'s price can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.price(0), "\$0.5");
    });
  });

  group('Recipe model: Variations', () {
    test('Requesting the number of VariationGroups works as expected', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.numberOfVariationGroups(0), 3));
    });

    test('Requesting the name of a VariationGroup works as expected', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() =>
          expect(model.variationGroupName(0, 1), "Type of base for the sauce"));
    });

    test('Requesting the number of Variations works as expected', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.numberOfVariations(0, 1), 2));
    });

    test('Requesting the name of a Variation works as expected', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.variationName(0, 1, 0), "Soffrito"));
    });

    test('Requesting the time for doing a Variation works as expected', () {
      final RecipeModel model = RecipeModel();
      model.loadFromAssets("test.json");

      model.addListener(() => expect(model.variationTime(0, 1, 0), "+10min"));
    });
  });
}
