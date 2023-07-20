import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/recipe.dart';
import 'package:limelight/data/variation_group.dart';
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
      return const EmptyPage(gradient: limelightGradient);
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

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: GradientBackButton(),
          ),
        ],
      ),
    );
  }
}
