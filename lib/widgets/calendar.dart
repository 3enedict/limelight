import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class Calendar extends StatelessWidget {
  static const int numberOfDays = 15 * 2;
  final RecipeData recipe = RecipeData.empty();
  final List<RecipeData> recipes = List.filled(
    numberOfDays,
    RecipeData.empty(),
  );

  Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    const double itemExtent = 70 * 2 + 15 * 2 + 20;
    final DateTime startDate = DateTime.now().subtract(
      const Duration(days: numberOfDays),
    );

    return ListView.builder(
      itemCount: numberOfDays,
      itemExtent: itemExtent,
      controller: ScrollController(
        initialScrollOffset: (numberOfDays / 2) * itemExtent + 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        final DateTime date = startDate.add(Duration(days: index));
        final int day = date.day;

        final Container dayContainer = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors:
                  startDate.add(const Duration(days: numberOfDays ~/ 2)) == date
                      ? limelightGradient
                      : toSurfaceGradient(limelightGradient),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          height: 40,
          width: 40,
          child: Center(
            child: Text(
              "$day",
              style: TextStyle(
                fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.5,
                color: Colors.white70,
              ),
            ),
          ),
        );

        return Day(day: dayContainer, recipe: recipes[index]);
      },
    );
  }
}

class Day extends StatelessWidget {
  final Container day;
  final RecipeData recipe;
  const Day({super.key, required this.day, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          day,
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  recipe.toButtonItem(),
                  recipe.toButtonItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
