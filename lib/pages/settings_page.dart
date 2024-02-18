import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/flat_button.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBarText: "Settings",
      child: ListView(
        children: [
          Section(
            gradient: toSurfaceGradient(limelightGradient),
            label: "General",
            child: Consumer<PreferencesModel>(
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
                          inactiveColor:
                              toLighterSurfaceGradient(limelightGradient)[0],
                          label: (servings * -1).round().toString(),
                          onChanged: (double value) {
                            preferences
                                .setNbServings(value.round().toInt() * (-1));
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
                    onPressed: () => preferences.setNbServings(servings * -1),
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
                            const CustomText(
                              text: "Number of servings",
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
          ),
        ],
      ),
    );
  }
}
