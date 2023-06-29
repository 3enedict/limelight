import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _query = "";

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

  List<IngredientData> sort(String query) {
    List<IngredientData> matches = [];
    String cleanQuery = query.toLowerCase().trim();

    if (cleanQuery != "") {
      for (var ingredient in ingredients) {
        String cleanIngredient = ingredient.name.toLowerCase().trim();

        if (cleanIngredient.contains(cleanQuery)) {
          matches.add(ingredient);
        }
      }
    }

    return matches;
  }

  @override
  Widget build(BuildContext context) {
    List<IngredientData> sortedIngredients = sort(_query);

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
                itemCount: sortedIngredients.length,
                itemBuilder: (BuildContext context, int index) {
                  return sortedIngredients[index].toButtonItem();
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
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFDDDDDD),
                      size: 20.0,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      cursorColor: const Color(0xFFEEEEEE),
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFEEEEEE),
                        ),
                        border: InputBorder.none,
                      ),
                      expands: false,
                      style: GoogleFonts.workSans(
                        textStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFEEEEEE),
                        ),
                      ),
                      onChanged: (query) => setState(() => _query = query),
                    ),
                  ),
                  BackButton(
                    color: const Color(0xFFDDDDDD),
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
