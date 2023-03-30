import 'package:flutter/material.dart';
import 'dart:async';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({super.key});
  final StreamController<RecipeData> _controller =
      StreamController<RecipeData>();

  final recipes = [
    RecipeData(
      name: 'Pasta and tomato sauce',
      time: '30 min',
      price: '\$0.50',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Fried rice',
      time: '40 min',
      price: '\$1.00',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Tomatoes and mozzarella',
      time: '15 min',
      price: '\$1.50',
      gradient: limelightGradient,
    ),
    RecipeData(
      name: 'Leek and potato soup',
      time: '30 min',
      price: '\$0.30',
      gradient: limelightGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Calendar calendar = Calendar(stream: _controller.stream);

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
                    () {
                      _controller.add(recipes[index]);
                      _gotoDetailsPage(context, index, calendar);
                    },
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

  void _gotoDetailsPage(BuildContext context, int index, Calendar calendar) {
    Navigator.of(context).push(
      CalendarRoute(
        builder: (_) => Container(
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
              heroTag: 'CalendarFAB',
              onPressed: () {},
              child: const Icon(Icons.search),
            ),
            body: Column(
              children: [
                Hero(
                  tag: index.toString(),
                  child: recipes[index].toItem(
                    () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: calendar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarRoute extends MaterialPageRoute {
  CalendarRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
}
