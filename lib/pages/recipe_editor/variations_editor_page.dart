import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class VariationsEditorPage extends StatefulWidget {
  final int recipeId;
  final PageController controller;

  const VariationsEditorPage({
    super.key,
    required this.recipeId,
    required this.controller,
  });

  @override
  State<VariationsEditorPage> createState() => _VariationsEditorPageState();
}

class _VariationsEditorPageState extends State<VariationsEditorPage> {
  bool removing = false;
  int? groupId;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        return EmptyPage(
          appBarText: groupId == null
              ? 'Variations'
              : recipes.variationGroupName(widget.recipeId, groupId!),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 2 * 20 + 53
                      : MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: ListView(
                  children: groupId == null
                      ? List.generate(
                          recipes.nbVarGroups(widget.recipeId),
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                              child: GradientButton(
                                gradient: toSurfaceGradient(greenGradient),
                                borderRadius: 20,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                onPressed: removing == true
                                    ? () => recipes.removeVarGroup(
                                        widget.recipeId, index)
                                    : () => setState(() => groupId = index),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 22, 15),
                                        child: GradientIcon(
                                          gradient: greenGradient,
                                          icon: Icons.panorama_fish_eye,
                                          size: 22,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          key: Key('$index'),
                                          onChanged: (text) {
                                            recipes.editVarGroupName(
                                                widget.recipeId, index, text);
                                          },
                                          initialValue:
                                              recipes.variationGroupName(
                                                  widget.recipeId, index),
                                          style: GoogleFonts.openSans(
                                            color: textColor(),
                                          ),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                          autofocus: recipes.variationGroupName(
                                                  widget.recipeId, index) ==
                                              '',
                                          enabled: !removing,
                                          textCapitalization:
                                              TextCapitalization.sentences,
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
                          },
                        )
                      : List.generate(
                          recipes.nbVariations(widget.recipeId, groupId!),
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                              child: GradientButton(
                                gradient: toSurfaceGradient(limelightGradient),
                                borderRadius: 20,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                onPressed: removing == true
                                    ? () => recipes.removeVariation(
                                        widget.recipeId, groupId!, index)
                                    : () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 22, 15),
                                        child: GradientIcon(
                                          icon: Icons.panorama_fish_eye,
                                          size: 22,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          key: Key('$groupId:$index'),
                                          onChanged: (text) {
                                            recipes.editVarName(widget.recipeId,
                                                groupId!, index, text);
                                          },
                                          initialValue: recipes.variationName(
                                              widget.recipeId, groupId!, index),
                                          style: GoogleFonts.openSans(
                                            color: textColor(),
                                          ),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                          autofocus: recipes.variationName(
                                                  widget.recipeId,
                                                  groupId!,
                                                  index) ==
                                              '',
                                          enabled: !removing,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
                        groupId != null
                            ? GradientButton(
                                diameter: 53,
                                gradient: greenGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                onPressed: () => setState(() => groupId = null),
                                child: Center(
                                  child: GradientIcon(
                                    gradient:
                                        toLighterSurfaceGradient(greenGradient),
                                    icon: Icons.layers,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(width: groupId != null ? 53 / 3 : 0),
                        GradientButton(
                          diameter: 53,
                          gradient: toLighterSurfaceGradient(limelightGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: groupId == null
                              ? () => recipes.addVarGroup(widget.recipeId)
                              : () => recipes.addVariation(
                                  widget.recipeId, groupId!),
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
          ),
        );
      },
    );
  }
}
