import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsEditorPage extends StatefulWidget {
  final int recipeId;
  final PageController controller;

  const IngredientsEditorPage({
    super.key,
    required this.recipeId,
    required this.controller,
  });

  @override
  State<IngredientsEditorPage> createState() => _IngredientsEditorPageState();
}

class _IngredientsEditorPageState extends State<IngredientsEditorPage> {
  bool removing = false;
  bool variations = false;
  int? varGroupId;
  int? varId;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        List<Widget> items = [];
        final ingNb = recipes.recipe(widget.recipeId).ingredients.length;

        if (!variations) {
          for (var i = 0; i < ingNb; i++) {
            items.add(IngredientItem(
              recipeId: widget.recipeId,
              ingredientId: i,
              enableTextField: !removing,
            ));
          }
        } else if (varGroupId == null && varId == null) {
          for (var i = 0; i < recipes.nbVarGroups(widget.recipeId); i++) {
            for (var j = 0; j < recipes.nbVariations(widget.recipeId, i); j++) {
              final names = recipes
                  .recipe(widget.recipeId)
                  .variationGroups[i]
                  .variations[j]
                  .ingredients
                  .map((e) => e.getName(2));

              items.add(
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: GradientButton(
                    gradient: toSurfaceGradient(greenGradient),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    onPressed: () => setState(() {
                      varGroupId = i;
                      varId = j;
                    }),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                            child: GradientIcon(
                              gradient: greenGradient,
                              icon: Icons.panorama_fish_eye,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: recipes.variationName(
                                      widget.recipeId, i, j),
                                  weight: FontWeight.w600,
                                  color: toTextGradient(greenGradient)[1],
                                ),
                                const SizedBox(height: 4),
                                CustomText(
                                  text: names.isEmpty
                                      ? 'No ingredients yet'
                                      : names.join(', '),
                                  color: toTextGradient(greenGradient)[1],
                                  opacity: 0.6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        } else {
          final nb = recipes
              .variation(widget.recipeId, varGroupId!, varId!)
              .ingredients
              .length;

          for (var i = 0; i < nb; i++) {
            items.add(IngredientItem(
              recipeId: widget.recipeId,
              variationGroupId: varGroupId,
              variationId: varId,
              ingredientId: i,
              enableTextField: !removing,
            ));
          }
        }

        return EmptyPage(
          appBarText: variations ? 'Ingredients in variations' : 'Ingredients',
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 2 * 20 + 53
                      : MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: ListView(
                  children: items,
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
                        !variations || (varGroupId != null && varId != null)
                            ? GradientButton(
                                diameter: 53,
                                gradient: removing
                                    ? redGradient
                                    : toLighterSurfaceGradient(redGradient),
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                onPressed: () =>
                                    setState(() => removing = !removing),
                                child: Center(
                                  child: GradientIcon(
                                    gradient: removing
                                        ? toLighterSurfaceGradient(redGradient)
                                        : redGradient,
                                    icon: UniconsLine.minus,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 53 / 3),
                        GradientButton(
                          diameter: 53,
                          gradient:
                              variations && varGroupId == null && varId == null
                                  ? greenGradient
                                  : toLighterSurfaceGradient(greenGradient),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          onPressed: () {
                            if (varGroupId == null && varId == null) {
                              setState(() => variations = !variations);
                            } else {
                              setState(() {
                                varGroupId = null;
                                varId = null;
                              });
                            }
                          },
                          child: Center(
                            child: GradientIcon(
                              gradient: variations &&
                                      varGroupId == null &&
                                      varId == null
                                  ? toLighterSurfaceGradient(greenGradient)
                                  : greenGradient,
                              icon: Icons.layers,
                            ),
                          ),
                        ),
                        const SizedBox(width: 53 / 3),
                        !variations || (varGroupId != null && varId != null)
                            ? GradientButton(
                                diameter: 53,
                                gradient:
                                    toLighterSurfaceGradient(limelightGradient),
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                onPressed: () {
                                  if (removing == true) {
                                    setState(() => removing = false);
                                  }

                                  if (varGroupId == null && varId == null) {
                                    recipes.addIngredient(widget.recipeId,
                                        IngredientData.empty());
                                  } else {
                                    recipes.addVarIngredient(
                                        widget.recipeId,
                                        varGroupId!,
                                        varId!,
                                        IngredientData.empty());
                                  }
                                },
                                child: const Center(
                                  child: GradientIcon(
                                    gradient: limelightGradient,
                                    icon: Icons.add,
                                    size: 26,
                                  ),
                                ),
                              )
                            : const SizedBox(),
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

class IngredientItem extends StatefulWidget {
  final int recipeId;
  final int? variationGroupId;
  final int? variationId;
  final int ingredientId;
  final bool enableTextField;

  const IngredientItem({
    super.key,
    required this.recipeId,
    this.variationGroupId,
    this.variationId,
    required this.ingredientId,
    required this.enableTextField,
  });

  @override
  State<IngredientItem> createState() => _IngredientItemState();
}

class _IngredientItemState extends State<IngredientItem> {
  late FocusNode node;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        IngredientData ingredient = IngredientData.empty();
        if (widget.variationGroupId == null || widget.variationId == null) {
          ingredient =
              recipes.recipe(widget.recipeId).ingredient(widget.ingredientId);
        } else {
          ingredient = recipes
              .recipe(widget.recipeId)
              .variationGroups[widget.variationGroupId!]
              .variation(widget.variationId!)
              .ingredient(widget.ingredientId);
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: GradientButton(
            gradient: toSurfaceGradient(limelightGradient),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            disabled: widget.enableTextField,
            onPressed: () {
              if (!widget.enableTextField) {
                if (widget.variationGroupId == null ||
                    widget.variationId == null) {
                  recipes.removeIngredient(
                      widget.recipeId, widget.ingredientId);
                } else {
                  recipes.removeVarIngredient(
                      widget.recipeId,
                      widget.variationGroupId!,
                      widget.variationId!,
                      widget.ingredientId);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                    child:
                        GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (text) {
                        if (widget.variationGroupId == null &&
                            widget.variationId == null) {
                          recipes.editIngredientName(
                              widget.recipeId, widget.ingredientId, text);
                        } else {
                          recipes.editVarIngredientName(
                              widget.recipeId,
                              widget.variationGroupId!,
                              widget.variationId!,
                              widget.ingredientId,
                              text);
                        }
                      },
                      onFieldSubmitted: (_) {
                        recipes.notify();
                        if (ingredient.quantity == 0.0) {
                          node.requestFocus();
                        }
                      },
                      initialValue: ingredient.name,
                      style: GoogleFonts.openSans(color: textColor()),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      enabled: widget.enableTextField,
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: ingredient.name == '',
                    ),
                  ),
                  const SizedBox(width: 10),
                  IntrinsicWidth(
                    child: TextFormField(
                      focusNode: node,
                      textAlign: TextAlign.right,
                      onFieldSubmitted: (text) {
                        if (text == 'some') {
                          ingredient.quantity = 1;
                          ingredient.unit = 'some';
                        } else {
                          var reg = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
                          ingredient.quantity = reg
                              .allMatches(text)
                              .map((e) =>
                                  e[0] == null ? 0.0 : double.parse(e[0]!))
                              .toList()[0];

                          ingredient.unit = text.replaceAll(reg, '');
                        }

                        if (widget.variationGroupId == null &&
                            widget.variationId == null) {
                          recipes.editIngredient(
                              widget.recipeId, widget.ingredientId, ingredient);
                        } else {
                          recipes.editVarIngredient(
                              widget.recipeId,
                              widget.variationGroupId!,
                              widget.variationId!,
                              widget.ingredientId,
                              ingredient);
                        }
                      },
                      initialValue: ingredient.unit == 'some'
                          ? 'some'
                          : ingredient.quantity == 0.0 && ingredient.unit == ''
                              ? ''
                              : '${ingredient.quantity}${ingredient.unit}',
                      style: GoogleFonts.openSans(
                        color: textColor().withOpacity(0.6),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            ingredient.quantity == 0.0 && ingredient.unit == ''
                                ? '0.0'
                                : null,
                        hintStyle: GoogleFonts.openSans(
                          color: textColor().withOpacity(0.4),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      enabled: widget.enableTextField,
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
