import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/variation_picker.dart';
import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/items/calendar_item.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

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
    chechForVariations(widget.recipeId).then(
      (needToAskForVariations) => setState(() {
        _needToAskForVariations = needToAskForVariations;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_needToAskForVariations == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: toBackgroundGradient(limelightGradient),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
    }

    if (_needToAskForVariations == true) {
      return VariationPicker(recipeId: widget.recipeId);
    }

    final DateTime startDate = DateTime.now().subtract(
      const Duration(days: numberOfDays ~/ 2),
    );

    const double scrollOffsetToCurrentDay =
        (numberOfDays / 2) * (itemExtent * 2 + dayMargin) + dayMargin / 2;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(limelightGradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: ShaderMask(
                  shaderCallback: (bound) {
                    return LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        colors: [
                          toBackgroundGradient(limelightGradient)[1],
                          toBackgroundGradient(limelightGradient)[1]
                              .withAlpha(0),
                        ],
                        stops: const [
                          0.0,
                          0.3,
                        ]).createShader(bound);
                  },
                  blendMode: BlendMode.srcOver,
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
                  )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.transparent,
              elevation: 4,
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: limelightGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Back",
                    style: GoogleFonts.workSans(
                      fontSize:
                          14 * MediaQuery.of(context).textScaleFactor * 1.1,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
