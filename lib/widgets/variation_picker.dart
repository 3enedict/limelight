import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class VariationPicker extends StatefulWidget {
  final int recipeId;

  const VariationPicker({super.key, required this.recipeId});

  @override
  State<VariationPicker> createState() => VariationPickerState();
}

class VariationPickerState extends State<VariationPicker> {
  int _variationNumber = 0;

  @override
  Widget build(BuildContext context) {
    if (_variationNumber >
        recipes[widget.recipeId].variationGroups.length - 1) {
      return Calendar(
        recipeId: widget.recipeId,
      );
    }

    var variationGroup =
        recipes[widget.recipeId].variationGroups[_variationNumber];

    List<CompactItem> variationButtons = [];
    for (var variation in variationGroup.variations) {
      variationButtons.add(
        variation.toCompactItem(
          () => setState(() {
            setVariation(widget.recipeId, variation.name);
            _variationNumber += 1;
          }),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: toBackgroundGradient(limelightGradient),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: limelightGradient,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: toBackgroundGradient(limelightGradient),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        variationGroup.groupName,
                        style: GoogleFonts.workSans(
                          fontSize:
                              14 * MediaQuery.of(context).textScaleFactor * 1.2,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    ...variationButtons,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
