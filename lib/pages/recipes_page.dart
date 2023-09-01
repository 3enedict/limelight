import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/widgets/gradient/container.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:unicons/unicons.dart';

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
                            padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
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
                    indent: 40,
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
                            padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
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
                    indent: 40,
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomList(
                          label: "Ingredients",
                          items: ingredients,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: CustomList(
                          label: "Instructions",
                          items: instructions,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 25, 30, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GradientButton(
                                outlineBorder: true,
                                height: 50,
                                borderRadius: 100,
                                onPressed: () {},
                                child: Center(
                                  child: Text(
                                    "Variations",
                                    style: GoogleFonts.workSans(
                                      color: textColor(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: GradientButton(
                                diameter: 52,
                                gradient:
                                    toLighterSurfaceGradient(limelightGradient),
                                onPressed: () {},
                                child: const Center(
                                  child: GradientIcon(
                                    gradient: limelightGradient,
                                    icon: UniconsLine.clipboard_notes,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GradientButton(
                                diameter: 50,
                                gradient: limelightGradient,
                                onPressed: () {},
                                child: Center(
                                  child: GradientIcon(
                                    gradient: toSurfaceGradient(
                                      limelightGradient,
                                    ),
                                    icon: UniconsLine.calender,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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

class CustomList extends StatelessWidget {
  final String label;
  final List<Widget> items;

  const CustomList({
    super.key,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: toSurfaceGradient(limelightGradient)[0],
          elevation: 0,
          title: Text(
            label,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: textColor(),
              ),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: items,
            ),
          ),
        ),
      ),
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        foregroundColor: textColor().withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " $label",
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Wrap(children: items),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
