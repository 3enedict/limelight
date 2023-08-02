import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

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
                  recipeKey: "$year/$month/$day/lunch",
                ),
                CalendarItem(
                  recipeId: recipeId,
                  recipeKey: "$year/$month/$day/dinner",
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

    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        final recipe = recipes.recipe(_recipeId);

        return Item(
          title: _enabled ? recipe.name : null,
          subTitle: _enabled ? recipe.difficulty : null,
          info: _enabled ? recipe.price : null,
          subInfo: _enabled ? "per serving" : null,
          height: 70,
          accentGradient: _enabled
              ? recipe.gradient
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
        );
      },
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

Future<int?> getRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final recipeId = prefs.getInt(key);
  return recipeId;
}

Future<bool> setRecipe(String key, int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt(key, id);
}

Future<bool> removeRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}
