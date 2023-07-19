import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

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
    const double margin = 20;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderSize),
      ),
      color: Colors.transparent,
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(margin, 0, margin, margin),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderSize),
          gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: MediaQuery.of(context).size.width - 140,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderSize),
            ),
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
          ),
          onPressed: () => onPressed(),
          onLongPress: () => onLongPress(),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  gradient: LinearGradient(colors: accentGradient),
                ),
                height: 22,
                width: 22,
              ),
              const SizedBox(width: 17),
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
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
