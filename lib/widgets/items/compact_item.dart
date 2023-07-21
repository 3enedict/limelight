import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient_button.dart';

class CompactItem extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final List<Color> accentGradient;
  final List<Color> backgroundGradient;
  final Color titleColor;
  final Color infoColor;

  const CompactItem({
    super.key,
    required this.title,
    required this.info,
    required this.onPressed,
    required this.onLongPress,
    required this.accentGradient,
    required this.backgroundGradient,
    this.titleColor = const Color(0xFFEEEEEE),
    this.infoColor = const Color(0xFFDDDDDD),
  });

  @override
  Widget build(BuildContext context) {
    const double borderSize = 15;
    const double padding = 10;

    return Padding(
      padding: const EdgeInsets.fromLTRB(padding, padding, padding, 0),
      child: GradientButton(
        gradient: backgroundGradient,
        borderRadius: borderSize,
        onPressed: () => onPressed(),
        padding: const EdgeInsets.all(28),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: LinearGradient(colors: accentGradient),
              ),
              height: 26,
              width: 26,
            ),
            const SizedBox(width: 25),
            Text(
              title,
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              info,
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14 * MediaQuery.of(context).textScaleFactor * 0.8,
                  color: infoColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
