import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/calendar_item.dart';
import 'package:limelight/gradients.dart';

// Always keep numberOfDays even (highlighting current day doesn't work otherwise)
const int numberOfDays = 15 * 2;
const int mealsPerDay = 2;

class Calendar extends StatelessWidget {
  final RecipeData currentRecipe;

  const Calendar({
    super.key,
    required this.currentRecipe,
  });

  @override
  Widget build(BuildContext context) {
    const double itemExtent = 70 * 2 + 15 * 2 + 20;
    final DateTime startDate = DateTime.now().subtract(
      const Duration(days: numberOfDays ~/ 2),
    );

    return ListView.builder(
      itemCount: numberOfDays,
      itemExtent: itemExtent,
      controller: ScrollController(
        initialScrollOffset: (numberOfDays / 2) * itemExtent + 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Day(
          date: startDate.add(Duration(days: index)),
          currentDay: index == numberOfDays ~/ 2,
          currentRecipe: currentRecipe,
        );
      },
    );
  }
}

class Day extends StatelessWidget {
  final DateTime date;
  final bool currentDay;
  final RecipeData currentRecipe;

  const Day({
    super.key,
    required this.date,
    required this.currentDay,
    required this.currentRecipe,
  });

  @override
  Widget build(BuildContext context) {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: currentDay
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
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CalendarItem(
                    recipeKey: "$year/$month/$day/lunch",
                    currentRecipe: currentRecipe,
                  ),
                  CalendarItem(
                    recipeKey: "$year/$month/$day/dinner",
                    currentRecipe: currentRecipe,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
