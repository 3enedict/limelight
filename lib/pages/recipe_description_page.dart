import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
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
            child: ItemList(
              title: "Ingredients",
              titleBackground: const AssetImage('assets/Recipe.jpg'),
              gradient: fishGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ingredients[index];
                  },
                  childCount: ingredients.length,
                ),
              ),
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
