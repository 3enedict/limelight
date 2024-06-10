import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/calendar_model.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/pages/recipe_editor_page.dart';
import 'package:limelight/utils/gradient_container.dart';
import 'package:limelight/utils/custom_popup_menu.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/utils/gradient_button.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/custom_text.dart';
import 'package:limelight/data/json/recipe.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

class CookbookPage extends StatefulWidget {
  const CookbookPage({super.key});

  @override
  State<CookbookPage> createState() => _CookbookPageState();
}

class _CookbookPageState extends State<CookbookPage> {
  String _query = '';
  int _recipe = 0;

  final _controller = TextEditingController();
  final _node = FocusNode();
  final _pageController = PageController();

  Widget newRecipe = const SizedBox();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (page) {
        if (page == 0) {
          _node.requestFocus();
        } else {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      children: [
        Consumer<RecipeModel>(
          builder: (context, recipes, child) {
            final matches = searchRecipes(recipes);

            return EmptyPage(
              appBar: GradientAppBar(
                child: Row(
                  children: [
                    GradientIcon(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      gradient: toTextGradient(limelightGradient),
                      onPressed: () => Navigator.of(context).pop(),
                      size: 26,
                      icon: Icons.chevron_left,
                    ),
                    Expanded(
                      child: AppbarSearchBar(
                        controller: _controller,
                        node: _node,
                        searchHint: words['searchRecipe']![0],
                        onChanged: (query) => setState(() => _query = query),
                        onSubmitted: () {
                          if (matches.isNotEmpty) {
                            setState(() {
                              _query = '';
                              _recipe = matches[0];
                            });

                            FocusScope.of(context).requestFocus(FocusNode());
                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    GradientIcon(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 6),
                      gradient: toTextGradient(limelightGradient),
                      onPressed: () => setState(() {
                        _node.unfocus();

                        newRecipe = Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: GradientContainer(
                            gradient: toSurfaceGradient(limelightGradient),
                            borderRadius: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const GradientIcon(
                                  gradient: limelightGradient,
                                  padding: EdgeInsets.all(20),
                                  size: 26,
                                  icon: Icons.panorama_fish_eye,
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    onSubmitted: (text) {
                                      RecipeData recipe = RecipeData.empty();
                                      recipe.name = text;

                                      recipes.add(recipe);
                                      setState(
                                          () => newRecipe = const SizedBox());
                                    },
                                    style: GoogleFonts.openSans(
                                      color:
                                          toTextGradient(limelightGradient)[1],
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        );
                      }),
                      size: 26,
                      icon: Icons.add,
                    ),
                  ],
                ),
              ),
              child: ListView(
                children: [
                  newRecipe,
                  ...matches.map((e) {
                    final runes = recipes.name(e).runes;
                    List<TextSpan> styledName = List.generate(
                      runes.length,
                      (int index) {
                        String character =
                            String.fromCharCode(runes.elementAtOrNull(index)!);
                        bool match = _query
                            .toLowerCase()
                            .contains(character.toLowerCase());

                        return TextSpan(
                          text: character,
                          style: TextStyle(
                            color: match
                                ? modifyColor(textColor(), 0.95, 0.1)
                                : textColor(),
                            fontWeight:
                                match ? FontWeight.w900 : FontWeight.w100,
                          ),
                        );
                      },
                    );

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      // I'm so sorry, this is just to create a context
                      // so that the menu knows where it needs to be.
                      child: Consumer<CalendarModel>(
                        builder: (context, calendar, child) {
                          return GradientButton(
                            gradient: toSurfaceGradient(limelightGradient),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                            borderRadius: 15,
                            onPressed: () {
                              setState(() => _recipe = e);

                              FocusScope.of(context).requestFocus(FocusNode());
                              _pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            onLongPress: () {
                              final RelativeRect position =
                                  buttonMenuPosition(context);

                              List<PopupMenuItem<int>> list = [
                                PopupMenuItem<int>(
                                  onTap: () => recipes.remove(e),
                                  child: ListTile(
                                    leading: const GradientIcon(
                                      gradient: redGradient,
                                      icon: Icons.remove,
                                    ),
                                    title: CustomText(
                                      text: words['remove']![0],
                                    ),
                                  ),
                                ),
                              ];

                              showMenu(
                                context: context,
                                position: position,
                                elevation: 0,
                                color: toSurfaceGradient(limelightGradient)[1],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width -
                                      2 * 15,
                                ),
                                items: list,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const GradientIcon(
                                  gradient: limelightGradient,
                                  padding: EdgeInsets.all(20),
                                  size: 26,
                                  icon: Icons.panorama_fish_eye,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: styledName,
                                    style: GoogleFonts.workSans(
                                      color: textColor(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
        ...recipeEditor(_recipe, _pageController),
      ],
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
