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
    notify();
  }

  void remove(int recipeId) {
    _recipes.removeAt(recipeId);
    notify();
  }

  void removeIngredient(int recipeId, int ingredientId) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    final name = recipe.ingredient(ingredientId).getName(1);

    recipe.instructions = recipe.instructions
        .map((e) => e.replaceAll('{$ingredientId:quantity}', name))
        .toList();

    for (var i = ingredientId + 1; i < recipe.ingredients.length; i++) {
      recipe.instructions = recipe.instructions
          .map((e) => e.replaceAll('{$i:quantity}', '{${i - 1}:quantity}'))
          .toList();
    }

    for (var i = 0; i < recipe.variationGroups.length; i++) {
      final numVars = recipe.variationGroups[i].variations.length;
      for (var j = 0; j < numVars; j++) {
        final numIGroups =
            recipe.variationGroups[i].variations[j].instructionGroups.length;

        for (var k = 0; k < numIGroups; k++) {
          recipe.variationGroups[i].variations[j].instructionGroups[k] = recipe
              .variationGroups[i].variations[j].instructionGroups[k]
              .map((e) => e.replaceAll('{$ingredientId:quantity}', name))
              .toList();

          for (var l = ingredientId + 1; l < recipe.ingredients.length; l++) {
            recipe.variationGroups[i].variations[j].instructionGroups[k] =
                recipe.variationGroups[i].variations[j].instructionGroups[k]
                    .map((e) =>
                        e.replaceAll('{$l:quantity}', '{${l - 1}:quantity}'))
                    .toList();
          }
        }
      }
    }

    recipe.ingredients.removeAt(ingredientId);
    notify();
  }

  void addIngredient(int recipeId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.ingredients.add(ingredient);
    notify();
  }

  void removeVarIngredient(
      int recipeId, int varGroupId, int varId, int ingredientId) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    final name = recipe
        .variationGroups[varGroupId].variations[varId].ingredients[ingredientId]
        .getName(1);

    final ingNb =
        recipe.variationGroups[varGroupId].variations[varId].ingredients.length;
    final len = recipe
        .variationGroups[varGroupId].variations[varId].instructionGroups.length;
    for (var i = 0; i < len; i++) {
      recipe.variationGroups[varGroupId].variations[varId]
              .instructionGroups[i] =
          recipe.variationGroups[varGroupId].variations[varId]
              .instructionGroups[i]
              .map((e) => e.replaceAll(
                  '{$varGroupId:$varId:$ingredientId:quantity}', name))
              .toList();

      for (var j = ingredientId + 1; j < ingNb; j++) {
        recipe.instructions = recipe.instructions
            .map((e) => e.replaceAll('{$varGroupId:$varId:$j:quantity}',
                '{$varGroupId:$varId:${j - 1}:quantity}'))
            .toList();
      }
    }

    recipe.variationGroups[varGroupId].variations[varId].ingredients
        .removeAt(ingredientId);
    notify();
  }

  void addVarIngredient(
      int recipeId, int varGroupId, int varId, IngredientData ingredient) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

    recipe.variationGroups[varGroupId].variations[varId].ingredients
        .add(ingredient);
    notify();
  }

  void addEmptyInstruction(int recipeId, int instructionId) {
    _recipes[recipeId].instructions.insert(instructionId, '');
    notify();
  }

  void addEmptyVarInstruction(int recipeId, int variationGroupId,
      int variationId, int instructionGroupId, int instructionId) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups[instructionGroupId]
        .insert(instructionId, '');

    notify();
  }

  void removeInstruction(int recipeId, int instructionId) {
    _recipes[recipeId].instructions.removeAt(instructionId);
    notify();
  }

  void removeVarInstruction(int recipeId, int variationGroupId, int variationId,
      int instructionGroupId, int instructionId) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups[instructionGroupId]
        .removeAt(instructionId);

    notify();
  }

  void moveInstruction(int recipeId, int oldId, int newId) {
    if (oldId < newId) newId -= 1;

    final String item = _recipes[recipeId].instructions.removeAt(oldId);
    _recipes[recipeId].instructions.insert(newId, item);

    notify();
  }

  void moveVarInstruction(int recipeId, int variationGroupId, int variationId,
      int instructionGroupId, int oldId, int newId) {
    if (oldId < newId) newId -= 1;

    final String item = _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups[instructionGroupId]
        .removeAt(oldId);

    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups[instructionGroupId]
        .insert(newId, item);

    notify();
  }

  void removeVarInstructionGroup(int recipeId, int variationGroupId,
      int variationId, int instructionGroupId) {
    _recipes[recipeId].instructions.remove(
        '{$variationGroupId:$variationId:$instructionGroupId:instruction}');

    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups
        .removeAt(instructionGroupId);

    notify();
  }

  void addEmptyInstructionGroup(
      int recipeId, int instructionId, int groupId, int varId) {
    final nbGroups = _recipes[recipeId]
        .variationGroups[groupId]
        .variations[varId]
        .instructionGroups
        .length;

    _recipes[recipeId]
        .instructions
        .insert(instructionId, '{$groupId:$varId:$nbGroups:instruction}');

    _recipes[recipeId]
        .variationGroups[groupId]
        .variations[varId]
        .instructionGroups
        .add(['']);

    notify();
  }

  void editName(int recipeId, String name) {
    _recipes[recipeId].name = name;
    save();
    //notify();
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

  void editIngredientName(
    int recipeId,
    int ingredientId,
    String name,
  ) {
    _recipes[recipeId].ingredients[ingredientId].name = name;

    save();
  }

  void editVarIngredientName(
    int recipeId,
    int variationGroupId,
    int variationId,
    int ingredientId,
    String name,
  ) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .ingredients[ingredientId]
        .name = name;

    save();
  }

  void addVarGroup(int recipeId) {
    _recipes[recipeId].variationGroups.add(VariationGroup.empty());
    notify();
  }

  void removeVarGroup(int recipeId, int varGroupId) {
    _recipes[recipeId].variationGroups.removeAt(varGroupId);
    notify();
  }

  void addVariation(int recipeId, int varGroupId) {
    _recipes[recipeId]
        .variationGroups[varGroupId]
        .variations
        .add(Variation.empty());
    notify();
  }

  void removeVariation(int recipeId, int varGroupId, int varId) {
    _recipes[recipeId].variationGroups[varGroupId].variations.removeAt(varId);
    notify();
  }

  void editVarGroupName(int recipeId, int variationGroupId, String name) {
    _recipes[recipeId].variationGroups[variationGroupId].groupName = name;
    save();
  }

  void editVarName(
    int recipeId,
    int variationGroupId,
    int variationId,
    String name,
  ) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .name = name;

    save();
  }

  void editInstruction(
    int recipeId,
    int instructionId,
    String instruction,
  ) {
    _recipes[recipeId].instructions[instructionId] = instruction;

    save();
    //notify();
  }

  void editVarInstruction(
    int recipeId,
    int variationGroupId,
    int variationId,
    int instructionGroupId,
    int instructionId,
    String instruction,
  ) {
    _recipes[recipeId]
        .variationGroups[variationGroupId]
        .variations[variationId]
        .instructionGroups[instructionGroupId][instructionId] = instruction;

    save();
    //notify();
  }

  void save() {
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
  }

  void notify() {
    save();
    notifyListeners();
  }

  // Probably not a good idea...
  void notifyList() {
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

      for (var ingredient in l) {
        final id = list.indexWhere(
            (e) => ingredient.name == e.name && ingredient.unit == e.unit);

        if (id == -1) {
          list.add(ingredient);
        } else {
          list[id].quantity = list[id].quantity + ingredient.quantity;
        }
      }
    }

    for (var ingredient in list) {
      ingredient.multiply(id.servings);
      ingredient.unit = ingredient.getUnit(ingredient.quantity.round());
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

  List<RecipeId?> search(List<String> ingredients, int servings) {
    List<RecipeId?> ids = [];

    for (var i = 0; i < number; i++) {
      ids.add(null);

      final gIngredients = removePlural(recipe(i).ingredients);
      for (var s in ingredients) {
        for (var ing in gIngredients) {
          if (ing.contains(s)) {
            ids[i] = RecipeId(recipeId: i, servings: servings);
            break;
          }
        }

        if (ids[i] != null) break;
      }

      if (ids[i] == null) {
        for (var groupId = 0; groupId < nbVarGroups(i); groupId++) {
          for (var varId = 0; varId < nbVariations(i, groupId); varId++) {
            final vIngredients =
                removePlural(variation(i, groupId, varId).ingredients);

            for (var s in ingredients) {
              for (var ing in vIngredients) {
                if (ing.contains(s)) {
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

          if (ids[i] != null) break;
        }
      }
    }

    return ids;
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

  String variationGroupName(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).groupName;
  }

  String variationName(int recipeId, int variationGroupId, int variationId) {
    return variation(recipeId, variationGroupId, variationId).name;
  }

  int get number => _recipes.length;

  int nbVarGroups(int recipeId) {
    return recipe(recipeId).variationGroups.length;
  }

  int nbVariations(int recipeId, int variationGroupId) {
    return variationGroup(recipeId, variationGroupId).variations.length;
  }

  int nbInstructions(int recipeId) {
    return recipe(recipeId).instructions.length;
  }

  int nbInstructionsInVar(int recipeId, int variationGroupId, int variationId,
      int instructionGroupId) {
    return variation(recipeId, variationGroupId, variationId)
        .instructionGroup(instructionGroupId)
        .length;
  }
}
