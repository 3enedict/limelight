import 'package:flutter/material.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/pages/search_page.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/circle.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Circles(
        child: Stack(
          children: [
            const SearchBar(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: GradientIcon(
                  gradient: toTextGradient(limelightGradient),
                  icon: Icons.expand_more,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: GradientButton(
          gradient: toSurfaceGradient(limelightGradient),
          borderRadius: 100,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(
                searchHint: 'Select ingredients to cook with',
                getSelected: (newModel) => newModel.selected,
                selectIngredient: (name) => model.select(name),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 18, 12),
            child: Row(
              children: [
                Text(
                  "Search...",
                  style: TextStyle(
                    color: textColor(),
                    fontStyle: FontStyle.italic,
                    fontSize: 24,
                  ),
                ),
                const Expanded(child: SizedBox()),
                const SearchBarIcons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBarIcons extends StatelessWidget {
  const SearchBarIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);

    return Row(
      children: [
        GradientIcon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const IngredientEditorPage(),
            ),
          ),
          size: 30,
          icon: UniconsLine.plus,
        ),
        GradientIcon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(
                searchHint: 'Add to shopping list',
                getSelected: (newModel) => newModel.shoppingList,
                selectIngredient: (name) => model.addToShoppingList(name),
              ),
            ),
          ),
          size: 30,
          icon: UniconsLine.notes,
        ),
      ],
    );
  }
}
