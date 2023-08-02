import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final List<Color> gradient;
  final double borderRadius;
  final double? height;
  final double? width;
  final double? diameter;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const GradientButton({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.gradient = limelightGradient,
    this.borderRadius = 20,
    this.height,
    this.width,
    this.diameter,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(diameter ?? borderRadius),
      ),
      color: Colors.transparent,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(diameter ?? borderRadius),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: diameter ?? height,
        width: diameter ?? width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(diameter ?? borderRadius),
            ),
          ),
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: child,
        ),
      ),
    );
  }
}

class GradientBackButton extends StatelessWidget {
  const GradientBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      borderRadius: 25,
      height: 50,
      width: MediaQuery.of(context).size.width - 60,
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        "Back",
        style: GoogleFonts.workSans(
          fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.1,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
