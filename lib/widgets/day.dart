import 'package:flutter/material.dart';

import 'package:limelight/widgets/items/meal.dart';
import 'package:limelight/gradients.dart';

class Day extends StatelessWidget {
  final DateTime date;
  final bool currentDay;
  final int recipeId;

  const Day({
    super.key,
    required this.date,
    required this.currentDay,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
            child: Column(
              children: [
                MealItem(
                  recipeId: recipeId,
                  year: year,
                  month: month,
                  day: day,
                  meal: 0,
                ),
                MealItem(
                  recipeId: recipeId,
                  year: year,
                  month: month,
                  day: day,
                  meal: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
