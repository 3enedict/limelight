import 'package:flutter/material.dart';
import 'package:limelight/pages/recipe_page.dart';
import 'package:limelight/utils/utils.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/data/recipe_id.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

class MealListPage extends StatefulWidget {
  final RecipeId? recipe;

  const MealListPage({super.key, this.recipe});

  @override
  State<MealListPage> createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  bool _removed = false;

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: words['mealList']![0],
      backButton: widget.recipe != null,
      child: Consumer2<RecipeModel, CalendarModel>(
        builder: (context, recipes, calendar, child) {
          List<Widget> children = [];
          int currentNbServings = 0;

          for (var meal in calendar.mealList) {
            if (meal.servings != currentNbServings) {
              currentNbServings = meal.servings;
              children.add(
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
                  child: CustomText(
                    text: meal.servings == 1
                        ? " Pour 1 personne"
                        : " Pour ${meal.servings} personnes",
                    opacity: 0.5,
                    weight: FontWeight.w300,
                  ),
                ),
              );
            }

            final name = recipes.name(meal.recipeId);

            children.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                child: GradientButton(
                  gradient: toSurfaceGradient(limelightGradient),
                  borderRadius: 15,
                  onPressed: () {
                    if (_removed) {
                      calendar.removeFromList(meal);
                    } else if (widget.recipe == null) {
                      goto(
                        context,
                        EmptyPage(
                          appBarText: name,
                          child: Column(
                            children: [
                              Expanded(
                                child: Content(id: meal),
                              ),
                              Container(
                                color:
                                    toBackgroundGradient(limelightGradient)[1],
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GradientButton(
                                        diameter: 54,
                                        gradient: toLighterSurfaceGradient(
                                            limelightGradient),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Center(
                                          child: GradientIcon(
                                            gradient: toTextGradient(
                                                limelightGradient),
                                            icon: Icons.chevron_left,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 53 / 3),
                                      GradientButton(
                                        diameter: 53,
                                        gradient: limelightGradient
                                            .map((e) => e.withOpacity(0.8))
                                            .toList(),
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        onPressed: () {
                                          calendar.removeFromList(meal);
                                          Navigator.of(context).pop();
                                        },
                                        child: Center(
                                          child: GradientIcon(
                                            gradient: toSurfaceGradient(
                                                limelightGradient),
                                            icon: Icons.done,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const GradientIcon(
                        gradient: limelightGradient,
                        padding: EdgeInsets.all(16),
                        size: 22,
                        icon: Icons.panorama_fish_eye,
                      ),
                      Expanded(
                        child: CustomText(
                          text: name,
                        ),
                      ),
                      CustomText(
                        text: '${meal.times}',
                        opacity: 0.8,
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView(children: children),
              ),
              Container(
                color: toBackgroundGradient(limelightGradient)[1],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientButton(
                        diameter: 54,
                        gradient: _removed
                            ? redGradient
                            : toLighterSurfaceGradient(redGradient),
                        onPressed: () => setState(() => _removed = !_removed),
                        child: Center(
                          child: GradientIcon(
                            gradient: _removed
                                ? toLighterSurfaceGradient(redGradient)
                                : redGradient,
                            icon: Icons.remove,
                          ),
                        ),
                      ),
                      SizedBox(width: widget.recipe == null ? 0 : 53 / 3),
                      widget.recipe == null
                          ? const SizedBox()
                          : GradientButton(
                              diameter: 53,
                              gradient:
                                  toLighterSurfaceGradient(limelightGradient),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Center(
                                child: GradientIcon(
                                  gradient: toTextGradient(limelightGradient),
                                  icon: Icons.close,
                                  size: 26,
                                ),
                              ),
                            ),
                      SizedBox(width: widget.recipe == null ? 0 : 53 / 3),
                      widget.recipe == null
                          ? const SizedBox()
                          : GradientButton(
                              diameter: 54,
                              gradient:
                                  toLighterSurfaceGradient(limelightGradient),
                              onPressed: () =>
                                  calendar.addToList(widget.recipe!),
                              child: const Center(
                                child: GradientIcon(
                                  gradient: limelightGradient,
                                  icon: UniconsLine.plus,
                                  size: 24,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
