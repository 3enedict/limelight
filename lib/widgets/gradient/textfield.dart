import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';

class GradientTextField extends StatelessWidget {
  final String hintText;
  final double height;
  final double fontSize;

  const GradientTextField({
    super.key,
    required this.hintText,
    this.height = 68,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toSurfaceGradient(limelightGradient),
        ),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      height: height,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: TextField(
          cursorColor: const Color(0xFFEEEEEE),
          decoration: InputDecoration.collapsed(
            hintText: hintText,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              color: const Color(0xFFEEEEEE),
              fontSize: fontSize,
            ),
          ),
          expands: false,
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              fontStyle: FontStyle.italic,
              color: const Color(0xFFEEEEEE),
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
