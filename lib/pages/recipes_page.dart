import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({super.key});

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

  @override
  Widget build(BuildContext context) {
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
          heroTag: 'RecipeFAB',
          onPressed: () {},
          child: const Icon(Icons.calendar_month_rounded),
        ),
        body: DefaultPage(
          title: 'Recipes',
          titleBackground: const AssetImage('assets/Recipes.jpg'),
          padding: 80,
          backgroundGradient: toBackgroundGradient(limelightGradient),
          keyValue: 1,
          items: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Hero(
                  tag: index.toString(),
                  child: recipes[index].toItem(
                    () => _gotoDetailsPage(context, index),
                  ),
                );
              },
              childCount: recipes.length,
            ),
          ),
        ),
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 75,
              child: Hero(
                tag: index.toString(),
                child: recipes[index].toItem(
                  () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
