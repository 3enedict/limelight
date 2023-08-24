import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/items/ingredient_search_item.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        List<IngredientSearchItem> matches = [];

        if (_query == "") {
          List<String> selected = ingredients.selected.reversed.toList();
          matches = List.filled(
            selected.length,
            IngredientSearchItem(ingredient: IngredientDescription.empty()),
          );

          for (var ingredient in ingredients.ingredients) {
            final index = selected.indexOf(ingredient.name);

            final item = IngredientSearchItem(ingredient: ingredient);
            if (index != -1) matches[index] = item;
          }
        } else {
          matches = ingredients
              .search(_query)
              .map((e) => IngredientSearchItem(query: _query, ingredient: e))
              .toList();
        }

        return EmptyPage(
          appBar: AppBar(
            backgroundColor: toBackgroundGradient(limelightGradient)[0],
            elevation: 4,
            shadowColor: Colors.black,
            leading: IconButton(
              icon: GradientIcon(
                gradient: toTextGradient(limelightGradient),
                icon: Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: TextField(
              autofocus: true,
              controller: _controller,
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration.collapsed(
                hintText: 'Select ingredients to cook with',
                hintStyle: GoogleFonts.workSans(
                  textStyle: TextStyle(color: textColor(), fontSize: 18),
                ),
              ),
              style: GoogleFonts.workSans(
                textStyle: TextStyle(color: textColor()),
              ),
              onChanged: (query) => setState(() => _query = query),
              onEditingComplete: _query == ''
                  ? null
                  : () {
                      if (matches.isNotEmpty) {
                        ingredients.select(matches[0].ingredient.name);
                        setState(() => _query = '');
                        _controller.clear();
                      }
                    },
              onSubmitted:
                  _query == '' ? (_) => Navigator.of(context).pop() : null,
            ),
            actions: _query != ''
                ? [
                    IconButton(
                      icon: GradientIcon(
                        gradient: toTextGradient(limelightGradient),
                        icon: Icons.clear,
                      ),
                      onPressed: () {
                        setState(() => _query = '');
                        _controller.clear();
                      },
                    ),
                  ]
                : [],
          ),
          child: ListView(children: matches),
        );
      },
    );
  }
}
