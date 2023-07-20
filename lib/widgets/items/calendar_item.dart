import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/widgets/calendar.dart';
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
  int _recipeId = 0;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: _enabled ? recipes[_recipeId].name : "",
      subTitle: _enabled ? recipes[_recipeId].difficulty : "",
      info: _enabled ? recipes[_recipeId].price : "",
      subInfo: _enabled ? "per serving" : "",
      accentGradient: _enabled
          ? recipes[_recipeId].gradient
          : toBackgroundGradientWithReducedColorChange(limelightGradient),
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_enabled) {
          removeRecipe(widget.recipeKey);
          _recipeId = widget.recipeId;
        }
        if (!_enabled) setRecipe(widget.recipeKey, widget.recipeId);

        _enabled = !_enabled;
      }),
      onLongPress: () {},
    );
  }

  void loadRecipe() {
    getRecipe(widget.recipeKey).then(
      (recipeId) => setState(
        () {
          _recipeId = recipeId ?? widget.recipeId;
          if (recipeId != null) _enabled = true;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
