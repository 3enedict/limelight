import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/gradients.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<String> values;
  final void Function(String)? onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.values,
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.values[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " ${widget.label}",
          style: TextStyle(
            color: textColor().withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        PopupMenuButton<String>(
          initialValue: currentValue,
          color: toSurfaceGradient(limelightGradient)[0],
          itemBuilder: (context) => List.generate(
            widget.values.length,
            (int index) => PopupMenuItem(
              onTap: () {
                final value = widget.values[index];

                setState(() => currentValue = value);
                if (widget.onChanged != null) widget.onChanged!(value);
              },
              child: Row(
                children: [
                  GradientIcon(
                    icon: widget.icon,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.values[index],
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(color: textColor()),
                    ),
                  ),
                ],
              ),
            ),
            growable: false,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: textColor().withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 15, 14, 15),
                  child: GradientIcon(
                    icon: widget.icon,
                    size: 22,
                  ),
                ),
                Text(
                  currentValue,
                  style: GoogleFonts.openSans(
                    color: textColor(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Expanded(child: SizedBox()),
                GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.expand_more,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
