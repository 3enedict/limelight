import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/data/ingredient.dart';
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
      gradient: fishGradient,
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
      gradient: leafyGreensGradient,
    ),
    IngredientData(
      name: 'Arugula',
      season: 'Late spring and early fall',
      price: '\$10.00',
      unit: 'per lb',
      gradient: fishGradient,
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: toBackgroundGradient(limelightGradient),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                reverse: true,
                itemCount: ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  return ingredients[index].toButtonItem();
                },
              ),
            ),
          ),
          Container(
            color: toBackgroundGradient(limelightGradient)[1],
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: toSurfaceGradientWithReducedColorChange(
                      limelightGradient),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Search...",
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white60,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
