import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        return PageView(
          children: List.generate(
            recipes.number,
            (int index) => EmptyPage(
              appBar: AppBar(
                backgroundColor: toBackgroundGradient(limelightGradient)[0],
                elevation: 4,
                shadowColor: Colors.black,
                title: Text(
                  " ${recipes.name(index)}",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: textColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              fab: GradientButton(
                gradient: toSurfaceGradient(limelightGradient),
                diameter: 56,
                onPressed: () {},
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.layers,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Ingredients",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: textColor().withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: toSurfaceGradient(limelightGradient),
                      ),
                    ),
                    child: Column(
                      children: recipes
                          .ingredientList(
                            index,
                            List.generate(
                              recipes.numberOfVariationGroups(index),
                              (_) => (0, 0),
                            ),
                          )
                          .map(
                            (e) => Row(
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(color: textColor()),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  e.quantity,
                                  style: TextStyle(color: textColor()),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
