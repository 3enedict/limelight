import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.delete),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () => {},
              child: const Icon(Icons.star),
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: const <Widget>[
            IngredientsList(),
            IngredientsList(),
            IngredientsList(),
          ],
        ),
      ),
    );
  }
}

class IngredientsList extends StatelessWidget {
  const IngredientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Vegetables',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF2f2c43),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          alignment: Alignment.center,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            children: const [
              Ingredient(text: 'Lemon', icon: Icon(FontAwesome5.lemon)),
              Ingredient(text: 'Lemon', icon: Icon(FontAwesome5.lemon)),
              Ingredient(text: 'Lemon', icon: Icon(FontAwesome5.lemon)),
              Ingredient(text: 'Lemon', icon: Icon(FontAwesome5.lemon)),
            ],
          ),
        ),
      ],
    );
  }
}

class Ingredient extends StatelessWidget {
  final String text;
  final Icon icon;

  const Ingredient({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF3a374d),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
