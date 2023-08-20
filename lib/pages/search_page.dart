import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _query = "";
  String _lastEdit = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        List<IngredientSearchItem> matches = _query == ""
            ? []
            : ingredients
                .search(_query)
                .map((e) => IngredientSearchItem(
                      query: _query,
                      ingredient: e,
                    ))
                .toList();

        bool exit = true;
        if (matches.isNotEmpty) {
          exit = _lastEdit == matches[0].ingredient.name;
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
              keyboardAppearance: Brightness.dark,
              decoration: InputDecoration.collapsed(
                hintText: 'Search...',
                hintStyle: GoogleFonts.workSans(
                  textStyle: TextStyle(color: textColor(), fontSize: 18),
                ),
              ),
              style: GoogleFonts.workSans(
                  textStyle: TextStyle(color: textColor())),
              onChanged: (query) => setState(() => _query = query),
              onEditingComplete: exit
                  ? null
                  : () {
                      setState(() => _lastEdit = matches[0].ingredient.name);
                      ingredients.select(matches[0].ingredient.name);
                    },
              onSubmitted: exit ? (_) => Navigator.of(context).pop() : null,
            ),
            actions: _query != ""
                ? [
                    IconButton(
                      icon: GradientIcon(
                        gradient: toTextGradient(limelightGradient),
                        icon: Icons.clear,
                      ),
                      onPressed: () => setState(() => _query = ''),
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
