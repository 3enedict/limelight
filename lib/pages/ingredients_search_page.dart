import 'package:flutter/material.dart';

import 'package:limelight/transitions.dart';

import 'package:limelight/pages/add_ingredient_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_textfield.dart';
import 'package:limelight/data/json/ingredient.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatefulWidget {
  final void Function(IngredientDescription) onSubmitted;

  const SearchPage({super.key, required this.onSubmitted});

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
              diameter: searchBarHeight - 4,
              onPressed: () => Navigator.of(context).pop(),
              padding: const EdgeInsets.all(0),
              child: const Icon(
                Icons.chevron_left,
                color: Color(0xFFDDDDDD),
                size: 25.0,
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
            sortedIngredients.isEmpty
                ? GradientButton(
                    diameter: searchBarHeight - 4,
                    gradient: limelightGradient,
                    onPressed: () =>
                        fadeTransition(context, const AddIngredientPage()),
                    padding: const EdgeInsets.all(0),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFFDDDDDD),
                      size: 25.0,
                    ),
                  )
                : GradientButton(
                    diameter: searchBarHeight - 4,
                    gradient: limelightGradient,
                    onPressed: () => widget.onSubmitted(sortedIngredients[0]),
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
