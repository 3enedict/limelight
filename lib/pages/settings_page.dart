import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/custom_divider.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/widgets/preference.dart';
import 'package:limelight/widgets/section.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBar: const GradientAppBar(
        text: CustomText(
          text: "Settings",
          alignement: TextAlign.center,
          size: 22,
          weight: FontWeight.w700,
        ),
      ),
      child: ListView(
        children: [
          Section(
            gradient: toSurfaceGradient(limelightGradient),
            label: "General",
            child: Consumer<PreferencesModel>(
              builder: (context, preferences, child) {
                return Column(
                  children: [
                    Preference(
                      icon: UniconsLine.ruler,
                      text: "Unit system",
                      selected: preferences.unitSystem,
                      values: const ["International", "Imperial"],
                      onChanged: (str) => preferences.setUnitSystem(str),
                    ),
                    const CustomDivider(indent: 10),
                    Preference(
                      icon: UniconsLine.dollar_sign,
                      text: "Currency",
                      selected: preferences.currency,
                      values: const ["Euro", "Dollar"],
                      onChanged: (str) => preferences.setCurrency(str),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
