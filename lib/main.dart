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
            Color(0xFF1B2631),
            Color(0xFF17202A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Ingredients",
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.white70,
              height: 1.0,
              margin: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        body: Container(
            color: Colors.black38,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: const Text("Veggies")),
      ),
    );
  }
}
