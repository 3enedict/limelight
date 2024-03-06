import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/recipe_editor_page.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class InstructionsEditorPage extends StatefulWidget {
  final int recipeId;
  final PageController controller;

  const InstructionsEditorPage({
    super.key,
    required this.recipeId,
    required this.controller,
  });

  @override
  State<InstructionsEditorPage> createState() => _InstructionsEditorPageState();
}

class _InstructionsEditorPageState extends State<InstructionsEditorPage> {
  bool adding = false;
  bool removing = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        final instructionsPage = ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            const SizedBox(height: 8),
            ...List.generate(
              recipes.recipe(widget.recipeId).instructions.length,
              (index) {
                String text =
                    recipes.recipe(widget.recipeId).instructions[index];

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
                    label: recipes.variationName(
                        widget.recipeId, variationGroupId, variationId),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        ...List.generate(
                          recipes
                              .recipe(widget.recipeId)
                              .variationGroups[variationGroupId]
                              .variations[variationId]
                              .instructionGroups[instructionGroupId]
                              .length,
                          (id) {
                            final item = InstructionItem(
                              recipeId: widget.recipeId,
                              variationGroupId: variationGroupId,
                              variationId: variationId,
                              instructionGroupId: instructionGroupId,
                              instructionId: id,
                              enableTextField: !adding,
                            );

                            if (adding == true) {
                              return GestureDetector(
                                onTap: () {
                                  recipes.addEmptyVarInstruction(
                                      widget.recipeId,
                                      variationGroupId,
                                      variationId,
                                      instructionGroupId,
                                      id);

                                  setState(() => adding = false);
                                },
                                child: item,
                              );
                            } else {
                              return item;
                            }
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  );
                } else {
                  final item = InstructionItem(
                    recipeId: widget.recipeId,
                    instructionId: index,
                    enableTextField: !adding,
                  );

                  if (adding == true) {
                    return GestureDetector(
                      onTap: () {
                        recipes.addEmptyInstruction(widget.recipeId, index);
                        setState(() => adding = false);
                      },
                      child: item,
                    );
                  } else {
                    return item;
                  }
                }
              },
            ),
          ],
        );

        return EmptyPage(
          resizeToAvoidBottomInset: false,
          appBarText: 'Instructions',
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: instructionsPage,
                ),
              ),
              Container(
                color: toBackgroundGradient(limelightGradient)[1],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...generateNavigationButtons(widget.controller, 2),
                      GradientIcon(
                        gradient: adding
                            ? toTextGradient(limelightGradient)
                            : limelightGradient,
                        onPressed: () => setState(() => adding = true),
                        size: 20,
                        icon: UniconsLine.plus,
                      ),
                      GradientIcon(
                        gradient: redGradient,
                        onPressed: () => setState(() => removing = true),
                        size: 20,
                        icon: UniconsLine.minus,
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
}

class InstructionItem extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int? instructionGroupId;
  final int instructionId;
  final bool enableTextField;

  const InstructionItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    this.instructionGroupId,
    required this.instructionId,
    this.enableTextField = true,
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
                  enabled: enableTextField,
                  autofocus: text == '',
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
