import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/data/provider/variation_model.dart';
import 'package:limelight/widgets/custom_divider.dart';
import 'package:limelight/widgets/flat_button.dart';
import 'package:limelight/widgets/preference.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/gradients.dart';

class VariationPickerDialog extends StatelessWidget {
  final int recipeId;
  final RecipeModel recipes;

  const VariationPickerDialog({
    super.key,
    required this.recipeId,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
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
                  final num = recipes.numberOfVariationGroups(recipeId);

                  for (var i = 0; i < num; i++) {
                    int selected = 0;
                    for (var id in variations.variationIds(recipeId)) {
                      if (id.$1 == i) selected = id.$2;
                    }

                    List<String> names = [];

                    for (var j = 0;
                        j < recipes.numberOfVariations(recipeId, i);
                        j++) {
                      names.add(recipes.variationName(recipeId, i, j));
                    }

                    variationList.add(
                      Preference(
                        icon: Icons.panorama_fish_eye,
                        text: recipes.variationGroupName(recipeId, i),
                        selected: names[selected],
                        values: names,
                        onChanged: (str) =>
                            variations.set(recipeId, i, names.indexOf(str)),
                      ),
                    );
                  }

                  variationList.add(
                    Consumer<PreferencesModel>(
                      builder: (context, preferences, child) {
                        final num = preferences.nbServingsLocal(recipeId);

                        return num < 0
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
                                child: Slider(
                                  value: num * -1,
                                  min: 1,
                                  max: 10,
                                  divisions: 9,
                                  activeColor: limelightGradient[1],
                                  inactiveColor: toLighterSurfaceGradient(
                                      limelightGradient)[0],
                                  label: (num * -1).round().toString(),
                                  onChanged: (double value) {
                                    preferences.setNbServingsLocal(
                                      value.round().toInt() * (-1),
                                      recipeId,
                                    );
                                  },
                                ),
                              )
                            : FlatButton(
                                onPressed: () => preferences.setNbServingsLocal(
                                  -1,
                                  recipeId,
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(
                                        18,
                                      ),
                                      child: GradientIcon(
                                        icon: Icons.panorama_fish_eye,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                          text: "Number of servings",
                                        ),
                                        CustomText(
                                          text: "$num",
                                          opacity: 0.6,
                                          size: 12,
                                          weight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  );

                  for (var i = variationList.length - 1; i > 0; i--) {
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
              child: Consumer<PreferencesModel>(
                builder: (context, preferences, child) {
                  final num = preferences.nbServingsLocal(recipeId);

                  return num < 0
                      ? FlatButton(
                          onPressed: () => preferences.setNbServingsLocal(
                            -num,
                            recipeId,
                          ),
                          borderRadius: 10,
                          child: const CustomText(text: 'Confirm'),
                        )
                      : FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          borderRadius: 10,
                          child: const CustomText(text: 'Done'),
                        );
                },
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
