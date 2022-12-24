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
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          alignment: Alignment.center,
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return const GridTile(child: Ingredient());
            },
          ),
        ),
      ],
    );
  }
}

class Ingredient extends StatelessWidget {
  const Ingredient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2f2c43),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.white70,
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: FittedBox(
              child: ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: <Color>[
                      Color(0xFF3fa7cd),
                      Color(0xFF45cac6),
                    ],
                  ).createShader(bounds);
                },
                child: const Icon(FontAwesome5.lemon),
              ),
            ),
          ),
          const Flexible(
            child: FittedBox(
              child: Text(
                'Lime',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
