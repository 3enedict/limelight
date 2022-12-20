import 'package:flutter/material.dart';

import 'package:fluttericon/font_awesome5_icons.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ingredients"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.lemon),
              label: 'Ingredients',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.calendar_alt),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesome5.pizza_slice),
              label: 'Recipes',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        body: const Center(child: Text("Yo")));
  }
}
