import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/gradients.dart';

class CalendarItem extends StatefulWidget {
  final RecipeData currentRecipe;
  final String recipeKey;

  const CalendarItem({
    super.key,
    required this.currentRecipe,
    required this.recipeKey,
  });

  @override
  CalendarItemState createState() => CalendarItemState();
}

class CalendarItemState extends State<CalendarItem>
    with AutomaticKeepAliveClientMixin {
  RecipeData _storedRecipe = RecipeData.empty();
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Item(
      title: _enabled ? _storedRecipe.name : "",
      subTitle: _enabled ? _storedRecipe.time : "",
      info: _enabled ? _storedRecipe.price : "",
      subInfo: _enabled ? _storedRecipe.unit : "",
      accentGradient: _enabled
          ? _storedRecipe.gradient
          : toBackgroundGradient(limelightGradient),
      backgroundGradient: toSurfaceGradient(limelightGradient),
      onPressed: () => setState(() {
        if (_storedRecipe.name == widget.currentRecipe.name) {
          if (_enabled) removeRecipe(widget.recipeKey);
          if (!_enabled) setRecipe(widget.recipeKey, _storedRecipe);
          _enabled = !_enabled;
        } else {
          _storedRecipe = widget.currentRecipe;
          setRecipe(widget.recipeKey, _storedRecipe);
        }
      }),
    );
  }

  void loadRecipe() {
    getRecipeData(widget.recipeKey).then(
      (recipe) => setState(() => _storedRecipe = recipe),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<RecipeData> getRecipeData(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final recipe = prefs.getStringList(key);

  if (recipe == null) {
    return RecipeData.empty();
  } else {
    return RecipeData(
      name: recipe[0],
      time: recipe[1],
      price: recipe[2],
    );
  }
}

Future<bool> setRecipe(String key, RecipeData value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setStringList(key, [value.name, value.time, value.price]);
}

Future<bool> removeRecipe(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}

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
