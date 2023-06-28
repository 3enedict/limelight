import 'package:flutter/material.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends SearchDelegate {
  List<IngredientData> ingredients = [
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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var ingredient in ingredients) {
      if (ingredient.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ingredient.name);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var ingredient in ingredients) {
      if (ingredient.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ingredient.name);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}
