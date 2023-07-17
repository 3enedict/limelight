import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';

class RecipeDescriptionPage extends StatelessWidget {
  final int recipeId;

  const RecipeDescriptionPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    final String recipeName = recipes[recipeId].name;

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
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      recipeName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            14 * MediaQuery.of(context).textScaleFactor * 1.2,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.transparent,
              elevation: 4,
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: limelightGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Back",
                    style: GoogleFonts.workSans(
                      fontSize:
                          14 * MediaQuery.of(context).textScaleFactor * 1.1,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
