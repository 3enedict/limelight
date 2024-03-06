import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/pages/recipe_editor/ingredients_editor_page.dart';
import 'package:limelight/pages/recipe_editor/variations_editor_page.dart';
import 'package:limelight/pages/recipe_editor/instructions_editor_page.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/gradients.dart';

List<Widget> recipeEditor(
  RecipeModel recipes,
  int recipeId,
  PageController controller,
) {
  return [
    IngredientsEditorPage(
      recipeId: recipeId,
      controller: controller,
    ),
    VariationsEditorPage(
      recipeId: recipeId,
      controller: controller,
    ),
    InstructionsEditorPage(
      recipeId: recipeId,
      controller: controller,
    ),
  ];
}

List<Widget> generateNavigationButtons(PageController controller, int page) {
  final limelight = limelightGradient.map((e) => e.withOpacity(0.8)).toList();
  final surface = toLighterSurfaceGradient(limelightGradient);
  final text = toTextGradient(limelightGradient);

  return [
    const SizedBox(width: 4 * 20),
    GradientButton(
      diameter: 53,
      gradient: page == 0 ? limelight : surface,
      splashColor: limelightGradient[0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      onPressed: () => controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      child: Center(
        child: GradientIcon(
          gradient: page == 0 ? surface : text,
          icon: UniconsLine.notes,
        ),
      ),
    ),
    const SizedBox(width: 53 / 3),
    GradientButton(
      diameter: 53,
      gradient: page == 1 ? limelight : surface,
      splashColor: limelightGradient[0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      onPressed: () => controller.animateToPage(
        2,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      child: Center(
        child: GradientIcon(
          gradient: page == 1 ? surface : text,
          icon: Icons.layers,
          size: 26,
        ),
      ),
    ),
    const SizedBox(width: 53 / 3),
    GradientButton(
      diameter: 53,
      gradient: page == 2 ? limelight : surface,
      splashColor: limelightGradient[0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      onPressed: () => controller.animateToPage(
        3,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      child: Center(
        child: GradientIcon(
          gradient: page == 2 ? surface : text,
          icon: UniconsLine.fire,
          size: 24,
        ),
      ),
    ),
    const SizedBox(width: 10),
  ];
}

class MultiStyleTextEditingController extends TextEditingController {
  final List<String> ingredientNames;

  MultiStyleTextEditingController({
    required this.ingredientNames,
  });

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<String> sections = [text];
    for (var name in ingredientNames) {
      List<String> newSections = [];

      for (var section in sections) {
        List<String> list = section.split(name);
        if (list.length != 1) {
          for (var i = list.length - 1; i > 0; i--) {
            list.insert(i, name);
          }
        }

        newSections.addAll(list);
      }

      sections = newSections;
    }

    final textSpanChildren = <TextSpan>[];
    for (final section in sections) {
      const s = 17.0;

      TextStyle sectionStyle = GoogleFonts.openSans(
        textStyle: TextStyle(color: textColor(), fontSize: s),
      );
      if (ingredientNames.contains(section)) {
        sectionStyle = GoogleFonts.openSans(
          textStyle: TextStyle(
            color: textColor(),
            fontSize: s,
            fontStyle: FontStyle.italic,
          ),
        );
      }

      final child = TextSpan(text: section, style: sectionStyle);
      textSpanChildren.add(child);
    }

    return TextSpan(children: textSpanChildren);
  }
}
