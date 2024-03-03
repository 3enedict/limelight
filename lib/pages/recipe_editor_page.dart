import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

List<Widget> recipeEditor(
  RecipeModel recipes,
  int recipeId,
  PageController controller,
) {
  List<Widget> items = [];

  for (var i = 0; i < recipes.recipe(recipeId).ingredients.length; i++) {
    items.add(Padding(
        padding: const EdgeInsets.fromLTRB(42, 10, 42, 0),
        child: IngredientItem(
          recipeId: recipeId,
          ingredientId: i,
        )));
  }

  for (var i = 0; i < recipes.nbVarGroups(recipeId); i++) {
    for (var j = 0; j < recipes.nbVariations(recipeId, i); j++) {
      final num = recipes
          .recipe(recipeId)
          .variationGroups[i]
          .variations[j]
          .ingredients
          .length;

      items.add(
        Section(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
          label: recipes.variationName(recipeId, i, j),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                ...List.generate(
                  num,
                  (index) => IngredientItem(
                    recipeId: recipeId,
                    variationGroupId: i,
                    variationId: j,
                    ingredientId: index,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      );
    }
  }

  final ingredientsPage = ListView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    children: [
      ...items,
      const SizedBox(height: 10),
    ],
  );

  final variationsPage = ListView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: GradientContainer(
          gradient: toSurfaceGradient(limelightGradient),
          borderRadius: 20,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                  child: GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
                ),
                Expanded(
                  child: TextField(
                    onSubmitted: (text) => recipes.editName(recipeId, text),
                    controller: TextEditingController(
                      text: recipes.name(recipeId),
                    ),
                    style: GoogleFonts.openSans(color: textColor()),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(width: 10),
                IntrinsicWidth(
                  child: TextField(
                    textAlign: TextAlign.right,
                    onSubmitted: (text) =>
                        recipes.editDifficulty(recipeId, text),
                    controller: TextEditingController(
                      text: recipes.difficulty(recipeId),
                    ),
                    style: GoogleFonts.openSans(
                      color: textColor().withOpacity(0.6),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ...List.generate(
        recipes.nbVarGroups(recipeId),
        (index) {
          List<Widget> items = [];

          items.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                    child:
                        GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (text) {
                        recipes.editVarGroupName(recipeId, index, text);
                      },
                      controller: TextEditingController(
                        text: recipes.variationGroupName(recipeId, index),
                      ),
                      style: GoogleFonts.openSans(color: textColor()),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          );

          for (var i = 0; i < recipes.nbVariations(recipeId, index); i++) {
            items.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(64, 0, 20, 0),
                child: TextField(
                  onSubmitted: (text) {
                    recipes.editVarName(recipeId, index, i, text);
                  },
                  controller: TextEditingController(
                    text: recipes.variationName(recipeId, index, i),
                  ),
                  style: GoogleFonts.openSans(
                    color: textColor().withOpacity(0.8),
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: GradientContainer(
              gradient: toSurfaceGradient(limelightGradient),
              borderRadius: 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Column(children: items),
              ),
            ),
          );
        },
      ),
    ],
  );

  final instructionsPage = ListView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    children: List.generate(
      recipes.recipe(recipeId).instructions.length,
      (index) {
        String text = recipes.recipe(recipeId).instructions[index];

        final variationRegex = RegExp(
          r'\{([0-9]+):([0-9]+):([0-9]+):instruction\}',
        );

        if (variationRegex.hasMatch(text)) {
          final match = variationRegex.firstMatch(text)!;
          final variationGroupId = int.parse(match.group(1) ?? "-1");
          final variationId = int.parse(match.group(2) ?? "-1");
          final instructionGroupId = int.parse(match.group(3) ?? "-1");

          return Section(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 4),
            label:
                recipes.variationName(recipeId, variationGroupId, variationId),
            child: Column(
              children: [
                const SizedBox(height: 5),
                ...List.generate(
                  recipes
                      .recipe(recipeId)
                      .variationGroups[variationGroupId]
                      .variations[variationId]
                      .instructionGroups[instructionGroupId]
                      .length,
                  (id) => InstructionItem(
                    recipeId: recipeId,
                    variationGroupId: variationGroupId,
                    variationId: variationId,
                    instructionGroupId: instructionGroupId,
                    instructionId: id,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        } else {
          return InstructionItem(
            recipeId: recipeId,
            instructionId: index,
          );
        }
      },
    ),
  );

  final limelight = limelightGradient.map((e) => e.withOpacity(0.8)).toList();
  final surface = toLighterSurfaceGradient(limelightGradient);
  final text = toTextGradient(limelightGradient);

  return List.generate(
    3,
    (page) {
      return EmptyPage(
        resizeToAvoidBottomInset: true,
        appBarText: ['Ingredients', 'Variations', 'Instructions'][page],
        child: Column(
          children: [
            Expanded(
              child: [
                ingredientsPage,
                variationsPage,
                instructionsPage,
              ][page],
            ),
            Container(
              color: toBackgroundGradient(limelightGradient)[1],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientButton(
                      diameter: 54,
                      gradient: page == 0 ? limelight : surface,
                      splashColor: limelightGradient[0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      onPressed: () => controller.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                      child: Center(
                        child: GradientIcon(
                          gradient: page == 0 ? surface : text,
                          icon: UniconsLine.notes,
                        ),
                      ),
                    ),
                    const SizedBox(width: 53 / 3),
                    GradientButton(
                      diameter: 53,
                      gradient: page == 1 ? limelight : surface,
                      splashColor: limelightGradient[0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      onPressed: () => controller.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                      child: Center(
                        child: GradientIcon(
                          gradient: page == 1 ? surface : text,
                          icon: Icons.layers,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 53 / 3),
                    GradientButton(
                      diameter: 54,
                      gradient: page == 2 ? limelight : surface,
                      splashColor: limelightGradient[0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      onPressed: () => controller.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      ),
                      child: Center(
                        child: GradientIcon(
                          gradient: page == 2 ? surface : text,
                          icon: UniconsLine.fire,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class IngredientItem extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int ingredientId;

  const IngredientItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    required this.ingredientId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        IngredientData ingredient = IngredientData.empty();
        if (variationGroupId == null || variationId == null) {
          ingredient = recipes.recipe(recipeId).ingredient(ingredientId);
        } else {
          ingredient = recipes
              .recipe(recipeId)
              .variationGroups[variationGroupId!]
              .variation(variationId!)
              .ingredient(ingredientId);
        }

        return Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
              child: GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (text) {
                  IngredientData ing = IngredientData.from(ingredient);
                  ing.name = text;
                  edit(recipes, ing);
                },
                controller: TextEditingController(text: ingredient.name),
                style: GoogleFonts.openSans(color: textColor()),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(width: 10),
            IntrinsicWidth(
              child: TextField(
                textAlign: TextAlign.right,
                onSubmitted: (text) {
                  IngredientData ing = IngredientData.from(ingredient);

                  if (text == 'some') {
                    ing.quantity = 1;
                    ing.unit = 'some';
                  } else {
                    var reg = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
                    ing.quantity = reg
                        .allMatches(text)
                        .map((e) => e[0] == null ? 0.0 : double.parse(e[0]!))
                        .toList()[0];

                    ing.unit = text.replaceAll(reg, '');
                  }

                  edit(recipes, ing);
                },
                controller: TextEditingController(
                  text: ingredient.unit == 'some'
                      ? 'some'
                      : '${ingredient.quantity}${ingredient.unit}',
                ),
                style: GoogleFonts.openSans(
                  color: textColor().withOpacity(0.6),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        );
      },
    );
  }

  void edit(RecipeModel recipes, IngredientData ing) {
    if (variationGroupId == null || variationId == null) {
      recipes.editIngredient(recipeId, ingredientId, ing);
    } else {
      recipes.editVarIngredient(
          recipeId, variationGroupId!, variationId!, ingredientId, ing);
    }
  }
}

class InstructionItem extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int? instructionGroupId;
  final int instructionId;

  const InstructionItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    this.instructionGroupId,
    required this.instructionId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        String text = '';
        List<String> names = [];
        if (variations()) {
          text = recipes.recipe(recipeId).instructions[instructionId];
        } else {
          text = recipes
              .recipe(recipeId)
              .variationGroups[variationGroupId!]
              .variation(variationId!)
              .instructionGroup(instructionGroupId!)[instructionId];

          final ingredientsRegex = RegExp(
            r'\{([0-9]+):([0-9]+):([0-9]+):quantity\}',
          );

          for (var match in ingredientsRegex.allMatches(text)) {
            final id = int.parse(match.group(3) ?? "-1");

            text = text.replaceAll(
              "{$variationGroupId:$variationId:$id:quantity}",
              recipes
                  .recipe(recipeId)
                  .variationGroups[variationGroupId!]
                  .variations[variationId!]
                  .ingredients[id]
                  .name,
            );
          }

          names = recipes
              .recipe(recipeId)
              .variationGroups[variationGroupId!]
              .variations[variationId!]
              .ingredients
              .map((e) => e.name)
              .toList();
        }

        final ingredientsRegex = RegExp(
          r'\{([0-9]+):quantity\}',
        );

        for (var match in ingredientsRegex.allMatches(text)) {
          final id = int.parse(match.group(1) ?? "-1");

          text = text.replaceAll(
            "{$id:quantity}",
            recipes.recipe(recipeId).ingredient(id).name,
          );
        }

        names.addAll(
            recipes.recipe(recipeId).ingredients.map((e) => e.name).toList());

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: variations() ? 42 : 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 22, top: 9),
                child: GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
              ),
              Expanded(
                child: TextField(
                  cursorHeight: 20,
                  onSubmitted: (text) {
                    String instruction = text;
                    for (var i = 0; i < names.length; i++) {
                      instruction.replaceAll(names[i], '{$i:quantity}');
                    }

                    if (!variations()) {
                      for (var i = 0; i < names.length; i++) {
                        instruction.replaceAll(names[i],
                            '{$variationGroupId:$variationId:$i:quantity}');
                      }
                    }

                    edit(recipes, instruction);
                  },
                  controller: MultiStyleTextEditingController(
                    ingredientNames: names,
                  )..text = text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.justify,
                  maxLines: null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool variations() {
    return variationGroupId == null ||
        variationId == null ||
        instructionGroupId == null;
  }

  void edit(RecipeModel recipes, String instruction) {
    if (variations()) {
      recipes.editInstruction(recipeId, instructionId, instruction);
    } else {
      recipes.editVarInstruction(recipeId, variationGroupId!, variationId!,
          instructionGroupId!, instructionId, instruction);
    }
  }
}

class MultiStyleTextEditingController extends TextEditingController {
  final List<String> ingredientNames;

  MultiStyleTextEditingController({
    required this.ingredientNames,
  });

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<String> sections = [text];
    for (var name in ingredientNames) {
      List<String> newSections = [];

      for (var section in sections) {
        List<String> list = section.split(name);
        if (list.length != 1) {
          for (var i = list.length - 1; i > 0; i--) {
            list.insert(i, name);
          }
        }

        newSections.addAll(list);
      }

      sections = newSections;
    }

    final textSpanChildren = <TextSpan>[];
    for (final section in sections) {
      const s = 17.0;

      TextStyle sectionStyle = GoogleFonts.openSans(
        textStyle: TextStyle(color: textColor(), fontSize: s),
      );
      if (ingredientNames.contains(section)) {
        sectionStyle = GoogleFonts.openSans(
          textStyle: TextStyle(
            color: textColor(),
            fontSize: s,
            fontStyle: FontStyle.italic,
          ),
        );
      }

      final child = TextSpan(text: section, style: sectionStyle);
      textSpanChildren.add(child);
    }

    return TextSpan(children: textSpanChildren);
  }
}
