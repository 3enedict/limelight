import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/items/item.dart';
import 'package:limelight/gradients.dart';

class MealItem extends StatefulWidget {
  final int recipeId;
  final int year;
  final int month;
  final int day;
  final int meal;

  const MealItem({
    super.key,
    required this.recipeId,
    required this.year,
    required this.month,
    required this.day,
    required this.meal,
  });

  @override
  MealItemState createState() => MealItemState();
}

class MealItemState extends State<MealItem> {
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
