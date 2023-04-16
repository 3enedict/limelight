import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = [
      IngredientData(
        name: 'Lettuce',
        season: 'Spring and fall',
        price: '\$1.00',
        unit: 'per head',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Kale',
        season: 'Fall and winter',
        price: '\$2.00',
        unit: 'per lb',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00',
        unit: 'per lb',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00',
        unit: 'per lb',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00',
        unit: 'per lb',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00',
        unit: 'per lb',
        gradient: vegetablesGradient,
      ),
      IngredientData(
        name: 'Arugula',
        season: 'Late spring and early fall',
        price: '\$10.00',
        unit: 'per lb',
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
