import 'package:flutter/material.dart';
import 'package:limelight/main.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';

import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/ingredient_search_item.dart';
import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class SearchPage extends StatefulWidget {
  final String searchHint;
  final List<String> Function(IngredientModel) getSelected;
  final void Function(String) selectIngredient;

  const SearchPage({
    super.key,
    required this.searchHint,
    required this.getSelected,
    required this.selectIngredient,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Not particularly happy with this as it's copied data...
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);
    final matches = generateItems(model, _query);

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
                searchHint: widget.searchHint,
                onChanged: (query) => setState(() => _query = query),
                onSubmitted: () {
                  if (matches.isNotEmpty) {
                    widget.selectIngredient(matches[0].ingredient.name);
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
      child: ListView(children: matches),
    );
  }

  List<IngredientSearchItem> generateItems(
    IngredientModel model,
    String query,
  ) {
    List<IngredientSearchItem> matches = [];

    List<IngredientDescription> ingredients = [];
    if (query == '') {
      List<String> selected = widget.getSelected(model).reversed.toList();
      ingredients = List.filled(selected.length, IngredientDescription.empty());

      for (var ingredient in model.ingredients) {
        final index = selected.indexOf(ingredient.name);
        if (index != -1) ingredients[index] = ingredient;
      }
    } else {
      ingredients = model.search(query);
    }

    for (var ingredient in ingredients) {
      matches.add(IngredientSearchItem(
        query: query,
        ingredient: ingredient,
        getSelected: widget.getSelected,
        selectIngredient: (ing) {
          setState(() => _query = '');
          widget.selectIngredient(ing);
        },
      ));
    }

    return matches;
  }
}
