import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';

class GradientTextField extends StatelessWidget {
  final List<Color> gradient;
  final double height;
  final String hint;
  final void Function(String) onChanged;
  final Icon? icon;

  const GradientTextField({
    super.key,
    this.gradient = limelightGradient,
    required this.height,
    required this.hint,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> leading = icon == null
        ? [const SizedBox(width: 10)]
        : [
            const SizedBox(
              width: 20,
            ),
            icon!,
            const SizedBox(
              width: 10,
            ),
          ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toSurfaceGradientWithReducedColorChange(limelightGradient),
        ),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      height: height,
      child: Row(
        children: [
          ...leading,
          Expanded(
            child: TextField(
              autofocus: true,
              cursorColor: const Color(0xFFEEEEEE),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFEEEEEE),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 4),
              ),
              expands: false,
              style: GoogleFonts.workSans(
                textStyle: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFEEEEEE),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}
