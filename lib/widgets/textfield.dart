import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/gradients.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? hint;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.hint,
    this.suffixIcon,
    this.controller,
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
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(
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
              padding: const EdgeInsets.fromLTRB(16, 0, 14, 0),
              child: GradientIcon(
                icon: icon,
                size: 22,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: suffixIcon,
            ),
            contentPadding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
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
