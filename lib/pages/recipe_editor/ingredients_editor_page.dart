import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/widgets/section.dart';
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
  bool adding = false;
  bool removing = false;

  bool editing = false;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent + 500);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        List<Widget> items = [];

        for (var i = 0;
            i < recipes.recipe(widget.recipeId).ingredients.length;
            i++) {
          items.add(Padding(
              padding: const EdgeInsets.fromLTRB(42, 10, 42, 0),
              child: IngredientItem(
                recipeId: widget.recipeId,
                ingredientId: i,
              )));
        }

        for (var i = 0; i < recipes.nbVarGroups(widget.recipeId); i++) {
          for (var j = 0; j < recipes.nbVariations(widget.recipeId, i); j++) {
            final num = recipes
                .recipe(widget.recipeId)
                .variationGroups[i]
                .variations[j]
                .ingredients
                .length;

            items.add(
              Section(
                padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                label: recipes.variationName(widget.recipeId, i, j),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      ...List.generate(
                        num,
                        (index) => IngredientItem(
                          recipeId: widget.recipeId,
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

        return EmptyPage(
          resizeToAvoidBottomInset: false,
          appBarText: 'Instructions',
          child: Stack(
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
                    ...items,
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
          ),
        );
      },
    );
  }
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
