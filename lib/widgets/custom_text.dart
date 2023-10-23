import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double opacity;
  final TextAlign? alignement;
  final FontWeight? weight;
  final FontStyle? style;
  final TextDecoration? decoration;
  final double? size;
  final EdgeInsetsGeometry padding;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.opacity = 1.0,
    this.alignement,
    this.weight,
    this.style,
    this.decoration,
    this.size,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final localColor = color ?? textColor();

    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: alignement,
        style: GoogleFonts.openSans(
          color: localColor.withOpacity(opacity),
          decoration: decoration,
          decorationColor: localColor,
          fontWeight: weight,
          fontStyle: style,
          fontSize: size,
        ),
      ),
    );
  }
}
