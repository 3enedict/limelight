import 'package:flutter/material.dart';

import 'package:limelight/pages/variation_picker_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/widgets/items/calendar_item.dart';
import 'package:limelight/widgets/items/item.dart';

// Always keep numberOfDays even (highlighting current day doesn't work otherwise)
const int numberOfDays = 15 * 2;
const int mealsPerDay = 2;

const double dayMargin = 20;

class Calendar extends StatefulWidget {
  final int recipeId;

  const Calendar({super.key, required this.recipeId});

  @override
  State<Calendar> createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  bool? _needToAskForVariations;

  @override
  void initState() {
    super.initState();
    chechForVariations(widget.recipeId).then(
      (needToAskForVariations) => setState(() {
        _needToAskForVariations = needToAskForVariations;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_needToAskForVariations == null) {
      return const EmptyPage();
    }

    if (_needToAskForVariations == true) {
      return VariationPicker(recipeId: widget.recipeId);
    }

    final DateTime startDate = DateTime.now().subtract(
      const Duration(days: numberOfDays ~/ 2),
    );

    const double scrollOffsetToCurrentDay =
        (numberOfDays / 2) * (itemExtent * 2 + dayMargin) + dayMargin / 2;

    return EmptyPage(
      child: Column(
        children: [
          Expanded(
            child: Fade(
              child: ListView.builder(
                itemCount: numberOfDays,
                itemExtent: itemExtent * 2 + 20,
                controller: ScrollController(
                  initialScrollOffset: scrollOffsetToCurrentDay -
                      (MediaQuery.of(context).size.height -
                              itemExtent -
                              15 -
                              5) *
                          (1 / 3),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Day(
                    date: startDate.add(Duration(days: index)),
                    currentDay: index == numberOfDays ~/ 2,
                    recipeId: widget.recipeId,
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: GradientBackButton(),
          ),
        ],
      ),
    );
  }
}
