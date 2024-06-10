import 'package:flutter/material.dart';
import 'package:limelight/widgets/recipe_description_items.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/flat_button.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: words['settings']![0],
      child: ListView(
        children: [
          Section(
            gradient: toSurfaceGradient(limelightGradient),
            label: words['general']![0],
            child: Column(
              children: addDividers(
                58,
                20,
                [
                  Consumer<PreferencesModel>(
                    builder: (context, preferences, child) {
                      final servings = preferences.nbServings;
                      if (servings < 0) {
                        return Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value: servings * -1,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                activeColor: limelightGradient[1],
                                inactiveColor: toLighterSurfaceGradient(
                                    limelightGradient)[0],
                                label: (servings * -1).round().toString(),
                                onChanged: (double value) {
                                  preferences.setNbServings(
                                      value.round().toInt() * (-1));
                                },
                              ),
                            ),
                            GradientIcon(
                              gradient: toTextGradient(limelightGradient),
                              onPressed: () =>
                                  preferences.setNbServings(servings * (-1)),
                              padding: const EdgeInsets.all(8),
                              icon: Icons.check,
                            ),
                          ],
                        );
                      } else {
                        return FlatButton(
                          onPressed: () =>
                              preferences.setNbServings(servings * -1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: words['nbServings']![0],
                                  ),
                                  CustomText(
                                    text: "$servings",
                                    opacity: 0.6,
                                    size: 12,
                                    weight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  Consumer<PreferencesModel>(
                    builder: (context, preferences, child) {
                      final planner = preferences.planner;
                      final planners = [
                        words['calendar']![0],
                        words['mealList']![0]
                      ];

                      return FlatButton(
                        borderRadius: 20,
                        onPressed: () {
                          if (planner == 0) preferences.setPlanner(1);
                          if (planner == 1) preferences.setPlanner(0);
                        },
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: words['typeOfPlanner']![0],
                                ),
                                CustomText(
                                  text: planners[planner],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
