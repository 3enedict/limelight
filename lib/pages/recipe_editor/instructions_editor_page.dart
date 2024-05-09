import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/recipe_editor_page.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
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
  bool removing = false;

  int? groupId;
  int? varId;
  int? instGrpId; // Instruction group id

  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // I promise, this isn't stupid. It solves the problem of creating a new context
    // so that showBottomSheet can use it instead of the context given by a stateful widget
    // (which doesn't work)
    final recipeModel = Provider.of<RecipeModel>(context, listen: false);

    return EmptyPage(
      appBarText: checkId()
          ? 'Instructions'
          : recipeModel.variationName(widget.recipeId, groupId!, varId!),
      child: Consumer<RecipeModel>(
        builder: (context, recipes, child) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 2 * 20 + 53
                      : MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: ReorderableListView(
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(begin: 1, end: 0.9).chain(
                            CurveTween(curve: Curves.linear),
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  scrollController: controller,
                  children: checkId()
                      ? List.generate(
                          recipes.recipe(widget.recipeId).instructions.length,
                          (index) {
                            String text = recipes
                                .recipe(widget.recipeId)
                                .instructions[index];

                            final variationRegex = RegExp(
                              r'\{([0-9]+):([0-9]+):([0-9]+):instruction\}',
                            );

                            if (variationRegex.hasMatch(text)) {
                              final match = variationRegex.firstMatch(text)!;
                              final variationGroupId =
                                  int.parse(match.group(1) ?? "-1");
                              final variationId =
                                  int.parse(match.group(2) ?? "-1");
                              final instructionGrpId =
                                  int.parse(match.group(3) ?? "-1");

                              return Padding(
                                key: Key('$index'),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: GradientButton(
                                  gradient: toSurfaceGradient(greenGradient),
                                  borderRadius: 20,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  onPressed: removing == true
                                      ? () {
                                          recipes.removeVarInstructionGroup(
                                            widget.recipeId,
                                            variationGroupId,
                                            variationId,
                                            instructionGrpId,
                                          );
                                        }
                                      : () => setState(() {
                                            groupId = variationGroupId;
                                            varId = variationId;
                                            instGrpId = instructionGrpId;
                                          }),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 15, 22, 15),
                                          child: GradientIcon(
                                            gradient: greenGradient,
                                            icon: Icons.panorama_fish_eye,
                                            size: 22,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            text: recipes.variationName(
                                              widget.recipeId,
                                              variationGroupId,
                                              variationId,
                                            ),
                                            size: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: GradientIcon(
                                            gradient:
                                                toTextGradient(greenGradient),
                                            icon: Icons.chevron_right,
                                            size: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InstructionItem(
                                key: Key('$index'),
                                recipeId: widget.recipeId,
                                instructionId: index,
                                removing: removing,
                              );
                            }
                          },
                        )
                      : List.generate(
                          recipes.nbInstructionsInVar(
                              widget.recipeId, groupId!, varId!, instGrpId!),
                          (int index) {
                            return InstructionItem(
                              key: Key('$index'),
                              recipeId: widget.recipeId,
                              variationGroupId: groupId,
                              variationId: varId,
                              instructionGroupId: instGrpId,
                              instructionId: index,
                              removing: removing,
                            );
                          },
                        ),
                  onReorder: (int oldIndex, int newIndex) {
                    if (checkId()) {
                      recipes.moveInstruction(
                          widget.recipeId, oldIndex, newIndex);
                    } else {
                      recipes.moveVarInstruction(widget.recipeId, groupId!,
                          varId!, instGrpId!, oldIndex, newIndex);
                    }
                  },
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
                          gradient: removing
                              ? redGradient
                              : toLighterSurfaceGradient(redGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: () => setState(() => removing = !removing),
                          child: Center(
                            child: GradientIcon(
                              gradient: removing
                                  ? toLighterSurfaceGradient(redGradient)
                                  : redGradient,
                              icon: UniconsLine.minus,
                            ),
                          ),
                        ),
                        const SizedBox(width: 53 / 3),
                        GradientButton(
                          diameter: 53,
                          gradient: toLighterSurfaceGradient(greenGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: checkId()
                              ? () => variationSelector(recipes, context)
                              : () => setState(() {
                                    groupId = null;
                                    varId = null;
                                    instGrpId = null;
                                  }),
                          child: Center(
                            child: GradientIcon(
                              gradient: checkId()
                                  ? greenGradient
                                  : toTextGradient(greenGradient),
                              icon: checkId() ? Icons.layers : Icons.close,
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
                            if (checkId()) {
                              recipes.addEmptyInstruction(widget.recipeId,
                                  recipes.nbInstructions(widget.recipeId));
                            } else {
                              final nb = recipes.nbInstructionsInVar(
                                  widget.recipeId,
                                  groupId!,
                                  varId!,
                                  instGrpId!);

                              recipes.addEmptyVarInstruction(widget.recipeId,
                                  groupId!, varId!, instGrpId!, nb);
                            }
                          },
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

  bool checkId() {
    return groupId == null || varId == null || instGrpId == null;
  }

  void variationSelector(RecipeModel recipes, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        int nbTotVars = 0;
        for (var i = 0; i < recipes.nbVarGroups(widget.recipeId); i++) {
          nbTotVars = nbTotVars + recipes.nbVariations(widget.recipeId, i);
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  reverse: true,
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
                              recipes.nbVariations(widget.recipeId, gId) - 1) {
                            vId++;
                          } else {
                            vId = 0;
                            gId++;
                          }

                          i--;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GradientButton(
                            gradient: toSurfaceGradient(greenGradient),
                            onPressed: () {
                              final instructionId =
                                  recipes.nbInstructions(widget.recipeId);

                              recipes.addEmptyInstructionGroup(
                                  widget.recipeId, instructionId, gId, vId);

                              controller.animateTo(
                                controller.position.maxScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );

                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  child: GradientIcon(
                                    gradient: greenGradient,
                                    icon: Icons.panorama_fish_eye,
                                    size: 23,
                                  ),
                                ),
                                CustomText(
                                  color: toTextGradient(greenGradient)[1],
                                  text: recipes.variationName(
                                      widget.recipeId, gId, vId),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                  ].reversed.toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GradientButton(
                  diameter: 53,
                  gradient: toLighterSurfaceGradient(greenGradient),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Center(
                    child: GradientIcon(
                      gradient: greenGradient,
                      icon: Icons.close,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class InstructionItem extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int? instructionGroupId;
  final int instructionId;
  final bool removing;

  const InstructionItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    this.instructionGroupId,
    required this.instructionId,
    this.removing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        String text = '';
        List<String> names = [];
        if (variationGroupId == null ||
            variationId == null ||
            instructionGroupId == null) {
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
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: GradientButton(
            gradient: toSurfaceGradient(limelightGradient),
            borderRadius: 20,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            onPressed: removing == true
                ? () {
                    if (variationGroupId == null ||
                        variationId == null ||
                        instructionGroupId == null) {
                      recipes.removeInstruction(recipeId, instructionId);
                    } else {
                      recipes.removeVarInstruction(recipeId, variationGroupId!,
                          variationId!, instructionGroupId!, instructionId);
                    }
                  }
                : () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                    child: GradientIcon(
                      icon: Icons.panorama_fish_eye,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: InstructionTextField(
                      key: Key(text),
                      recipes: recipes,
                      recipeId: recipeId,
                      gId: variationGroupId,
                      vId: variationId,
                      igId: instructionGroupId,
                      iId: instructionId,
                      text: text,
                      names: names,
                      enableTextField: !removing,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// All of this, just for one thing : Putting the controller in initState()
class InstructionTextField extends StatefulWidget {
  final RecipeModel recipes;
  final int recipeId;
  final int? gId;
  final int? vId;
  final int? igId;
  final int iId;
  final String text;
  final List<String> names;
  final bool enableTextField;

  const InstructionTextField({
    super.key,
    required this.recipes,
    required this.recipeId,
    required this.gId,
    required this.vId,
    required this.igId,
    required this.iId,
    required this.text,
    required this.names,
    required this.enableTextField,
  });

  @override
  State<InstructionTextField> createState() => _InstructionTextFieldState();
}

class _InstructionTextFieldState extends State<InstructionTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = MultiStyleTextEditingController(
      ingredientNames: widget.names,
    )..text = widget.text;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: Key(widget.text),
      enabled: widget.enableTextField,
      autofocus: widget.text == '',
      onChanged: (newText) {
        String instruction = newText;
        if (widget.gId == null || widget.vId == null || widget.igId == null) {
          for (var i = 0; i < widget.names.length; i++) {
            instruction =
                instruction.replaceAll(widget.names[i], '{$i:quantity}');
          }

          widget.recipes
              .editInstruction(widget.recipeId, widget.iId, instruction);
        } else {
          for (var i = 0; i < widget.names.length; i++) {
            instruction = instruction.replaceAll(
                widget.names[i], '{${widget.gId}:${widget.vId}:$i:quantity}');
          }

          widget.recipes.editVarInstruction(widget.recipeId, widget.gId!,
              widget.vId!, widget.igId!, widget.iId, instruction);
        }
      },
      onSubmitted: (_) => widget.recipes.notify(),
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      cursorHeight: 20,
    );
  }
}
