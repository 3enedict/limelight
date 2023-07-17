import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const double itemExtent = 70 + 15;

class Item extends StatelessWidget {
  final String title;
  final String subTitle;
  final String info;
  final String subInfo;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final List<Color> accentGradient;
  final List<Color> backgroundGradient;
  final Color textColor;
  final Color subTextColor;

  const Item({
    super.key,
    required this.title,
    required this.subTitle,
    required this.info,
    required this.subInfo,
    required this.onPressed,
    required this.onLongPress,
    required this.accentGradient,
    required this.backgroundGradient,
    this.textColor = const Color(0xFFEEEEEE),
    this.subTextColor = const Color(0xFFDDDDDD),
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
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onPressed(),
          onLongPress: () => onLongPress(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        subTitle,
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14 *
                                MediaQuery.of(context).textScaleFactor *
                                0.8,
                            color: subTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    info,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 0.85,
                        color: textColor,
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
                        color: subTextColor,
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
