import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/pages/recipe_editor/ingredients_editor_page.dart';
import 'package:limelight/pages/recipe_editor/variations_editor_page.dart';
import 'package:limelight/pages/recipe_editor/instructions_editor_page.dart';
import 'package:limelight/gradients.dart';

List<Widget> recipeEditor(
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
