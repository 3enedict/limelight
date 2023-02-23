import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/ingredient.dart';
import 'package:limelight/gradients.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = [
      IngredientData(
        name: 'Lettuce',
        season: 'Spring and fall',
        price: '\$1.00 per head',
        cheapness: 'Really cheap',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Kale',
        season: 'Fall and winter',
        price: '\$2.00 per lb',
        cheapness: 'Cheap',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: vegetablesGradient,
      ),
    ];

    return DefaultPage(
      title: 'Vegetables',
      titleBackground: const AssetImage('assets/Vegetables.webp'),
      backgroundGradient: toBackgroundGradient(vegetablesGradient),
      items: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ingredients[index].toButtonItem();
          },
          childCount: ingredients.length,
        ),
      ),
    );
  }
}
