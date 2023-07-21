import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';

class RecipeSubPage extends StatelessWidget {
  final int recipeId;

  const RecipeSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    List<String> instructions = [];
    for (var instruction in recipes[recipeId].instructions) {
      if (instruction.startsWith("{") && instruction.endsWith("}")) {
        final instructionsLocation =
            instruction.replaceAll("{", "").replaceAll("}", "").split(":");

        final variationGroupId = int.parse(instructionsLocation[0]);
        final variationId = int.parse(instructionsLocation[1]);
        final instructionGroupId = int.parse(instructionsLocation[2]);

        instructions.addAll(recipes[recipeId]
            .variationGroups[variationGroupId]
            .variations[variationId]
            .instructionGroups[instructionGroupId]);
      }
    }

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Recipe",
              titleBackground: const AssetImage('assets/Recipe.jpg'),
              gradient: fishGradient,
              items: SliverList(
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
