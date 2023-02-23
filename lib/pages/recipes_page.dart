import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/recipe.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  final _gradient = const [
    Color(0xFFF2C94C),
    Color(0xFFF2994A),
  ];

  @override
  Widget build(BuildContext context) {
    final recipes = [
      RecipeData(
        name: 'Pasta and tomato sauce',
        creator: 'Limelight',
        time: '30 min',
        easiness: 'Really easy',
        gradient: _gradient,
      ),
      RecipeData(
        name: 'Fried rice',
        creator: 'Limelight',
        time: '40 min',
        easiness: 'Easy',
        gradient: _gradient,
      ),
      RecipeData(
        name: 'Tomatoes and mozzarella',
        creator: 'Limelight',
        time: '15 min',
        easiness: 'Extremely easy',
        gradient: _gradient,
      ),
      RecipeData(
        name: 'Leek and potato soup',
        creator: 'Limelight',
        time: '30 min',
        easiness: 'Really easy',
        gradient: _gradient,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF384364),
            Color(0xFF292f4d),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white24,
          onPressed: () {},
          child: const Icon(Icons.calendar_month_rounded),
        ),
        body: DefaultPage(
          title: 'Recipes',
          titleBackground: const AssetImage('assets/Recipes.jpg'),
          padding: 125,
          items: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return recipes[index].toItem(() {});
              },
              childCount: recipes.length,
            ),
          ),
        ),
      ),
    );
  }
}
