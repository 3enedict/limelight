import 'package:flutter_test/flutter_test.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/recipe_id.dart';

final simpleRecipe = RecipeData(
  name: 'Fettucine alfredo',
  difficulty: 'Moderate',
  price: '\$1.0',
  ingredients: [
    IngredientData(
      name: 'Egg(s)',
      quantity: 0.8,
    ),
    IngredientData(
      name: 'Flour',
      quantity: 100,
      unit: 'g',
    ),
    IngredientData(name: 'Parmesan', unit: 'some'),
    IngredientData(name: 'Butter', unit: 'some'),
  ],
  instructions: [
    'Knead {1:quantity}, some salt and {0:quantity} into a smooth dough that springs back to the touch.',
    'After waiting for at least 30 minutes, roll out the dough.',
    'Set the rolled out dough to dry until parchment-like. This should take about an hour or two.',
    'After having rolled up the dough, cut it into small strips.',
    'Finely grate {2:quantity}.',
    'Cook the pasta in a small amount of boiling water.',
    'Put {3:quantity} in a cold pan and stir your cooked pasta, some of the water, and your parmesan.',
  ],
  variationGroups: [],
);

final complicatedRecipe = RecipeData(
  name: 'Pasta with tomato sauce',
  difficulty: 'Easy',
  price: '\$1',
  ingredients: [
    IngredientData(name: 'Olive oil', unit: 'some'),
  ],
  instructions: [
    '{0:0:0:instruction}',
    '{1:0:0:instruction}',
    '{1:1:0:instruction}',
    '{2:0:0:instruction}',
    '{2:1:0:instruction}',
    'Salt to taste',
    '{0:0:1:instruction}',
    '{0:1:0:instruction}',
    'Drain the pasta, while keeping some of the water that it cooked in.',
    'Mix the drained pasta into the sauce, adding some of the pasta water until everything has a good consistency.'
  ],
  variationGroups: [
    VariationGroup(
      groupName: 'Type of pasta',
      variations: [
        Variation(
          name: 'Tagliatelle',
          time: '+1 hour',
          ingredients: [
            IngredientData(name: 'Flour', quantity: 100, unit: 'g'),
            IngredientData(name: 'Egg(s)', quantity: 1),
          ],
          instructionGroups: [
            [
              'Knead {0:0:0:quantity}, some salt and {0:0:1:quantity} into a smooth dough that springs back to the touch.',
              'After waiting for at least 30 minutes, roll out the dough.',
              'Set the rolled out dough to dry until parchment-like. This should take about an hour or two.',
              'After having rolled up the dough, cut it into small strips.'
            ],
            [
              'Pour all of your pasta in the boiling water',
            ],
          ],
        ),
        Variation(
          name: 'Dry pasta',
          time: '+10 min',
          ingredients: [
            IngredientData(name: 'Dry pasta'),
          ],
          instructionGroups: [
            [
              'Pour your pasta, following the instructions on the packet, in the boiling water.'
            ]
          ],
        ),
      ],
    ),
    VariationGroup(
      groupName: 'Type of base for the sauce',
      variations: [
        Variation(
          name: 'Soffritto',
          time: '+10 min',
          ingredients: [
            IngredientData(name: 'Onion(s)', quantity: 0.75),
            IngredientData(name: 'Carrot(s)', quantity: 2),
            IngredientData(name: 'Celery stick(s)', quantity: 2),
          ],
          instructionGroups: [
            [
              'Mince {1:0:0:quantity}, {1:0:1:quantity} and {1:0:2:quantity}.',
              'Assemble everything in a hot pan with {0:quantity} and cook until golden brown.'
            ]
          ],
        ),
        Variation(
          name: 'Onions and garlic',
          time: '+10 min',
          ingredients: [
            IngredientData(name: 'Onion(s)', quantity: 1),
            IngredientData(name: 'Garlic clove(s)', quantity: 1),
          ],
          instructionGroups: [
            [
              'Mince {1:1:0:quantity} and {1:1:1:quantity}.',
              'Cook the onions in a hot pan with {Olive oil:quantity} until golden brown.',
              'Add in the garlic and stir for about 30 seconds.'
            ]
          ],
        ),
      ],
    ),
    VariationGroup(
      groupName: 'Type of tomato sauce',
      variations: [
        Variation(
          name: 'Crushed baby tomatoes',
          time: '+20 min',
          ingredients: [
            IngredientData(
              name: 'Baby tomato(es)',
              quantity: 15,
            ),
          ],
          instructionGroups: [
            [
              'Add in about {2:0:0:quantity} to the pan and cover until the skin starts to split.',
              'Either mash up the tomatoes or wait for them to cook down to a saucy consistency.'
            ]
          ],
        ),
        Variation(
          name: 'Canned tomato sauce',
          time: '+15 min',
          ingredients: [
            IngredientData(name: 'Can(s) of tomato sauce', quantity: 0.75),
          ],
          instructionGroups: [
            ['Add in {2:1:0:quantity} and cook until thickened']
          ],
        ),
      ],
    ),
  ],
);

void main() {
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

      expect(model.nbVarGroups(0), 3);
    });

    test('Requesting the name of a VariationGroup works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.variationGroupName(0, 1), "Type of base for the sauce");
    });

    test('Requesting the number of Variations works as expected', () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      expect(model.nbVariations(0, 1), 2);
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
        IngredientData(name: 'Olive oil', unit: 'some'),
        IngredientData(name: 'Flour', quantity: 100, unit: 'g'),
        IngredientData(name: 'Egg(s)', quantity: 1),
        IngredientData(name: 'Onion(s)', quantity: 1),
        IngredientData(name: 'Garlic clove(s)', quantity: 1),
        IngredientData(name: 'Baby tomato(es)', quantity: 15),
      ];

      final id = RecipeId(recipeId: 0, servings: 1, variationIds: [0, 1, 0]);

      // Believe it or not, generating an ingredient list multiple times actually used to be a bug
      // Cause: it was necessary to deep clone recipe(recipeId).ingredients
      model.ingredientList(id);
      expect(model.ingredientList(id), ingredients);
    });

    test(
        'Pasta with tomato sauce : generating a list of instructions for a recipe according to it\'s variations produces the correct instructions',
        () {
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      final instructions = [
        'Knead 300g of flour, some salt and 3 eggs into a smooth dough that springs back to the touch.',
        'After waiting for at least 30 minutes, roll out the dough.',
        'Set the rolled out dough to dry until parchment-like. This should take about an hour or two.',
        'After having rolled up the dough, cut it into small strips.',
        'Mince 2 onions, 6 carrots and 6 celery sticks.',
        'Assemble everything in a hot pan with some olive oil and cook until golden brown.',
        'Add in about 45 baby tomatoes to the pan and cover until the skin starts to split.',
        'Either mash up the tomatoes or wait for them to cook down to a saucy consistency.',
        'Salt to taste',
        'Pour all of your pasta in the boiling water',
        'Drain the pasta, while keeping some of the water that it cooked in.',
        'Mix the drained pasta into the sauce, adding some of the pasta water until everything has a good consistency.',
      ];

      final id = RecipeId(recipeId: 0, servings: 3, variationIds: [0, 0, 0]);
      expect(model.instructionSet(id), instructions);
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
        "Finely grate some parmesan.",
        "Cook the pasta in a small amount of boiling water.",
        "Put some butter in a cold pan and stir your cooked pasta, some of the water, and your parmesan.",
      ];

      final id = RecipeId(recipeId: 0, servings: 1);
      expect(model.instructionSet(id), instructions);
    });
  });

  group('Recipe model, editing', () {
    test('Editing an ingredient of an existing recipe works', () {
      final ingredient = IngredientData(name: 'Mushroom(s)', quantity: 10);
      final RecipeModel model = RecipeModel();
      model.add(complicatedRecipe);

      model.addIngredient(0, ingredient);
      model.removeIngredient(
        0,
        IngredientData(name: 'Olive oil', unit: 'some'),
      );

      expect(
        model.recipe(0).ingredients,
        [ingredient],
      );
    });
  });

  group('Recipe model, searching', () {
    test('Searching for ingredients gives the right list of recipe ids', () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);
      model.add(complicatedRecipe);

      final ingredients = ['Parmesan', 'Salmon'];
      final expectedIds = [RecipeId(recipeId: 0, variationIds: <int>[])];

      expect(model.search(ingredients), expectedIds);
    });

    test(
        'Searching for ingredients inside variations also gives the right list of recipe ids',
        () {
      final RecipeModel model = RecipeModel();
      model.add(simpleRecipe);
      model.add(complicatedRecipe);

      final ingredients = ['Salmon', 'Can of tomato sauce'];
      final expectedIds = [
        RecipeId(recipeId: 1, variationIds: [0, 0, 1]),
      ];

      expect(model.search(ingredients), expectedIds);
    });
  });
}
