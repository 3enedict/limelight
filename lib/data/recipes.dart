import "package:limelight/gradients.dart";
import "package:limelight/widgets/data/recipe.dart";
import "package:limelight/widgets/data/ingredient.dart";

final recipes = [
  RecipeData(
    name: "Pasta with tomato sauce",
    difficulty: "Easy",
    price: "Cheap",
    variations: [
      Variation(
        name: "Type of pasta",
        variations: [
          "Dry pasta",
          "Fresh pasta",
        ],
      ),
      Variation(
        name: "Type of base for the sauce",
        variations: [
          "Fried onions and garlic",
          "Sofrito (onions, carrots, celery)",
        ],
      ),
      Variation(
        name: "Type of tomato sauce",
        variations: [
          "Regular canned tomato sauce",
          "Fresh baby tomatoes (crushed)",
        ],
      ),
    ],
    generate: (variations) {
      List<IngredientData> ingredientList = [];
      List<String> instructionSet = [];

      if (variations.contains("Dry pasta")) {
        ingredientList.add(IngredientData(name: "Dry pasta", quantity: "100g"));
      }

      return (ingredientList, instructionSet);
    },
  ),
];
