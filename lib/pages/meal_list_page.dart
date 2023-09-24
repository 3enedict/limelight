import 'package:flutter/material.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/recipe_description_items.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient_container.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:unicons/unicons.dart';

class MealListPage extends StatelessWidget {
  final int recipeId;
  const MealListPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeModel>(context);
    Provider.of<CalendarModel>(context, listen: false).addIfNone(recipeId);

    return EmptyPage(
      appBar: GradientAppBar(
        child: Row(
          children: [
            GradientIcon(
              onPressed: () => Navigator.of(context).pop(),
              gradient: toTextGradient(limelightGradient),
              padding: const EdgeInsets.only(left: 5),
              icon: Icons.chevron_left,
              size: 27,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  text: "Meals",
                  alignement: TextAlign.center,
                  size: 22,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            GradientIcon(
              onPressed: () {
                Provider.of<PreferencesModel>(context, listen: false)
                    .setPlannerMode(0);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CalendarPage(
                      recipeId: recipeId,
                    ),
                  ),
                );
              },
              gradient: toTextGradient(limelightGradient),
              padding: const EdgeInsets.only(right: 5),
              icon: UniconsLine.calender,
              size: 27,
            ),
          ],
        ),
      ),
      child: Consumer<CalendarModel>(
        builder: (context, calendar, child) {
          if (calendar.mealList[recipeId] == 0) {
            Navigator.of(context).pop();
          }

          List<Widget> items = [];
          for (var i = 0; i < calendar.mealList.length; i++) {
            final num = calendar.mealList[i];

            if (num != 0) {
              items.add(
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GradientContainer(
                    gradient: toSurfaceGradient(limelightGradient),
                    borderRadius: 20,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
                          child: GradientIcon(
                            icon: Icons.panorama_fish_eye,
                            size: 20,
                          ),
                        ),
                        CustomText(text: recipes.name(i)),
                        const Expanded(child: SizedBox()),
                        CustomText(
                          text: '$num',
                          opacity: 0.6,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(children: items),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientButton(
                      diameter: 53,
                      gradient: toSurfaceGradient(limelightGradient),
                      onPressed: () => calendar.removeFromList(recipeId),
                      child: Center(
                        child: GradientIcon(
                          gradient: toTextGradient(limelightGradient),
                          icon: Icons.remove,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 53 / 4),
                    GradientButton(
                      diameter: 53,
                      gradient: toSurfaceGradient(limelightGradient),
                      onPressed: () => calendar.add(recipeId),
                      child: Center(
                        child: GradientIcon(
                          gradient: toTextGradient(limelightGradient),
                          icon: Icons.add,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
