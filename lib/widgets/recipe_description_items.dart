import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/gradients.dart';

List<Widget> addDividers(List<Widget> items) {
  for (var i = items.length - 1; i > 0; i--) {
    items.insert(
      i,
      Divider(
        color: textColor().withOpacity(0.2),
        indent: 40,
        height: 0,
      ),
    );
  }

  return items;
}

double calculateTextHeight(String text, TextStyle style, double maxWidth) {
  final textSpan = TextSpan(text: text, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.justify,
    maxLines: 100, // A high value to prevent truncation
  );

  textPainter.layout(maxWidth: maxWidth);

  return textPainter.height;
}

List<(double, Widget)> generateIngredients(
  List<IngredientData> ingredientList,
) {
  List<Widget> ingredients = [];
  for (var ingredient in ingredientList) {
    ingredients.add(Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
          child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
        ),
        CustomText(text: ingredient.name),
        const Expanded(child: SizedBox()),
        CustomText(
          text: ingredient.quantity,
          opacity: 0.6,
          weight: FontWeight.w400,
        ),
      ],
    ));
  }

  return ingredients.map((e) => (12 * 2 + 20.0, e)).toList();
}

List<(double, Widget)> generateInstructions(
  List<String> instructionList,
  double width,
) {
  List<(double, Widget)> instructions = [];
  for (var instruction in instructionList) {
    instructions.add((
      10 * 2 +
          calculateTextHeight(
            instruction,
            GoogleFonts.openSans(
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
            width - (20 + 20),
          ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
          ),
          Flexible(
            child: CustomText(
              text: instruction,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              alignement: TextAlign.justify,
              size: 13,
              weight: FontWeight.w300,
            ),
          ),
        ],
      )
    ));
  }

  return instructions;
}
