import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class VariationsEditorPage extends StatelessWidget {
  final int recipeId;
  final PageController controller;

  const VariationsEditorPage({
    super.key,
    required this.recipeId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
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
                        child: GradientIcon(
                            icon: Icons.panorama_fish_eye, size: 22),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (text) =>
                              recipes.editName(recipeId, text),
                          controller: TextEditingController(
                            text: recipes.name(recipeId),
                          ),
                          style: GoogleFonts.openSans(color: textColor()),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
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
                          decoration:
                              const InputDecoration(border: InputBorder.none),
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
                          child: GradientIcon(
                              icon: Icons.panorama_fish_eye, size: 22),
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

                for (var i = 0;
                    i < recipes.nbVariations(recipeId, index);
                    i++) {
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
                        decoration:
                            const InputDecoration(border: InputBorder.none),
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

        return EmptyPage(
          resizeToAvoidBottomInset: false,
          appBarText: 'Variations',
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: variationsPage,
                ),
              ),
              Container(
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
                        onPressed: () {},
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
                        onPressed: () {},
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
              )
            ],
          ),
        );
      },
    );
  }
}
