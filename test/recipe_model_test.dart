import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/provider/recipe_model.dart';

final simpleRecipe = RecipeData(
  name: "Fettucine alfredo",
  difficulty: "Moderate",
  price: "\$1.0",
  ingredients: [
    IngredientData(
      name: "Egg(s)",
      quantity: "0.8",
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
    "Knead {1:quantity}, some salt and {0:quantity} into a smooth dough that springs back to the touch.",
    "After waiting for at least 30 minutes, roll out the dough.",
    "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
    "After having rolled up the dough, cut it into small strips.",
    "Finely grate {2:quantity}.",
    "Cook the pasta in a small amount of boiling water.",
    "Put {3:quantity} in a cold pan and stir your cooked pasta, some of the water, and your parmesan.",
  ],
  variationGroups: [],
);

final complicatedRecipe = RecipeData(
  name: "Pasta with tomato sauce",
  difficulty: "Easy",
  price: "\$1",
  ingredients: [
    IngredientData(name: "Olive oil", quantity: "2tbsp"),
  ],
  instructions: [
    "{0:0:0:instruction}",
    "{1:0:0:instruction}",
    "{1:1:0:instruction}",
    "{2:0:0:instruction}",
    "{2:1:0:instruction}",
    "Salt to taste",
    "{0:0:1:instruction}",
    "{0:1:0:instruction}",
    "Drain the pasta, while keeping some of the water that it cooked in.",
    "Mix the drained pasta into the sauce, adding some of the pasta water until everything has a good consistency."
  ],
  variationGroups: [
    VariationGroup(
      groupName: "Type of pasta",
      variations: [
        Variation(
          name: "Tagliatelle",
          time: "+1 hour",
          ingredients: [
            IngredientData(name: "Flour", quantity: "100g"),
            IngredientData(name: "Egg(s)", quantity: "1"),
          ],
          instructionGroups: [
            [
              "Knead {0:0:0:quantity}, some salt and {0:0:1:quantity} into a smooth dough that springs back to the touch.",
              "After waiting for at least 30 minutes, roll out the dough.",
              "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
              "After having rolled up the dough, cut it into small strips."
            ],
            [
              "Pour all of your pasta in the boiling water",
            ],
          ],
        ),
        Variation(
          name: "Dry pasta",
          time: "+10 min",
          ingredients: [
            IngredientData(name: "Dry pasta", quantity: ""),
          ],
          instructionGroups: [
            [
              "Pour your pasta, following the instructions on the packet, in the boiling water."
            ]
          ],
        ),
      ],
    ),
    VariationGroup(
      groupName: "Type of base for the sauce",
      variations: [
        Variation(
          name: "Soffritto",
          time: "+10 min",
          ingredients: [
            IngredientData(name: "Onion(s)", quantity: "0.75"),
            IngredientData(name: "Carrot(s)", quantity: "2"),
            IngredientData(name: "Celery stick(s)", quantity: "2"),
          ],
          instructionGroups: [
            [
              "Mince {1:0:0:quantity}, {1:0:1:quantity} and {1:0:2:quantity}.",
              "Assemble everything in a hot pan with {0:quantity} and cook until golden brown."
            ]
          ],
        ),
        Variation(
          name: "Onions and garlic",
          time: "+10 min",
          ingredients: [
            IngredientData(name: "Onion(s)", quantity: "1"),
            IngredientData(name: "Garlic clove(s)", quantity: "1"),
          ],
          instructionGroups: [
            [
              "Mince {1:1:0:quantity} and {1:1:1:quantity}.",
              "Cook the onions in a hot pan with {Olive oil:quantity} until golden brown.",
              "Add in the garlic and stir for about 30 seconds."
            ]
          ],
        ),
      ],
    ),
    VariationGroup(
      groupName: "Type of tomato sauce",
      variations: [
        Variation(
          name: "Crushed baby tomatoes",
          time: "+20 min",
          ingredients: [
            IngredientData(
              name: "Baby tomato(es)",
              quantity: "15",
            ),
          ],
          instructionGroups: [
            [
              "Add in about {2:0:0:quantity} to the pan and cover until the skin starts to split.",
              "Either mash up the tomatoes or wait for them to cook down to a saucy consistency."
            ]
          ],
        ),
        Variation(
          name: "Canned tomato sauce",
          time: "+15 min",
          ingredients: [
            IngredientData(name: "Can(s) of tomato sauce", quantity: "0.75"),
          ],
          instructionGroups: [
            ["Add in {2:1:0:quantity} and cook until thickened"]
          ],
        ),
      ],
    ),
  ],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Recipe model, adding recipes', () {
    test('adding a recipe updates the number of recipes', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.number, 1);
    });

    test('added recipe\'s name can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.name(0), "Fettucine alfredo");
    });

    test('added recipe\'s difficulty can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.difficulty(0), "Moderate");
    });

    test('added recipe\'s price can be accessed correctly', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      expect(model.price(0), "\$1.0");
    });
  });

  group('Recipe model, variations', () {
    test('Requesting the number of VariationGroups works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.numberOfVariationGroups(0), 3);
    });

    test('Requesting the name of a VariationGroup works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.variationGroupName(0, 1), "Type of base for the sauce");
    });

    test('Requesting the number of Variations works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.numberOfVariations(0, 1), 2);
    });

    test('Requesting the name of a Variation works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.variationName(0, 1, 0), "Soffritto");
    });

    test('Requesting the time for doing a Variation works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.variationTime(0, 1, 0), "+10 min");
    });
  });

  group('Recipe model, generation', () {
    test(
        'Generating a list of ingredients for a recipe according to it\'s variations produces the correct ingredients',
        () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      final List<IngredientData> ingredients = [
        IngredientData(name: "Olive oil", quantity: "2tbsp"),
        IngredientData(name: "Flour", quantity: "100g"),
        IngredientData(name: "Egg(s)", quantity: "1"),
        IngredientData(name: "Onion(s)", quantity: "1"),
        IngredientData(name: "Garlic clove(s)", quantity: "1"),
        IngredientData(name: "Baby tomato(es)", quantity: "15"),
      ];

      final variations = [(0, 0), (1, 1), (2, 0)];
      expect(model.ingredientList(0, variations), ingredients);
    });

    test(
        'Pasta with tomato sauce : generating a list of instructions for a recipe according to it\'s variations produces the correct instructions',
        () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      final instructions = [
        "Knead 300g of flour, some salt and 3 eggs into a smooth dough that springs back to the touch.",
        "After waiting for at least 30 minutes, roll out the dough.",
        "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
        "After having rolled up the dough, cut it into small strips.",
        "Mince 2 onions, 6 carrots and 6 celery sticks.",
        "Assemble everything in a hot pan with 6tbsp of olive oil and cook until golden brown.",
        "Add in about 45 baby tomatoes to the pan and cover until the skin starts to split.",
        "Either mash up the tomatoes or wait for them to cook down to a saucy consistency.",
        "Salt to taste",
        "Pour all of your pasta in the boiling water",
        "Drain the pasta, while keeping some of the water that it cooked in.",
        "Mix the drained pasta into the sauce, adding some of the pasta water until everything has a good consistency.",
      ];

      const numberOfServings = 3;
      final variations = [(0, 0), (1, 0), (2, 0)];
      expect(
        model.instructionSet(0, numberOfServings, variations),
        instructions,
      );
    });

    test(
        'Fettucine Alfredo : generating a list of instructions for a recipe according to it\'s variations produces the correct instructions',
        () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);

      final instructions = [
        "Knead 100g of flour, some salt and 1 egg into a smooth dough that springs back to the touch.",
        "After waiting for at least 30 minutes, roll out the dough.",
        "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
        "After having rolled up the dough, cut it into small strips.",
        "Finely grate a good handful of parmesan.",
        "Cook the pasta in a small amount of boiling water.",
        "Put a good knob of butter in a cold pan and stir your cooked pasta, some of the water, and your parmesan.",
      ];

      const numberOfServings = 1;
      expect(
        model.instructionSet(0, numberOfServings, []),
        instructions,
      );
    });
  });
}
