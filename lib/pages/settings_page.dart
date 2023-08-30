import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/provider/preferences_model.dart';
import 'package:limelight/widgets/prefs_section.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      appBar: AppBar(
        backgroundColor: toBackgroundGradient(limelightGradient)[0],
        elevation: 4,
        shadowColor: Colors.black,
        title: Text(
          " Settings",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: textColor(),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      child: ListView(
        children: [
          Section(
            gradient: toSurfaceGradient(limelightGradient),
            label: "General",
            preferences: [
              Consumer<PreferencesModel>(
                builder: (context, preferences, child) {
                  return Preference(
                    icon: UniconsLine.ruler,
                    text: "Unit system",
                    selected: preferences.unitSystem,
                    values: const ["International", "Imperial"],
                    onChanged: (str) => preferences.setUnitSystem(str),
                  );
                },
              ),
              Consumer<PreferencesModel>(
                builder: (context, preferences, child) {
                  return Preference(
                    icon: UniconsLine.dollar_sign,
                    text: "Currency",
                    selected: preferences.currency,
                    values: const ["Euro", "Dollar"],
                    onChanged: (str) => preferences.setCurrency(str),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
