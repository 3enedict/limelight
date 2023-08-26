import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/gradients.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> list;
  final String label;
  final FocusNode? focusNode;

  const CustomDropdown({
    super.key,
    required this.list,
    required this.label,
    this.focusNode,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
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
          " ${widget.label}",
          style: TextStyle(
            color: textColor().withOpacity(0.5),
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: textColor().withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 15, 14, 15),
                child: GradientIcon(
                  icon: UniconsLine.ruler,
                  size: 22,
                ),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    autofocus: true,
                    isExpanded: true,
                    elevation: 0,
                    focusNode: widget.focusNode,
                    style: GoogleFonts.openSans(
                      color: textColor(),
                      fontWeight: FontWeight.w400,
                    ),
                    dropdownColor: toBackgroundGradient(limelightGradient)[0],
                    value: dropdownValue,
                    icon: GradientIcon(
                      gradient: toTextGradient(limelightGradient),
                      icon: Icons.expand_more,
                    ),
                    onChanged: (String? value) => setState(
                      () => dropdownValue = value!,
                    ),
                    items: widget.list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
