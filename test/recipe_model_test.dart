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

final complicatedRecipe = RecipeData(
  name: "Pasta with tomato sauce",
  difficulty: "Easy",
  price: "\$1",
  ingredients: [
    IngredientData(name: "Olive oil", quantity: "2tbsp of olive oil"),
  ],
  instructions: [
    "{0:0:0}",
    "{1:0:0}",
    "{1:1:0}",
    "{2:0:0}",
    "{2:1:0}",
    "Salt to taste",
    "{0:0:1}",
    "{0:1:0}",
    "Drain the pasta, while keeping some of the water that it cooked in.",
    "Mix the drained pasta into the sauce, adding some of the pasta water until everything has a good consistency."
  ],
  variationGroups: [
    VariationGroup(groupName: "Type of pasta", variations: [
      Variation(name: "Tagliatelle", time: "+1 hour", ingredients: [
        IngredientData(
          name: "Flour",
          quantity: "100g of flour",
        ),
        IngredientData(
          name: "Egg(s)",
          quantity: "1",
        ),
      ], instructionGroups: [
        [
          "Knead {Flour:quantity}, some salt and {Egg(s):quantity} into a smooth dough that springs back to the touch.",
          "After waiting for at least 30 minutes, roll out the dough.",
          "Set the rolled out dough to dry until parchment-like. This should take about an hour or two.",
          "After having rolled up the dough, cut it into small strips."
        ],
        ["Pour all of your pasta in the boiling water"]
      ]),
      Variation(name: "Dry pasta", time: "+10 min", ingredients: [
        IngredientData(name: "Dry pasta", quantity: ""),
      ], instructionGroups: [
        [
          "Pour your pasta, following the instructions on the packet, in the boiling water."
        ]
      ]),
    ]),
    VariationGroup(groupName: "Type of base for the sauce", variations: [
      Variation(name: "Soffritto", time: "+10 min", ingredients: [
        IngredientData(name: "Onion(s)", quantity: "0.75"),
        IngredientData(name: "Carrot(s)", quantity: "2"),
        IngredientData(name: "Celery stick(s)", quantity: "2"),
      ], instructionGroups: [
        [
          "Mince {Onion(s):quantity}, {Carrot(s):quantity} and {Celery stick(s):quantity}.",
          "Assemble everything in a hot pan with {Olive oil:quantity} and cook until golden brown."
        ]
      ]),
      Variation(name: "Onions and garlic", time: "+10 min", ingredients: [
        IngredientData(name: "Onion(s)", quantity: "1"),
        IngredientData(name: "Garlic clove(s)", quantity: "1"),
      ], instructionGroups: [
        [
          "Mince {Onion(s):quantity} and {Garlic clove(s):quantity}.",
          "Cook the onions in a hot pan with {Olive oil:quantity} until golden brown.",
          "Add in the garlic and stir for about 30 seconds."
        ]
      ]),
    ]),
    VariationGroup(
      groupName: "Type of tomato sauce",
      variations: [
        Variation(name: "Crushed baby tomatoes", time: "+20 min", ingredients: [
          IngredientData(name: "Baby tomato(es)", quantity: "40"),
        ], instructionGroups: [
          [
            "Add in about {Baby tomato(es):quantity} to the pan and cover until the skin starts to split.",
            "Either mash up the tomatoes or wait for them to cook down to a saucy consistency."
          ]
        ]),
        Variation(
          name: "Canned tomato sauce",
          time: "+15 min",
          ingredients: [
            IngredientData(name: "Can(s) of tomato sauce", quantity: "0.75"),
          ],
          instructionGroups: [
            [
              "Add in {Can(s) of tomato sauce:quantity} and cook until thickened"
            ]
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
        IngredientData(name: "Olive oil", quantity: "2tbsp of olive oil"),
        IngredientData(name: "Flour", quantity: "100g of flour"),
        IngredientData(name: "Egg(s)", quantity: "1"),
        IngredientData(name: "Onion(s)", quantity: "1"),
        IngredientData(name: "Garlic clove(s)", quantity: "1"),
        IngredientData(name: "Baby tomato(es)", quantity: "40"),
      ];

      final variations = [(0, 0), (1, 1), (2, 0)];
      expect(model.ingredientList(0, variations), ingredients);
    });
  });
}
