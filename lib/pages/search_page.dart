import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/widgets/gradient/container.dart';

import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/ingredient_search_item.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

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
  final _controller = TextEditingController();
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);
    final matches = generateItems(model);

    return EmptyPage(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: GradientContainer(
          gradient: toSurfaceGradient(limelightGradient),
          child: SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 6,
                  ),
                  child: GradientIcon(
                    gradient: toTextGradient(limelightGradient),
                    onPressed: () => Navigator.of(context).pop(),
                    size: 26,
                    icon: Icons.chevron_left,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GradientContainer(
                      gradient: toLighterSurfaceGradient(limelightGradient),
                      borderRadius: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 13, 0),
                              child: GradientIcon(
                                gradient: toTextGradient(limelightGradient)
                                    .map((e) => e.withOpacity(0.6))
                                    .toList(),
                                size: 19,
                                icon: FeatherIcons.search,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                controller: _controller,
                                keyboardAppearance: Brightness.dark,
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.searchHint,
                                  hintStyle: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                      color: textColor().withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.workSans(
                                  textStyle: TextStyle(color: textColor()),
                                ),
                                onChanged: (query) =>
                                    setState(() => _query = query),
                                onEditingComplete: _query == ''
                                    ? null
                                    : () {
                                        if (matches.isNotEmpty) {
                                          widget.selectIngredient(
                                              matches[0].ingredient.name);
                                          clear();
                                        }
                                      },
                                onSubmitted: _query == ''
                                    ? (_) => Navigator.of(context).pop()
                                    : null,
                              ),
                            ),
                            _query != ''
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GradientIcon(
                                      gradient:
                                          toTextGradient(limelightGradient)
                                              .map((e) => e.withOpacity(0.6))
                                              .toList(),
                                      onPressed: () => clear(),
                                      padding: 0,
                                      size: 19,
                                      icon: FeatherIcons.x,
                                    ),
                                  )
                                : const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 6,
                  ),
                  child: GradientIcon(
                    gradient: toTextGradient(limelightGradient),
                    // Idea: Automatically search ingredient after having added it
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const IngredientEditorPage(),
                      ),
                    ),
                    size: 26,
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: ListView(children: matches),
    );
  }

  List<IngredientSearchItem> generateItems(IngredientModel model) {
    List<IngredientSearchItem> matches = [];

    List<IngredientDescription> ingredients = [];
    if (_query == "") {
      List<String> selected = widget.getSelected(model).reversed.toList();
      ingredients = List.filled(selected.length, IngredientDescription.empty());

      for (var ingredient in model.ingredients) {
        final index = selected.indexOf(ingredient.name);
        if (index != -1) ingredients[index] = ingredient;
      }
    } else {
      ingredients = model.search(_query);
    }

    for (var ingredient in ingredients) {
      matches.add(IngredientSearchItem(
        query: _query,
        ingredient: ingredient,
        getSelected: widget.getSelected,
        selectIngredient: widget.selectIngredient,
      ));
    }

    return matches;
  }

  void clear() {
    setState(() => _query = '');
    _controller.clear();
  }
}

/*
Widget build(BuildContext context) {
  final model = Provider.of<IngredientModel>(context, listen: false);
  final matches = generateItems(model);

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
          hintText: widget.searchHint,
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
                  widget.selectIngredient(matches[0].ingredient.name);
                  clear();
                }
              },
        onSubmitted: _query == '' ? (_) => Navigator.of(context).pop() : null,
      ),
      actions: _query != ''
          ? [
              IconButton(
                icon: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.clear,
                ),
                onPressed: () => clear(),
              ),
            ]
          : [],
    ),
    child: ListView(children: matches),
  );
}
*/
