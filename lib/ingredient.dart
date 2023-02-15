import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Ingredient extends StatefulWidget {
  final String name;
  final String season;
  final String price;
  final String cheapness;
  final List<Color> gradient;

  const Ingredient({
    super.key,
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
    required this.gradient,
  });

  @override
  IngredientState createState() => IngredientState();
}

class IngredientState extends State<Ingredient>
    with AutomaticKeepAliveClientMixin {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: _enabled
              ? widget.gradient
              : [
                  const Color(0xFF525d7d),
                  const Color(0xFF343e61),
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () => setState(() => _enabled = !_enabled),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: _enabled
                      ? [
                          const Color(0xBBFFFFFF),
                          const Color(0xBBFFFFFF),
                        ]
                      : widget.gradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
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
                      widget.name,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                    ),
                    Text(
                      widget.season,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFDDDDDD),
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
                  widget.price,
                  style: GoogleFonts.workSans(
                    textStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.cheapness,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize:
                          14 * MediaQuery.of(context).textScaleFactor * 0.8,
                      color: const Color(0xFFDDDDDD),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
