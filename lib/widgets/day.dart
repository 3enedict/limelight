import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/item.dart';
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
                CalendarItem(
                  recipeId: recipeId,
                  year: year,
                  month: month,
                  day: day,
                  meal: 0,
                ),
                CalendarItem(
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

class CalendarItem extends StatefulWidget {
  final int recipeId;
  final int year;
  final int month;
  final int day;
  final int meal;

  const CalendarItem({
    super.key,
    required this.recipeId,
    required this.year,
    required this.month,
    required this.day,
    required this.meal,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeModel, CalendarModel>(
      builder: (context, recipes, calendar, child) {
        final recipeId =
            calendar.get(widget.year, widget.month, widget.day, widget.meal);

        if (recipeId == null) {
          return Item(
            height: 70,
            accentGradient:
                toBackgroundGradientWithReducedColorChange(limelightGradient),
            onPressed: () => setState(() {
              calendar.set(widget.year, widget.month, widget.day, widget.meal,
                  widget.recipeId);
            }),
          );
        }

        final recipe = recipes.recipe(recipeId);
        return Item(
          title: recipe.name,
          subTitle: recipe.difficulty,
          info: recipe.price,
          subInfo: "per serving",
          height: 70,
          onPressed: () => calendar.remove(
              widget.year, widget.month, widget.day, widget.meal),
        );
      },
    );
  }
}
