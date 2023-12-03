import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/gradients.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final String? text;
  final Widget? suffix;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.hint,
    this.text,
    this.suffix,
    this.autofocus = false,
    this.focusNode,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $label",
          style: TextStyle(
            color: textColor().withOpacity(0.5),
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          focusNode: focusNode,
          autofocus: autofocus,
          keyboardType: keyboardType,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          controller: TextEditingController(text: text),
          style: GoogleFonts.openSans(
            color: textColor(),
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                color: textColor().withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                color: textColor().withOpacity(0.5),
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(17, 16, 14, 16),
              child: GradientIcon(icon: icon, size: 23),
            ),
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.all(0),
            hintText: hint,
            hintStyle: TextStyle(
              color: textColor().withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
