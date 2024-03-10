import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/recipe_editor_page.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/flat_button.dart';
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

  int? groupId;
  int? varId;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent + 300);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      resizeToAvoidBottomInset: false,
      appBarText: 'Instructions',
      child: Consumer<RecipeModel>(
        builder: (context, recipes, child) {
          int nbTotVars = 0;
          for (var i = 0; i < recipes.nbVarGroups(widget.recipeId); i++) {
            nbTotVars = nbTotVars + recipes.nbVariations(widget.recipeId, i);
          }

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 2 * 20 + 53
                      : MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _controller,
                  reverse: true,
                  shrinkWrap: true,
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
                          final variationGroupId =
                              int.parse(match.group(1) ?? "-1");
                          final variationId = int.parse(match.group(2) ?? "-1");
                          final instructionGroupId =
                              int.parse(match.group(3) ?? "-1");

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
                                      enableTextField: !(adding ||
                                          removing ||
                                          groupId != null ||
                                          varId != null),
                                    );

                                    if (adding == true ||
                                        removing == true ||
                                        groupId != null ||
                                        varId != null) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (adding == true) {
                                            recipes.addEmptyVarInstruction(
                                                widget.recipeId,
                                                variationGroupId,
                                                variationId,
                                                instructionGroupId,
                                                id + 1);

                                            setState(() {
                                              adding = false;
                                            });
                                          } else if (removing == true) {
                                            recipes.removeVarInstruction(
                                                widget.recipeId,
                                                variationGroupId,
                                                variationId,
                                                instructionGroupId,
                                                id);

                                            setState(() => removing = false);
                                          } else {
                                            recipes.addEmptyInstructionGroup(
                                                widget.recipeId,
                                                index + 1,
                                                groupId!,
                                                varId!);

                                            setState(() {
                                              groupId = null;
                                              varId = null;
                                            });
                                          }
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
                            enableTextField: !(adding ||
                                removing ||
                                groupId != null ||
                                varId != null),
                          );

                          if (adding == true ||
                              removing == true ||
                              groupId != null ||
                              varId != null) {
                            return GestureDetector(
                              onTap: () {
                                if (adding == true) {
                                  recipes.addEmptyInstruction(
                                      widget.recipeId, index + 1);

                                  setState(() => adding = false);
                                } else if (removing == true) {
                                  recipes.removeInstruction(
                                      widget.recipeId, index);

                                  setState(() => removing = false);
                                } else {
                                  recipes.addEmptyInstructionGroup(
                                      widget.recipeId,
                                      index + 1,
                                      groupId!,
                                      varId!);

                                  setState(() {
                                    groupId = null;
                                    varId = null;
                                  });
                                }
                              },
                              child: item,
                            );
                          } else {
                            return item;
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ].reversed.toList(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: toBackgroundGradient(limelightGradient)[1],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientButton(
                          diameter: 53,
                          gradient: toLighterSurfaceGradient(redGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: () => setState(() => removing = true),
                          child: const Center(
                            child: GradientIcon(
                              gradient: redGradient,
                              icon: UniconsLine.minus,
                            ),
                          ),
                        ),
                        const SizedBox(width: 53 / 3),
                        GradientButton(
                          diameter: 53,
                          gradient: toLighterSurfaceGradient(limelightGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: () {
                            Scaffold.of(context).showBottomSheet(
                              (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30, 0, 30, 20 + 53 + 10),
                                  child: GradientContainer(
                                    gradient:
                                        toSurfaceGradient(limelightGradient),
                                    borderRadius: 15,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 5),
                                        ...List.generate(
                                          nbTotVars,
                                          (index) {
                                            int i = index;
                                            int gId = 0;
                                            int vId = 0;

                                            // If ever you're refactoring around here, clean this up :
                                            while (i > 0) {
                                              if (vId <
                                                  recipes.nbVariations(
                                                          widget.recipeId,
                                                          gId) -
                                                      1) {
                                                vId++;
                                              } else {
                                                vId = 0;
                                                gId++;
                                              }

                                              i--;
                                            }

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    groupId = gId;
                                                    varId = vId;
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 12, 20, 12),
                                                      child: GradientIcon(
                                                          icon: Icons
                                                              .panorama_fish_eye,
                                                          size: 22),
                                                    ),
                                                    CustomText(
                                                      text:
                                                          recipes.variationName(
                                                              widget.recipeId,
                                                              gId,
                                                              vId),
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            );
                          },
                          child: Center(
                            child: GradientIcon(
                              gradient: toTextGradient(limelightGradient),
                              icon: Icons.layers,
                            ),
                          ),
                        ),
                        const SizedBox(width: 53 / 3),
                        GradientButton(
                          diameter: 53,
                          gradient: toLighterSurfaceGradient(limelightGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: () => setState(() => adding = true),
                          child: const Center(
                            child: GradientIcon(
                              gradient: limelightGradient,
                              icon: UniconsLine.plus,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
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
                child: Focus(
                  child: TextField(
                    enabled: enableTextField,
                    autofocus: text == '',
                    cursorHeight: 20,
                    scrollPadding: const EdgeInsets.only(bottom: 200),
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
