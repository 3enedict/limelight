import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/data/recipe.dart';
import 'package:limelight/widgets/data/variation_group.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class RecipeDescriptionPage extends StatefulWidget {
  final int recipeId;

  const RecipeDescriptionPage({super.key, required this.recipeId});

  @override
  State<RecipeDescriptionPage> createState() => RecipeDescriptionPageState();
}

class RecipeDescriptionPageState extends State<RecipeDescriptionPage> {
  List<String>? _variations;

  @override
  void initState() {
    super.initState();
    getVariations(widget.recipeId).then(
      (variations) => setState(() {
        _variations = variations;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_variations == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: toBackgroundGradient(limelightGradient),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
    }

    final String recipeName = recipes[widget.recipeId].name;
    final List<VariationGroup> variationGroups =
        recipes[widget.recipeId].variationGroups;

    List<CompactItem> ingredients = [];
    for (var ingredient in recipes[widget.recipeId].ingredients) {
      ingredients.add(ingredient.toCompactItem(() {}));
    }

    for (var i = 0; i < _variations!.length; i++) {
      for (var variation in variationGroups[i].variations) {
        if (_variations![i] == variation.name) {
          for (var ingredient in variation.ingredients) {
            ingredients.add(ingredient.toCompactItem(() {}));
          }
        }
      }
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
                  ...ingredients,
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
