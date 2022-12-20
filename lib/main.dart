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
              icon: Icon(Icons.store),
              label: 'Ingredients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Recipes',
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: const <Widget>[
            IngredientSlider(items: {
              'banana': Icon(Icons.image),
              'orange': Icon(Icons.image),
              'apple': Icon(Icons.image)
            }),
            IngredientSlider(items: {
              'broccoli': Icon(Icons.image),
              'eggplant': Icon(Icons.image),
              'carrot': Icon(Icons.image)
            }),
          ],
        ));
  }
}

class IngredientSlider extends StatelessWidget {
  final Map<String, Icon> items;
  const IngredientSlider({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredients = [];

    for (final mapEntry in items.entries) {
      final ingredientName = mapEntry.key;
      final ingredientIcon = mapEntry.value;

      ingredients.add(Flexible(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(10.0),
            child: Column(
                children: <Widget>[ingredientIcon, Text(ingredientName)])),
      ));
    }

    return Center(
        child: Container(
      color: Colors.grey,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: ingredients,
      ),
    ));
  }
}
