import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';

class RecipeSubPage extends StatelessWidget {
  final int recipeId;
  final List<String> variations;

  const RecipeSubPage({
    super.key,
    required this.recipeId,
    required this.variations,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Recipe",
              titleBackground: const AssetImage('assets/Recipe.jpg'),
              gradient: limelightGradient,
              items: Consumer<RecipeModel>(
                builder: (context, recipes, child) {
                  final recipe = recipes.recipe(recipeId);

                  List<String> instructions = [];
                  for (var instruction in recipe.instructions) {
                    if (instruction.startsWith("{") &&
                        instruction.endsWith("}")) {
                      final location = instruction
                          .replaceAll("{", "")
                          .replaceAll("}", "")
                          .split(":");

                      final variationGroupId = int.parse(location[0]);
                      final variationId = int.parse(location[1]);
                      final instructionGroupId = int.parse(location[2]);

                      final variation = recipe.variationGroups[variationGroupId]
                          .variations[variationId];

                      if (variations.contains(variation.name)) {
                        instructions.addAll(
                          variation.instructionGroups[instructionGroupId],
                        );
                      }
                    } else {
                      instructions.add(instruction);
                    }
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: GoogleFonts.workSans(
                                    textStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                                  child: VerticalDivider(
                                    color: Colors.white60,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    instructions[index],
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.workSans(
                                      textStyle: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: instructions.length,
                    ),
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: GradientBackButton(),
          ),
        ],
      ),
    );
  }
}
