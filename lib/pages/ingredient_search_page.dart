import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/ingredient_search_item.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';

class IngredientSearchPage extends StatefulWidget {
  const IngredientSearchPage({super.key});

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
                  onPressed: () => Navigator.of(context).pop(),
                  size: 26,
                  icon: Icons.chevron_left,
                ),
                Expanded(
                  child: AppbarSearchBar(
                    controller: _controller,
                    searchHint: 'Select ingredients to cook with',
                    onChanged: (query) => setState(() => _query = query),
                    onSubmitted: () {
                      if (_query != '') {
                        ingredients.select(matches[0].name);
                      }
                    },
                  ),
                ),
                GradientIcon(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  gradient: toTextGradient(limelightGradient),
                  //onPressed: () => goto(context, const IngredientEditorPage()),
                  onPressed: () {},
                  size: 26,
                  icon: Icons.add,
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
