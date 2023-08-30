import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient/icon.dart';

class Section extends StatelessWidget {
  final String label;
  final List<Widget> preferences;
  final List<Color> gradient;

  const Section({
    super.key,
    required this.label,
    required this.preferences,
    this.gradient = limelightGradient,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> items = preferences;

    for (var i = items.length - 1; i > 0; i--) {
      items.insert(
        i,
        Divider(
          color: textColor().withOpacity(0.2),
          indent: 10,
          endIndent: 10,
          height: 0,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " $label",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: textColor().withOpacity(0.5),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: toSurfaceGradient(gradient)),
            ),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }
}

class Preference extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? selected;
  final List<String> values;
  final void Function(String) onChanged;

  const Preference({
    super.key,
    required this.icon,
    required this.text,
    this.selected,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String value = values[0];
    if (selected != null) value = selected!;

    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: toSurfaceGradient(limelightGradient)[0],
          title: Text(
            text,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: textColor(),
              ),
            ),
          ),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: () {
                  onChanged(values[index]);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  foregroundColor: textColor().withOpacity(0.25),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                      child: GradientIcon(
                        gradient: values[index] == value
                            ? limelightGradient
                            : toTextGradient(limelightGradient)
                                .map((e) => e.withOpacity(0.8))
                                .toList(),
                        icon: Icons.panorama_fish_eye,
                      ),
                    ),
                    Text(
                      values[index],
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(color: textColor()),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0),
        foregroundColor: textColor().withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: GradientIcon(icon: icon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: textColor(),
                  ),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: textColor().withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
