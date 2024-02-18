import 'package:flutter/material.dart';

import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/pages/recipe_editor_page.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/utils/utils.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class CookbookPage extends StatefulWidget {
  const CookbookPage({super.key});

  @override
  State<CookbookPage> createState() => _CookbookPageState();
}

class _CookbookPageState extends State<CookbookPage> {
  String _query = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeModel>(context, listen: false);
    final matches = searchRecipes(recipes);

    return EmptyPage(
      appBar: GradientAppBar(
        child: Row(
          children: [
            GradientIcon(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
              gradient: toTextGradient(limelightGradient),
              onPressed: () => Navigator.of(context).pop(),
              size: 26,
              icon: Icons.chevron_left,
            ),
            Expanded(
              child: AppbarSearchBar(
                controller: _controller,
                searchHint: 'Search for recipes',
                onChanged: (query) => setState(() => _query = query),
                onSubmitted: () {
                  if (matches.isNotEmpty) {
                    setState(() => _query = '');

                    Navigator.of(context).push(SwipeablePageRoute(
                      builder: (BuildContext context) => RecipeEditor(
                        recipeId: matches[0],
                      ),
                    ));
                  }
                },
              ),
            ),
            GradientIcon(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
              gradient: toTextGradient(limelightGradient),
              onPressed: () => goto(context, const IngredientEditorPage()),
              size: 26,
              icon: Icons.add,
            ),
          ],
        ),
      ),
      child: ListView(
        children: matches.map((e) {
          final runes = recipes.name(e).runes;
          List<TextSpan> styledName = List.generate(
            runes.length,
            (int index) {
              String character =
                  String.fromCharCode(runes.elementAtOrNull(index)!);
              bool match =
                  _query.toLowerCase().contains(character.toLowerCase());

              return TextSpan(
                text: character,
                style: TextStyle(
                  color:
                      match ? modifyColor(textColor(), 0.95, 0.1) : textColor(),
                  fontWeight: match ? FontWeight.w900 : FontWeight.w100,
                ),
              );
            },
          );

          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: GradientButton(
              gradient: toSurfaceGradient(limelightGradient),
              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
              borderRadius: 15,
              onPressed: () => Navigator.of(context).push(SwipeablePageRoute(
                builder: (BuildContext context) => RecipeEditor(recipeId: e),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GradientIcon(
                    gradient: limelightGradient,
                    padding: EdgeInsets.all(20),
                    size: 30,
                    icon: Icons.panorama_fish_eye,
                  ),
                  Text.rich(
                    TextSpan(
                      children: styledName,
                      style: GoogleFonts.workSans(
                        color: textColor(),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    text: recipes.recipe(e).difficulty,
                    opacity: 0.8,
                    style: FontStyle.italic,
                    size: 13,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<int> searchRecipes(RecipeModel recipes) {
    List<int> results = [];
    List<List<int>> secondaryResults = [];

    final query = _query.toLowerCase();
    for (var i = 0; i < recipes.number; i++) {
      final name = recipes.name(i).toLowerCase();
      if (name.startsWith(query)) {
        results.insert(0, i);
      } else if (name.contains(query)) {
        results.add(i);
      } else {
        int num = _checkCharacterMatches(query, name);
        _addSecondaryResult(secondaryResults, num, i);
      }
    }

    _addResultsByPriority(results, secondaryResults);

    return results;
  }

  int _checkCharacterMatches(String query, String name) {
    int numberOfMatches = -1;
    for (var rune in query.runes) {
      final character = String.fromCharCode(rune);

      if (name.contains(character)) numberOfMatches++;
    }

    return numberOfMatches;
  }

  void _addSecondaryResult(
    List<List<int>> secondaryResults,
    int numberOfMatches,
    int ingredient,
  ) {
    if (numberOfMatches != -1) {
      while (secondaryResults.elementAtOrNull(numberOfMatches) == null) {
        secondaryResults.add([]);
      }

      secondaryResults[numberOfMatches].add(ingredient);
    }
  }

  void _addResultsByPriority(
    List<int> results,
    List<List<int>> secondaryResults,
  ) {
    for (var resultList in secondaryResults.reversed) {
      results.addAll(resultList);
    }
  }
}
