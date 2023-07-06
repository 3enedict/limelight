import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/data/recipes.dart';
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

class CalendarItem extends StatefulWidget {
  final int recipeId;
  final String recipeKey;

  const CalendarItem({
    super.key,
    required this.recipeId,
    required this.recipeKey,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem>
    with AutomaticKeepAliveClientMixin {
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: _enabled ? "" : recipes[widget.recipeId].name,
      subTitle: _enabled ? "" : recipes[widget.recipeId].difficulty,
      info: _enabled ? "" : recipes[widget.recipeId].price,
      subInfo: _enabled ? "" : "per person",
      accentGradient: _enabled
          ? toBackgroundGradientWithReducedColorChange(limelightGradient)
          : recipes[widget.recipeId].gradient,
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_enabled) removeRecipe(widget.recipeKey);
        if (!_enabled) setRecipe(widget.recipeKey, widget.recipeId);

        _enabled = !_enabled;
      }),
    );
  }

  void loadRecipe() {
    getRecipeData(widget.recipeKey).then(
      (recipe) => setState(() => _enabled = true),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
