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

    return IngredientLayout(
      name: widget.name,
      season: widget.season,
      price: widget.price,
      cheapness: widget.cheapness,
      accentGradient: _enabled
          ? const [Color(0xBBFFFFFF), Color(0xBBFFFFFF)]
          : widget.gradient,
      backgroundGradient: _enabled
          ? widget.gradient
          : const [Color(0xFF525d7d), Color(0xFF343e61)],
      onPressed: () => setState(() => _enabled = !_enabled),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IngredientLayout extends StatelessWidget {
  final String name;
  final String season;
  final String price;
  final String cheapness;
  final List<Color> accentGradient;
  final List<Color> backgroundGradient;
  final VoidCallback onPressed;

  const IngredientLayout({
    super.key,
    required this.name,
    required this.season,
    required this.price,
    required this.cheapness,
    required this.accentGradient,
    this.backgroundGradient = const [
      Color(0xFF525d7d),
      Color(0xFF343e61),
    ],
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: backgroundGradient,
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
        onPressed: () => onPressed(),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: accentGradient,
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
                      name,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                    ),
                    Text(
                      season,
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
                  price,
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
                  cheapness,
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
}
