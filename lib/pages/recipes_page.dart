import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/widgets/gradient/container.dart';
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
            (int index) {
              final variationIds = List.generate(
                recipes.numberOfVariationGroups(index),
                (int groupId) => (groupId, 0),
              );

              var ingredients = List<Widget>.from(
                recipes
                    .ingredientList(
                      index,
                      variationIds,
                    )
                    .map(
                      (e) => Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            child: GradientIcon(
                              icon: Icons.panorama_fish_eye,
                              size: 20,
                            ),
                          ),
                          Text(
                            e.name,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(color: textColor()),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            e.quantity,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: textColor().withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    )
                    .toList(),
              );

              for (var i = ingredients.length - 1; i > 0; i--) {
                ingredients.insert(
                  i,
                  Divider(
                    color: textColor().withOpacity(0.2),
                    indent: 55,
                    endIndent: 20,
                    height: 0,
                  ),
                );
              }

              List<Widget> instructions = List<Widget>.from(
                recipes
                    .instructionSet(index, 3, variationIds)
                    .map(
                      (e) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: GradientIcon(
                              icon: Icons.panorama_fish_eye,
                              size: 20,
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Text(
                                e,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: textColor(),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );

              for (var i = instructions.length - 1; i > 0; i--) {
                instructions.insert(
                  i,
                  Divider(
                    color: textColor().withOpacity(0.2),
                    indent: 55,
                    endIndent: 20,
                    height: 0,
                  ),
                );
              }

              return EmptyPage(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: GradientContainer(
                    gradient: toSurfaceGradient(limelightGradient),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 20,
                        top: 20 + MediaQuery.of(context).padding.top,
                      ),
                      child: Text(
                        recipes.name(index),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: textColor(),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                fab: GradientButton(
                  gradient: toLighterSurfaceGradient(limelightGradient),
                  diameter: 56,
                  onPressed: () {},
                  child: GradientIcon(
                    gradient: toTextGradient(limelightGradient),
                    icon: Icons.layers,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
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
                      const SizedBox(height: 7),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Fade(
                            child: GradientContainer(
                              gradient: toSurfaceGradient(limelightGradient),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Wrap(children: ingredients),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        " Instructions",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: textColor().withOpacity(0.5),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Fade(
                            child: GradientContainer(
                              gradient: toSurfaceGradient(limelightGradient),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Wrap(children: instructions),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class Fade extends StatelessWidget {
  final List<Color> gradient;
  final Widget child;

  const Fade({
    super.key,
    this.gradient = limelightGradient,
    this.child = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final Color color = toSurfaceGradient(gradient)[1];

    return ShaderMask(
      shaderCallback: (bound) {
        return LinearGradient(
            end: FractionalOffset.topCenter,
            begin: FractionalOffset.bottomCenter,
            colors: [
              color,
              color.withAlpha(120),
              color.withAlpha(0),
            ],
            stops: const [
              0.0,
              0.05,
              0.2,
            ]).createShader(bound);
      },
      blendMode: BlendMode.srcOver,
      child: child,
    );
  }
}
