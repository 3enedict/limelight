import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';

class Item extends StatelessWidget {
  final String title;
  final String subTitle;
  final String info;
  final String subInfo;
  final VoidCallback onPressed;
  final List<Color> accentGradient;
  final List<Color> backgroundGradient;

  const Item({
    super.key,
    required this.title,
    required this.subTitle,
    required this.info,
    required this.subInfo,
    required this.onPressed,
    required this.accentGradient,
    required this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onPressed(),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: accentGradient),
                ),
                margin: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                height: 25,
                width: 25,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        subTitle,
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14 *
                                MediaQuery.of(context).textScaleFactor *
                                0.8,
                            color: const Color(0xFFDDDDDD),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    info,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 0.85,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    subInfo,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 0.6,
                        color: const Color(0xFFDDDDDD),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
