import "dart:collection";

import "package:limelight/gradients.dart";
import "package:limelight/widgets/data/recipe.dart";
import "package:limelight/widgets/data/ingredient.dart";

HashMap<String, RecipeData> recipes = HashMap.from(
  {
    "Pasta with tomato sauce": RecipeData(
      difficulty: "Easy",
      price: "Cheap",
      ingredientList: [
        IngredientData(
            name: "Dry pasta",
            season: "",
            price: "",
            unit: "",
            gradient: limelightGradient),
        IngredientData(
            name: "Tomato sauce",
            season: "",
            price: "",
            unit: "",
            gradient: limelightGradient),
        IngredientData(
            name: "Garlic",
            season: "",
            price: "",
            unit: "",
            gradient: limelightGradient),
        IngredientData(
            name: "Olive oil",
            season: "",
            price: "",
            unit: "",
            gradient: limelightGradient),
      ],
      instructionSet: [
        "Mince two garlic cloves",
        "Start heating up a pot of water",
        "Set them in a pan to sweat with some olive oil",
        "Before any browning happens, add in the tomato sauce to reduce",
        "When the water is boiling add in the pasta",
        "When cooked, drain (keeping some of the water) and incorporate into the sauce",
        "Serve",
      ],
    ),
  },
);
