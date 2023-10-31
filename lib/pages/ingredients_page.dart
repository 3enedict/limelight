import 'package:flutter/material.dart';
import 'package:limelight/pages/add_to_shopping_list_page.dart';

import 'package:unicons/unicons.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/gradient_circle.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/custom_text.dart';
import 'package:limelight/pages/search_page.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/main.dart';

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
          onPressed: () => goto(
            context,
            SearchPage(
              searchHint: 'Select ingredients to cook with',
              getSelected: (newModel) => newModel.selected,
              selectIngredient: (name) => model.select(name),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30, 12, 18, 12),
            child: Row(
              children: [
                CustomText(
                  text: "Search...",
                  style: FontStyle.italic,
                  size: 24,
                ),
                Expanded(child: SizedBox()),
                SearchBarIcons(),
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
    const size = 30.0;

    return Row(
      children: [
        GradientIcon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const IngredientEditorPage(),
            ),
          ),
          size: size,
          icon: UniconsLine.plus,
        ),
        GradientIcon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddToShoppingListPage(),
            ),
          ),
          size: size,
          icon: UniconsLine.notes,
        ),
      ],
    );
  }
}
