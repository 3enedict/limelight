import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/ingredient.dart';
import 'package:limelight/gradients.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = [
      IngredientData(
        name: 'Lettuce',
        season: 'Spring and fall',
        price: '\$1.00 per head',
        cheapness: 'Really cheap',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Kale',
        season: 'Fall and winter',
        price: '\$2.00 per lb',
        cheapness: 'Cheap',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: fishGradient,
      ),
    ];

    return DefaultPage(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
      backgroundGradient: toBackgroundGradient(fishGradient),
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
