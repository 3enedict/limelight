import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:limelight/widgets/data/ingredient.dart';
import 'package:limelight/data/ingredients.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String _query = "";

  List<IngredientData> sort(String query) {
    List<IngredientData> matches = [];
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
    List<IngredientData> sortedIngredients = sort(_query);

    double searchBarHeight = 50;
    double distanceBetweenItems = 15;

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: [
                  SizedBox(
                    width: distanceBetweenItems,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(searchBarHeight / 2),
                    ),
                    color: Colors.transparent,
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(searchBarHeight / 2),
                        gradient: const LinearGradient(
                          colors: limelightGradient,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      height: searchBarHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(searchBarHeight / 2),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Back",
                          style: GoogleFonts.workSans(
                            fontSize: 14 *
                                MediaQuery.of(context).textScaleFactor *
                                1.1,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: distanceBetweenItems,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: toSurfaceGradientWithReducedColorChange(
                              limelightGradient),
                        ),
                        borderRadius:
                            BorderRadius.circular(searchBarHeight / 2),
                      ),
                      height: searchBarHeight,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.search,
                            color: Color(0xFFDDDDDD),
                            size: 20.0,
                          ),
                          const SizedBox(
                            width: 10,
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
                                contentPadding: EdgeInsets.only(bottom: 4),
                              ),
                              expands: false,
                              style: GoogleFonts.workSans(
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFEEEEEE),
                                ),
                              ),
                              onChanged: (query) =>
                                  setState(() => _query = query),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: distanceBetweenItems,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(searchBarHeight / 2),
                      gradient: const LinearGradient(
                        colors: limelightGradient,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    height: searchBarHeight,
                    width: searchBarHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          color: Color(0xFFDDDDDD),
                          size: 25.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(searchBarHeight / 2),
                            ),
                          ),
                          onPressed: () {},
                          child: const SizedBox.expand(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: distanceBetweenItems,
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
