import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        return Column(
          children: [
            Expanded(
              child: PageView(
                children: List.generate(
                  recipes.number,
                  (int index) {
                    return EmptyPage(
                      appBar: GradientAppBar(
                        text: CustomText(
                          text: recipes.name(index),
                          alignement: TextAlign.center,
                          size: 20,
                          weight: FontWeight.w700,
                        ),
                      ),
                      child: generateContent(context, index, recipes),
                    );
                  },
                ),
              ),
            ),
            generateActionButtons(),
          ],
        );
      },
    );
  }

  Widget generateContent(
      BuildContext context, int recipeId, RecipeModel recipes) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2.5,
            ),
            child: RecipeDescriptionBox(
              label: "Ingredients",
              items: generateIngredients(recipeId, recipes),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: RecipeDescriptionBox(
              label: "Instructions",
              items: generateInstructions(recipeId, recipes),
            ),
          ),
        ],
      ),
    );
  }

  Widget generateActionButtons() {
    return Container(
      color: toBackgroundGradient(limelightGradient)[1],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              diameter: 52,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () {},
              child: Center(
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.layers,
                ),
              ),
            ),
            const SizedBox(width: 51 / 2),
            GradientButton(
              diameter: 52,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () {},
              child: const Center(
                child: GradientIcon(
                  gradient: limelightGradient,
                  icon: UniconsLine.clipboard_notes,
                  size: 27,
                ),
              ),
            ),
            const SizedBox(width: 51 / 2),
            GradientButton(
              diameter: 50,
              gradient:
                  limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
              onPressed: () {},
              child: Center(
                child: GradientIcon(
                  gradient: toSurfaceGradient(limelightGradient),
                  icon: UniconsLine.calender,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
