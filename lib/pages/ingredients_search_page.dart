import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/widgets/fab.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final ingredients = [
    IngredientData(
      name: 'Lettuce',
      season: 'Spring and fall',
      price: '\$1.00',
      unit: 'per head',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Kale',
      season: 'Fall and winter',
      price: '\$2.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: meatGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: CustomFloatingActionButton(
          gradient: toSurfaceGradient(limelightGradient),
          icon: const Icon(Icons.add),
          onPressed: () => Navigator.pop(context),
        ),
        body: const Center(
          child: Text("Search page"),
        ),
      ),
    );
  }
}
