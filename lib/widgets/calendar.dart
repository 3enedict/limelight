import 'package:flutter/material.dart';

import 'package:limelight/widgets/recipe.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/gradients.dart';

const int numberOfDays = 15 * 2;
const int mealsPerDay = 2;

class Calendar extends StatefulWidget {
  final Stream<RecipeData> stream;
  const Calendar({super.key, required this.stream});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> with AutomaticKeepAliveClientMixin {
  RecipeData currentRecipe = RecipeData.empty();
  List<RecipeData> recipes = List.filled(
    numberOfDays * mealsPerDay,
    RecipeData.empty(),
  );

  @override
  void initState() {
    super.initState();
    widget.stream.listen((newRecipe) {
      setState(() => currentRecipe = newRecipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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

        return Day(
          day: dayContainer,
          lunch: recipes[index * mealsPerDay].toItem(
            () => setState(
              () {
                if (recipes[index * mealsPerDay] == currentRecipe) {
                  recipes[index * mealsPerDay] = RecipeData.empty();
                } else {
                  recipes[index * mealsPerDay] = currentRecipe;
                }
              },
            ),
          ),
          dinner: recipes[index * mealsPerDay + 1].toItem(
            () => setState(
              () {
                if (recipes[index * mealsPerDay + 1] == currentRecipe) {
                  recipes[index * mealsPerDay + 1] = RecipeData.empty();
                } else {
                  recipes[index * mealsPerDay + 1] = currentRecipe;
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Day extends StatelessWidget {
  final Container day;
  final Item lunch;
  final Item dinner;
  const Day({
    super.key,
    required this.day,
    required this.lunch,
    required this.dinner,
  });

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
                  lunch,
                  dinner,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
