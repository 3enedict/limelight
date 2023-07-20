import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_textfield.dart';
import 'package:limelight/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _query = "";

  List<IngredientDescription> sort(String query) {
    List<IngredientDescription> matches = [];
    String cleanQuery = query.toLowerCase().trim();

    if (cleanQuery != "") {
      for (var ingredient in vegetables) {
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
    List<IngredientDescription> sortedIngredients = sort(_query);

    double searchBarHeight = 50;
    double distanceBetweenItems = 15;

    return EmptyPageWithBottomBar(
      body: ListView.builder(
        reverse: true,
        itemCount: sortedIngredients.length,
        itemBuilder: (BuildContext context, int index) {
          return sortedIngredients[index].toButtonItem();
        },
      ),
      bottomBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            SizedBox(
              width: distanceBetweenItems,
            ),
            GradientButton(
              borderRadius: searchBarHeight / 2,
              height: searchBarHeight,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Back",
                style: GoogleFonts.workSans(
                  fontSize: 14 * MediaQuery.of(context).textScaleFactor * 1.1,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: distanceBetweenItems,
            ),
            Expanded(
              child: GradientTextField(
                height: searchBarHeight,
                hint: "Search...",
                onChanged: (query) => setState(() => _query = query),
                icon: const Icon(
                  Icons.search,
                  color: Color(0xFFDDDDDD),
                  size: 20.0,
                ),
              ),
            ),
            SizedBox(
              width: distanceBetweenItems,
            ),
            GradientButton(
              diameter: searchBarHeight,
              gradient: limelightGradient,
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              child: const Icon(
                Icons.check,
                color: Color(0xFFDDDDDD),
                size: 25.0,
              ),
            ),
            SizedBox(
              width: distanceBetweenItems,
            ),
          ],
        ),
      ),
    );
  }
}
