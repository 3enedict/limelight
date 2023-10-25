import 'package:flutter/material.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/widgets/custom_divider.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/widgets/preference.dart';
import 'package:limelight/widgets/variation_picker_dialog.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/main.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        final pages = List.generate(
          recipes.number,
          (int index) {
            return EmptyPage(
              appBarText: recipes.name(index),
              child: Column(
                children: [
                  Expanded(child: Content(recipeId: index, recipes: recipes)),
                  ActionButtons(recipeId: index, recipes: recipes),
                ],
              ),
            );
          },
        );

        return PageView(children: pages);
      },
    );
  }
}

class Content extends StatelessWidget {
  final int recipeId;
  final RecipeModel recipes;

  const Content({
    super.key,
    required this.recipeId,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Consumer2<VariationModel, PreferencesModel>(
        builder: (context, variations, preferences, child) {
          final width = MediaQuery.of(context).size.width - 20 * 2 * 2;

          final vIds = variations.variationIds(recipeId);
          final servings = (preferences.nbServingsLocal(recipeId)).abs();

          final ingredients = recipes.ingredientList(recipeId, servings, vIds);
          final instructions = recipes.instructionSet(recipeId, servings, vIds);

          return Center(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.5,
                  ),
                  child: RecipeDescriptionBox(
                    label: "Ingredients",
                    items: generateIngredients(ingredients),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: RecipeDescriptionBox(
                    label: "Instructions",
                    items: generateInstructions(instructions, width),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final int recipeId;
  final RecipeModel recipes;

  const ActionButtons({
    super.key,
    required this.recipeId,
    required this.recipes,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: toBackgroundGradient(limelightGradient)[1],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return VariationPickerDialog(
                    recipeId: widget.recipeId,
                    recipes: widget.recipes,
                  );
                },
              ),
              child: Center(
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.layers,
                ),
              ),
            ),
            const SizedBox(width: 53 / 4),
            Consumer2<CalendarModel, PreferencesModel>(
              builder: (context, calendar, preferences, child) {
                final servings =
                    (preferences.nbServingsLocal(widget.recipeId)).abs();
                final mealList =
                    calendar.mealList.elementAtOrNull(widget.recipeId) ?? [];
                final num = mealList.elementAtOrNull(servings) ?? 0;

                return Padding(
                  padding: num != 0
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.symmetric(horizontal: 53 / 6),
                  child: GradientButton(
                    height: 54,
                    borderRadius: 54 / 2,
                    diameter: num == 0 ? 54 : null,
                    gradient: toLighterSurfaceGradient(limelightGradient),
                    onLongPress: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer<CalendarModel>(
                            builder: (context, calendar, child) {
                              List<Widget> items = [];
                              for (var i = 0;
                                  i < calendar.mealList.length;
                                  i++) {
                                for (var j = 0;
                                    j < calendar.mealList[i].length;
                                    j++) {
                                  final num = calendar.mealList[i][j];

                                  if (num != 0) {
                                    items.add(
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 18, 20, 20),
                                            child: GradientIcon(
                                              icon: Icons.panorama_fish_eye,
                                              size: 24,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: widget.recipes.name(i),
                                              ),
                                              const SizedBox(height: 2),
                                              CustomText(
                                                text: 'Serves $j',
                                                opacity: 0.7,
                                              ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          CustomText(
                                            text: '$num',
                                            opacity: 0.6,
                                            weight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }

                              return Dialog(
                                backgroundColor:
                                    toSurfaceGradient(limelightGradient)[1],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                insetPadding: const EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 12, 0, 12),
                                        child: CustomText(
                                          text: "Meals",
                                          alignement: TextAlign.center,
                                          size: 20,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      Flexible(
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: addDividers(items),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          borderRadius: 10,
                                          child: const CustomText(text: 'Done'),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: num == 0
                        ? GradientIcon(
                            onPressed: () =>
                                calendar.add(widget.recipeId, servings),
                            gradient: limelightGradient,
                            icon: UniconsLine.clipboard_notes,
                            size: 27,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GradientIcon(
                                icon: Icons.remove,
                                size: 22,
                                gradient: toTextGradient(limelightGradient),
                                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                onPressed: () => calendar.removeFromList(
                                    widget.recipeId, servings),
                              ),
                              CustomText(
                                text: '$num',
                                weight: FontWeight.w600,
                                size: 17,
                              ),
                              GradientIcon(
                                icon: Icons.add,
                                size: 22,
                                gradient: toTextGradient(limelightGradient),
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                onPressed: () =>
                                    calendar.add(widget.recipeId, servings),
                              )
                            ],
                          ),
                  ),
                );
              },
            ),
            const SizedBox(width: 53 / 4),
            GradientButton(
              diameter: 53,
              gradient:
                  limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
              onPressed: () =>
                  goto(context, CalendarPage(recipeId: widget.recipeId)),
              child: Center(
                child: GradientIcon(
                  gradient: toSurfaceGradient(limelightGradient),
                  icon: UniconsLine.calender,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
