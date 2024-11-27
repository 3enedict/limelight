import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/utils/gradient_container.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/ingredient_search_item.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/utils/gradient_appbar.dart';
import 'package:limelight/utils/gradient_icon.dart';
import 'package:limelight/utils/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/languages.dart';

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
  final _focusNode = FocusNode();

  bool _new = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final matches =
            _query == '' ? ingredients.selected : ingredients.search(_query);

        final items = matches
            .map((e) => IngredientSearchItem(
                  key: Key("Search item : ${e.name}"),
                  query: _query,
                  ingredient: e,
                  editIngredient: (name) => ingredients.edit(e.name, name),
                  removeIngredient: () => ingredients.remove(e.name),
                  node: _focusNode,
                  selected: ingredients.namesOfSelected.contains(e.name),
                  selectIngredient: (ing) {
                    setState(() => _query = '');
                    _controller.clear();

                    ingredients.select(ing);
                  },
                ))
            .toList();

        return EmptyPage(
          resizeToAvoidBottomInset: true,
          appBar: GradientAppBar(
            child: Row(
              children: [
                GradientIcon(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  gradient: toTextGradient(limelightGradient),
                  onPressed: () {
                    setState(() => _new = true);
                    _focusNode.unfocus();
                  },
                  size: 22,
                  icon: Icons.add,
                ),
                Expanded(
                  child: AppbarSearchBar(
                    controller: _controller,
                    node: _focusNode,
                    searchHint: words['selectIngredients']![0],
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
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  gradient: toTextGradient(limelightGradient),
                  onPressed: () {
                    widget.pageController.jumpToPage(recipePage);
                    Navigator.of(context).pop();
                  },
                  size: 22,
                  icon: Icons.done,
                ),
              ],
            ),
          ),
          child: ListView(
            children: !_new
                ? items
                : [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                      child: GradientContainer(
                        gradient: toSurfaceGradient(limelightGradient),
                        borderRadius: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const GradientIcon(
                              gradient: limelightGradient,
                              padding: EdgeInsets.all(16),
                              size: 22,
                              icon: Icons.panorama_fish_eye,
                            ),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                onSubmitted: (text) {
                                  ingredients.add(
                                    IngredientDescription(name: text),
                                  );

                                  ingredients.select(text);
                                  setState(() => _new = false);
                                  _focusNode.requestFocus();
                                },
                                style: GoogleFonts.openSans(
                                  color: textColor(),
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ),
                    ...items
                  ],
          ),
        );
      },
    );
  }
}
