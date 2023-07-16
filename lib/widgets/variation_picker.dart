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
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderSize),
              gradient: LinearGradient(
                colors: toSurfaceGradient(limelightGradient),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: 70,
            width: MediaQuery.of(context).size.width - 120,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderSize),
                ),
              ),
              onPressed: () => setState(() {
                setVariation(widget.recipeId, variation.name);
                _variationNumber += 1;
              }),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(colors: limelightGradient),
                    ),
                    margin: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                    height: 25,
                    width: 25,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            variation.name,
                            style: GoogleFonts.workSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            variation.time,
                            style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14 *
                                    MediaQuery.of(context).textScaleFactor *
                                    0.8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: toBackgroundGradient(limelightGradient),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          variationGroup.groupName,
                          style: GoogleFonts.workSans(
                            fontSize: 14 *
                                MediaQuery.of(context).textScaleFactor *
                                1.2,
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
      ),
    );
  }
}
