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

  void removeIngredient(int recipeId, int ingredientId) {
    final recipe = _recipes.elementAtOrNull(recipeId);
    if (recipe == null) return;

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

  void editDifficulty(int recipeId, String diff) {
    _recipes[recipeId].difficulty = diff;
    save();
    //notify();
  }

  void editIngredient(
    int recipeId,
    int ingredientId,
    IngredientData ingredient,
  ) {
    _recipes[recipeId].ingredients[ingredientId] = ingredient;

    //notify();
    save();
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

    //notify();
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

    notify();
  }

  void editInstruction(
    int recipeId,
    int instructionId,
    String instruction,
  ) {
    _recipes[recipeId].instructions[instructionId] = instruction;

    notify();
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

    notify();
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
