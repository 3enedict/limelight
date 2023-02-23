import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/ingredient.dart';

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  final _gradient = const [
    Color(0xFFFF4B2B),
    Color(0xFFFF416C),
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
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
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
