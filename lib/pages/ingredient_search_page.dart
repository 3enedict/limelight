import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/ingredient_search_item.dart';
import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/utils.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

const int recipePage = 2;

class IngredientSearchPage extends StatefulWidget {
  final PageController pageController;
  const IngredientSearchPage({
    super.key,
    required this.pageController,
  });

  @override
  State<IngredientSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<IngredientSearchPage> {
  String _query = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final matches =
            _query == '' ? ingredients.selected : ingredients.search(_query);

        final items = matches
            .map((e) => IngredientSearchItem(
                  query: _query,
                  ingredient: e,
                  selected: ingredients.namesOfSelected.contains(e.name),
                  selectIngredient: (ing) {
                    setState(() => _query = '');
                    _controller.clear();

                    ingredients.select(ing);
                  },
                ))
            .toList();

        return EmptyPage(
          appBar: GradientAppBar(
            child: Row(
              children: [
                GradientIcon(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  gradient: toTextGradient(limelightGradient),
                  onPressed: () => goto(context, const IngredientEditorPage()),
                  size: 26,
                  icon: Icons.add,
                ),
                Expanded(
                  child: AppbarSearchBar(
                    controller: _controller,
                    searchHint: 'Select ingredients to cook with',
                    onChanged: (query) => setState(() => _query = query),
                    onSubmitted: () {
                      if (_query != '' && matches.isNotEmpty) {
                        ingredients.select(matches[0].name);
                      }
                    },
                    popContext: () =>
                        widget.pageController.jumpToPage(recipePage),
                  ),
                ),
                GradientIcon(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  gradient: toTextGradient(limelightGradient),
                  onPressed: () {
                    widget.pageController.jumpToPage(recipePage);
                    Navigator.of(context).pop();
                  },
                  size: 26,
                  icon: Icons.done,
                ),
              ],
            ),
          ),
          child: ListView(children: items),
        );
      },
    );
  }
}
