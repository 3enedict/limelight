import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/gradient/container.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/textfield.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> list;
  const CustomDropdownButton({super.key, required this.list});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();

    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " Unit",
          style: TextStyle(
            color: textColor().withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        DropdownMenu<String>(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                color: textColor().withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(
                color: textColor().withOpacity(0.5),
              ),
            ),
          ),
          trailingIcon: GradientIcon(
            icon: Icons.expand_more,
            gradient: toTextGradient(limelightGradient),
          ),
          width: 100,
          textStyle: GoogleFonts.openSans(color: textColor()),
          onSelected: (String? value) => setState(() => dropdownValue = value!),
          dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>(
            (String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
