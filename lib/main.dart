import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Limelight());
}

class Limelight extends StatelessWidget {
  const Limelight({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limelight',
      home: IngredientsPage(),
    );
  }
}

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2e2b44),
            Color(0xFF221f31),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Ingredients",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
          leading: const Icon(
            Icons.menu,
            color: Colors.white70,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF02AABD),
                    Color(0xFF00CDAC),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 100,
              child: Text(
                'Vegetables',
                style: GoogleFonts.fredokaOne(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF614385),
                    Color(0xFF516395),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 100,
              child: Text(
                'Fruits',
                style: GoogleFonts.fredokaOne(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF512F),
                    Color(0xFFDD2476),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 100,
              child: Text(
                'Meat & Eggs',
                style: GoogleFonts.fredokaOne(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFA9F1DF),
                    Color(0xFFFFBBBB),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 100,
              child: Text(
                'Seafood',
                style: GoogleFonts.fredokaOne(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEE9CA7),
                    Color(0xFFFFDDE1),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              height: 100,
              child: Text(
                'Dairy',
                style: GoogleFonts.fredokaOne(
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
