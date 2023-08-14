import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/pages/variation_picker_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/item.dart';
import 'package:limelight/widgets/day.dart';
import 'package:limelight/gradients.dart';

// Always keep numberOfDays even. Highlighting current day doesn't work otherwise. *1
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

    return Consumer2<RecipeModel, VariationModel>(
      builder: (context, recipes, variations, child) {
        List<int> missing = variations.missingVariations(
          recipeId,
          recipes.numberOfVariationGroups(recipeId),
        );

        if (missing.isNotEmpty) {
          return VariationPickerPage(
            recipeId: recipeId,
            groupId: missing[0],
          );
        }

        return EmptyPage(
          fab: GradientButton(
            diameter: 56,
            gradient: toSurfaceGradient(limelightGradient),
            onPressed: () => Navigator.of(context).pop(),
            padding: const EdgeInsets.all(0),
            child: const Center(
              child: Icon(
                Icons.restaurant_menu,
                color: Colors.white70,
              ),
            ),
          ),
          child: ListView.builder(
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
                currentDay: index == numberOfDays ~/ 2, // *1
                recipeId: recipeId,
              );
            },
          ),
        );
      },
    );
  }
}
