import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';

import 'package:limelight/data/json/variation_group.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/data/provider/utils.dart';
import 'package:limelight/data/json/variation.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/data/recipe_id.dart';

class RecipeModel extends ChangeNotifier {
  List<RecipeData> _recipes = [];

  void load() {
    getApplicationDocumentsDirectory().then(
      (dir) => File("${dir.path}/recipes.json")
          .readAsString()
          .onError((_, __) => Future.value(''))
          .then((file) {
        if (file == "") {
          rootBundle.loadString("assets/recipes.json").then(
                (assetFile) => _recipes = loadRecipes(jsonDecode(assetFile)),
              );

          return;
        }

        _recipes = loadRecipes(jsonDecode(file));
      }),
    );
  }

  void add(RecipeData recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void removeIngredient(int recipeId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.ingredients.remove(ingredient);
    notifyListeners();
  }

  void addIngredient(int recipeId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.ingredients.add(ingredient);
    notifyListeners();
  }

  void editIngredient(
    int recipeId,
    int ingredientId,
    IngredientData ingredient,
  ) {
    _recipes[recipeId].ingredients[ingredientId] = ingredient;

    notify();
  }

  void editVarIngredient(
    int recipeId,
    int variationGroupId,
    int variationId,
    int ingredientId,
    IngredientData ingredient,
  ) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .ingredients[ingredientId] = ingredient;

    notify();
  }

  void notify() {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final data = _recipes.map((e) => e.toJson()).toList();

      getApplicationDocumentsDirectory().then(
        (dir) {
          final file = File("${dir.path}/recipes.json");

          file.writeAsString(
            jsonEncode({'recipes': data}),
          );
        },
      );
    }

    notifyListeners();
  }

  List<IngredientData> ingredientList(RecipeId id) {
    final ingredients = recipe(id.recipeId).ingredients;

    // Deep copy
    List<IngredientData> list = List.generate(
      ingredients.length,
      (i) => IngredientData.from(ingredients[i]),
    );

    id = verifyVariationIds(id);
    for (var i = 0; i < nbVarGroups(id.recipeId); i++) {
      final varIngs = variation(id.recipeId, i, id.variationIds[i]).ingredients;

      // Deep copy
      List<IngredientData> l = List.generate(
        varIngs.length,
        (i) => IngredientData.from(varIngs[i]),
      );

      list.addAll(l);
    }

    for (var ingredient in list) {
      ingredient.multiply(id.servings);
    }

    return list;
  }

  List<String> instructionSet(RecipeId id) {
    String inst = recipe(id.recipeId).instructions.join("(Enter)");
    id = verifyVariationIds(id);

    List<VariationGroup> vGrps = recipe(id.recipeId).variationGroups;
    List<IngredientData> ingredients = recipe(id.recipeId).ingredients;

    inst = replaceVariationInstructions(inst, id, vGrps);
    inst = replaceGlobalIngredients(inst, id, ingredients);
    inst = replaceVariationIngredients(inst, id, vGrps);

    return inst.split("(Enter)");
  }

  RecipeId verifyVariationIds(RecipeId id) {
    final nbVarGrps = nbVarGroups(id.recipeId);
    while (id.variationIds.length != nbVarGrps) {
      id.variationIds.add(0);
    }

    return id;
  }

  List<RecipeId> search(List<String> ingredients, int servings) {
    List<RecipeId?> ids = [];

    for (var i = 0; i < number; i++) {
      ids.add(null);

      final gIngredients = removePlural(recipe(i).ingredients);
      for (var s in ingredients) {
        if (gIngredients.contains(s)) {
          ids[i] = RecipeId(recipeId: i, servings: servings);
          break;
        }
      }

      if (ids[i] == null) {
        for (var groupId = 0; groupId < nbVarGroups(i); groupId++) {
          for (var varId = 0; varId < nbVariations(i, groupId); varId++) {
            final vIngredients =
                removePlural(variation(i, groupId, varId).ingredients);

            for (var s in ingredients) {
              if (vIngredients.contains(s)) {
                List<int> vIds = List.filled(nbVarGroups(i), 0);
                vIds[groupId] = varId;

                ids[i] = RecipeId(
                  recipeId: i,
                  servings: servings,
                  variationIds: vIds,
                );

                break;
              }
            }

            if (ids[i] != null) break;
          }

          if (ids[i] != null) break;
        }
      }
    }

    ids.removeWhere((e) => e == null);

    return List<RecipeId>.from(ids);
  }

  List<String> removePlural(List<IngredientData> ingredients) {
    RegExp regex = RegExp(r'\(.*\)');
    return ingredients.map((e) => e.name.replaceAll(regex, '')).toList();
  }

  // Getters

  RecipeData recipe(int recipeId) {
    return RecipeData.from(_recipes[recipeId]);
  }

  VariationGroup variationGroup(int recipeId, int variationGroupId) {
    return recipe(recipeId).variationGroups.elementAtOrNull(variationGroupId) ??
        VariationGroup.empty();
  }

  Variation variation(int recipeId, int variationGroupId, int variationId) {
    return variationGroup(recipeId, variationGroupId)
            .variations
            .elementAtOrNull(variationId) ??
        Variation.empty();
  }

  String name(int recipeId) {
    return recipe(recipeId).name;
  }

  String difficulty(int recipeId) {
    return recipe(recipeId).difficulty;
  }

  String price(int recipeId) {
    return recipe(recipeId).price;
  }

  String variationGroupName(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).groupName;
  }

  String variationName(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).name;
  }

  String variationTime(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).time;
  }

  int get number => _recipes.length;

  int nbVarGroups(int recipeId) {
    return recipe(recipeId).variationGroups.length;
  }

  int nbVariations(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).variations.length;
  }
}
