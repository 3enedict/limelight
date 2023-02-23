import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = [
      RecipeData(
        name: 'Pasta and tomato sauce',
        creator: 'Limelight',
        time: '30 min',
        easiness: 'Really easy',
        gradient: limelightGradient,
      ),
      RecipeData(
        name: 'Fried rice',
        creator: 'Limelight',
        time: '40 min',
        easiness: 'Easy',
        gradient: limelightGradient,
      ),
      RecipeData(
        name: 'Tomatoes and mozzarella',
        creator: 'Limelight',
        time: '15 min',
        easiness: 'Extremely easy',
        gradient: limelightGradient,
      ),
      RecipeData(
        name: 'Leek and potato soup',
        creator: 'Limelight',
        time: '30 min',
        easiness: 'Really easy',
        gradient: limelightGradient,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(limelightGradient),
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
          backgroundGradient: toBackgroundGradient(limelightGradient),
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
