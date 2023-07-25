import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/widgets/gradient_box.dart';
import 'package:limelight/widgets/items/compact_item.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class VariationPickerPage extends StatelessWidget {
  final int recipeId;
  final int? variationGroupId;

  const VariationPickerPage({
    super.key,
    required this.recipeId,
    this.variationGroupId,
  });

  @override
  Widget build(BuildContext context) {
    List<CompactItem> variationButtons = [];

    return EmptyPage(
      gradient: limelightGradient,
      child: Center(
        child: GradientBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Sample text",
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
        ),
      ),
    );
  }
}
