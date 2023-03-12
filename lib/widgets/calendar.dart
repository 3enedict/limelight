import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/gradients.dart';

class Calendar extends StatelessWidget {
  final RecipeData recipe;
  const Calendar({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.now();

    return ListView.builder(
      itemCount: 120,
      itemBuilder: (BuildContext context, int index) {
        final DateTime date = startDate.add(Duration(days: index));
        final int day = date.day;

        final Container dayContainer = Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: startDate == date
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

        return Day(day: dayContainer, recipe: recipe);
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
