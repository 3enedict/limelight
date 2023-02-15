import 'package:flutter/material.dart';

import 'package:limelight/ingredients_page.dart';
import 'package:limelight/ingredient.dart';

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  final _gradient = const [
    Color(0xFFFF4B2B),
    Color(0xFFFF416C),
  ];

  @override
  Widget build(BuildContext context) {
    return IngredientsPageLayout(
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
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
