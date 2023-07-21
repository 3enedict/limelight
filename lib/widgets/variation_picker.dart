import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/data/variation.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class VariationPicker extends StatelessWidget {
  final String groupName;
  final List<Variation> variations;
  final void Function(Variation) onPressed;

  const VariationPicker({
    super.key,
    required this.groupName,
    required this.variations,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    List<CompactItem> variationButtons = [];
    for (var variation in variations) {
      variationButtons.add(
        variation.toCompactItem(() => onPressed(variation)),
      );
    }

    return GradientBox(
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              groupName,
              style: GoogleFonts.workSans(
                fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.2,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          ...variationButtons,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
