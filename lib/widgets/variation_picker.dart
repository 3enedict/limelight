import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/widgets/calendar.dart';
import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/gradients.dart';

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

    const double borderSize = 15;
    const double margin = 20;
    var variationGroup =
        recipes[widget.recipeId].variationGroups[_variationNumber];

    List<Card> variationButtons = [];
    for (var variation in variationGroup.variations) {
      variationButtons.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderSize),
          ),
          color: Colors.transparent,
          elevation: 4,
          margin: const EdgeInsets.fromLTRB(margin, 0, margin, margin),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderSize),
              gradient: LinearGradient(
                colors: toSurfaceGradient(limelightGradient),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: MediaQuery.of(context).size.width - 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderSize),
                ),
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
              ),
              onPressed: () => setState(() {
                setVariation(widget.recipeId, variation.name);
                _variationNumber += 1;
              }),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      gradient: const LinearGradient(colors: limelightGradient),
                    ),
                    height: 22,
                    width: 22,
                  ),
                  const SizedBox(width: 17),
                  Text(
                    variation.name,
                    style: GoogleFonts.workSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    variation.time,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 0.8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
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
                      margin: const EdgeInsets.all(margin),
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
