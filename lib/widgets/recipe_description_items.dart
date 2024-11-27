import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/data/json/ingredient_data.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/gradients.dart';

final instructionStyle = GoogleFonts.openSans(
  textStyle: TextStyle(
    color: toTextGradient(limelightGradient)[1],
    fontSize: 14,
    fontWeight: FontWeight.w300,
  ),
);

List<Widget> addDividers(double beg, double end, List<Widget> items) {
  for (var i = items.length - 1; i > 0; i--) {
    items.insert(
      i,
      Divider(
        color: textColor().withOpacity(0.2),
        indent: beg,
        endIndent: end,
        height: 0,
      ),
    );
  }

  return items;
}

double calculateTextHeight(String text, double maxWidth) {
  final span = TextSpan(text: text, style: instructionStyle);
  final tp = TextPainter(
    text: span,
    textAlign: TextAlign.justify,
    textDirection: TextDirection.ltr,
  );
  tp.layout(maxWidth: maxWidth);
  return tp.size.height;
}

List<Widget> generateIngredients(List<IngredientData> ingredientList) {
  List<Widget> ingredients = [];
  for (var i in ingredientList) {
    ingredients.add(Row(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
          child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
        ),
        CustomText(text: i.getName(i.quantity.round())),
        const Expanded(child: SizedBox()),
        CustomText(
          text: i.getQuantity(),
          opacity: 0.6,
          weight: FontWeight.w400,
        ),
      ],
    ));
  }

  return ingredients;
}

List<Widget> generateInstructions(List<String> instructionList, double width) {
  List<Widget> instructions = [];
  for (var instruction in instructionList) {
    instructions.add(Row(
      key: Key(instruction),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: GradientIcon(icon: Icons.panorama_fish_eye, size: 20),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomPaint(
              painter: MyTextPainter(instruction),
              size: Size(width, calculateTextHeight(instruction, width)),
            ),
          ),
        ),
      ],
    ));
  }

  return instructions;
}

// Urghh... What a nightmare ! If ever you read this and you know WHAT
// the difference is between TextPainter and Text in terms of sizing,
// tell me, because I just wasted 3 hours of my life on this.......

// Rant over. Sorry...

class MyTextPainter extends CustomPainter {
  final String text;

  MyTextPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: instructionStyle,
      ),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(canvas, const Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
