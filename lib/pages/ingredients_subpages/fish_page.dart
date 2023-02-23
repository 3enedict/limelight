import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/ingredient.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  final _gradient = const [
    Color(0xFF00d2ff),
    Color(0xFF3a7bd5),
  ];

  @override
  Widget build(BuildContext context) {
    final ingredients = [
      IngredientData(
        name: 'Lettuce',
        season: 'Spring and fall',
        price: '\$1.00 per head',
        cheapness: 'Really cheap',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Kale',
        season: 'Fall and winter',
        price: '\$2.00 per lb',
        cheapness: 'Cheap',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: _gradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00 per lb',
        cheapness: 'Expensive',
        gradient: _gradient,
      ),
    ];

    return DefaultPage(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
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
