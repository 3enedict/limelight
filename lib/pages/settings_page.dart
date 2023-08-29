import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/prefs_section.dart';
import 'package:unicons/unicons.dart';

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
              Preference(
                icon: UniconsLine.ruler,
                text: "Unit system",
                values: const ["International", "Imperial"],
                onChanged: (_) {},
              ),
              Preference(
                icon: UniconsLine.dollar_sign,
                text: "Currency",
                values: const ["Euro", "Dollar"],
                onChanged: (_) {},
              )
            ],
          )
        ],
      ),
    );
  }
}
