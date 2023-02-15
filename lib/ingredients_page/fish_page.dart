import 'package:flutter/material.dart';

import 'package:limelight/ingredients_page.dart';
import 'package:limelight/ingredient.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  final _gradient = const [
    Color(0xFF00d2ff),
    Color(0xFF3a7bd5),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
      ingredients: [
        Ingredient(
          name: 'Lettuce',
          season: 'Spring and fall',
          price: '\$1.00 per head',
          cheapness: 'Really cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Kale',
          season: 'Fall and winter',
          price: '\$2.00 per lb',
          cheapness: 'Cheap',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
        Ingredient(
          name: 'Arugula',
          season: 'Late spring and early fall',
          price: '\$10.00 per lb',
          cheapness: 'Expensive',
          gradient: _gradient,
        ),
      ],
    );
  }
}
