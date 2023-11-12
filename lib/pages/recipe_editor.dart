import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/provider/recipe_model.dart';
import 'package:limelight/main.dart';
import 'package:limelight/pages/recipes_page.dart';
import 'package:limelight/widgets/appbar_search_bar.dart';
import 'package:limelight/widgets/custom_text.dart';

import 'package:limelight/widgets/gradient_appbar.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/widgets/gradient_icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class RecipeEditor extends StatelessWidget {
  final int recipeId;

  const RecipeEditor({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModel>(
      builder: (context, recipes, child) {
        List<Widget> items = [];
        for (var i = 0; i < recipes.recipe(recipeId).ingredients.length; i++) {
          final ingredient = recipes.recipe(recipeId).ingredients[i];

          items.add(Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 22, 15),
                child: GradientIcon(icon: Icons.panorama_fish_eye, size: 22),
              ),
              Expanded(
                child: TextField(
                  onSubmitted: (text) {},
                  controller: TextEditingController(text: ingredient.name),
                  style: GoogleFonts.openSans(color: textColor()),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextField(
                    textAlign: TextAlign.right,
                    onSubmitted: (text) {},
                    controller: TextEditingController(
                      text: ingredient.quantity,
                    ),
                    style: GoogleFonts.openSans(
                      color: textColor().withOpacity(0.6),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ));
        }

        return EmptyPage(
          appBarText: recipes.name(recipeId),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
            child: ListView(
              children: items,
            ),
          ),
        );
      },
    );
  }
}
