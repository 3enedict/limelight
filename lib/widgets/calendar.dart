import 'package:flutter/material.dart';

import 'package:limelight/widgets/items/calendar_item.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

// Always keep numberOfDays even (highlighting current day doesn't work otherwise)
const int numberOfDays = 15 * 2;
const int mealsPerDay = 2;

const double dayMargin = 20;

class Calendar extends StatelessWidget {
  final int recipeId;

  const Calendar({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.now().subtract(
      const Duration(days: numberOfDays ~/ 2),
    );

    const double scrollOffsetToCurrentDay =
        (numberOfDays / 2) * (itemExtent * 2 + dayMargin) + dayMargin / 2;

    return ListView.builder(
      itemCount: numberOfDays,
      itemExtent: itemExtent * 2 + 20,
      controller: ScrollController(
        initialScrollOffset: scrollOffsetToCurrentDay -
            (MediaQuery.of(context).size.height - itemExtent - 15 - 5) *
                (1 / 3),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Day(
          date: startDate.add(Duration(days: index)),
          currentDay: index == numberOfDays ~/ 2,
          recipeId: recipeId,
        );
      },
    );
  }
}

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
      margin: const EdgeInsets.fromLTRB(0, dayMargin / 2, 0, dayMargin / 2),
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  CalendarItem(
                    recipeId: recipeId,
                    recipeKey: "$year/$month/$day/lunch",
                  ),
                  CalendarItem(
                    recipeId: recipeId,
                    recipeKey: "$year/$month/$day/dinner",
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
