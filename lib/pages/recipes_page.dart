import 'package:flutter/material.dart';
import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/widgets/custom_divider.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/widgets/preference.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/recipe_description_items.dart';
import 'package:limelight/widgets/recipe_description_box.dart';
import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/pages/calendar_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/main.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  int _pageId = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        return Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (id) => setState(() => _pageId = id),
                children: List.generate(
                  recipes.number,
                  (int index) {
                    return EmptyPage(
                      appBar: GradientAppBar(
                        text: CustomText(
                          text: recipes.name(index),
                          alignement: TextAlign.center,
                          size: 20,
                          weight: FontWeight.w700,
                        ),
                      ),
                      child: Content(recipeId: index, recipes: recipes),
                    );
                  },
                ),
              ),
            ),
            ActionButtons(recipeId: _pageId, recipes: recipes),
          ],
        );
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
      child: Consumer<VariationModel>(
        builder: (context, variations, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 2.5,
                ),
                child: RecipeDescriptionBox(
                  label: "Ingredients",
                  items: generateIngredients(
                      recipeId, recipes, variations.variationIds(recipeId)),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: RecipeDescriptionBox(
                  label: "Instructions",
                  items: generateInstructions(
                      recipeId, recipes, variations.variationIds(recipeId)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final int recipeId;
  final RecipeModel recipes;

  const ActionButtons({
    super.key,
    required this.recipeId,
    required this.recipes,
  });

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
                  return Dialog(
                    backgroundColor: toSurfaceGradient(limelightGradient)[1],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    insetPadding: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: CustomText(
                              text: "Variations",
                              alignement: TextAlign.center,
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: Consumer<VariationModel>(
                              builder: (context, variations, child) {
                                List<Widget> variationList = [];
                                final num =
                                    recipes.numberOfVariationGroups(recipeId);

                                for (var i = 0; i < num; i++) {
                                  int selected = 0;
                                  for (var id
                                      in variations.variationIds(recipeId)) {
                                    if (id.$1 == i) selected = id.$2;
                                  }

                                  List<String> names = [];

                                  for (var j = 0;
                                      j <
                                          recipes.numberOfVariations(
                                              recipeId, i);
                                      j++) {
                                    names.add(
                                        recipes.variationName(recipeId, i, j));
                                  }

                                  variationList.add(
                                    Preference(
                                      icon: Icons.panorama_fish_eye,
                                      text: recipes.variationGroupName(
                                          recipeId, i),
                                      selected: names[selected],
                                      values: names,
                                      onChanged: (str) => variations.set(
                                          recipeId, i, names.indexOf(str)),
                                    ),
                                  );
                                }

                                for (var i = variationList.length - 1;
                                    i > 0;
                                    i--) {
                                  variationList.insert(
                                    i,
                                    const CustomDivider(indent: 10),
                                  );
                                }

                                return ListView(
                                  shrinkWrap: true,
                                  children: variationList,
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
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
              ),
              child: Center(
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.layers,
                ),
              ),
            ),
            const SizedBox(width: 51 / 2),
            GradientButton(
              diameter: 54,
              gradient: toLighterSurfaceGradient(limelightGradient),
              onPressed: () {
                Provider.of<CalendarModel>(context, listen: false)
                    .addIfNone(recipeId);

                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return Consumer<CalendarModel>(
                      builder: (context, calendar, child) {
                        if (calendar.mealList[recipeId] == 0) {
                          Navigator.of(context).pop();
                        }

                        List<Widget> items = [];
                        for (var i = 0; i < calendar.mealList.length; i++) {
                          final num = calendar.mealList[i];

                          if (num != 0) {
                            items.add(
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
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
                                ],
                              ),
                            );
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GradientIcon(
                                          onPressed: () =>
                                              calendar.removeFromList(recipeId),
                                          gradient:
                                              toTextGradient(limelightGradient),
                                          icon: Icons.remove,
                                        ),
                                        const SizedBox(width: 5),
                                        GradientIcon(
                                          onPressed: () =>
                                              calendar.add(recipeId),
                                          gradient:
                                              toTextGradient(limelightGradient),
                                          icon: Icons.add,
                                        ),
                                      ],
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
                                  ],
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
              child: const Center(
                child: GradientIcon(
                  gradient: limelightGradient,
                  icon: UniconsLine.clipboard_notes,
                  size: 27,
                ),
              ),
            ),
            const SizedBox(width: 51 / 2),
            GradientButton(
              diameter: 53,
              gradient:
                  limelightGradient.map((e) => e.withOpacity(0.8)).toList(),
              onPressed: () => goto(context, CalendarPage(recipeId: recipeId)),
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
