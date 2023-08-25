import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';

class IngredientSearchItem extends StatelessWidget {
  final IngredientDescription ingredient;
  final String query;
  final bool shoppingList;

  const IngredientSearchItem({
    super.key,
    required this.ingredient,
    this.query = '',
    this.shoppingList = false,
  });

  @override
  Widget build(BuildContext context) {
    final runes = ingredient.name.runes;
    List<TextSpan> name = List.generate(
      runes.length,
      (int index) {
        String character = String.fromCharCode(runes.elementAtOrNull(index)!);
        bool match = query.toLowerCase().contains(character.toLowerCase());

        return TextSpan(
          text: character,
          style: TextStyle(
            color: match ? modifyColor(textColor(), 0.95, 0.1) : textColor(),
            fontWeight: match ? FontWeight.w900 : FontWeight.w100,
          ),
        );
      },
    );

    return Consumer<IngredientModel>(
      builder: (context, ingredients, child) {
        final isSelected = shoppingList
            ? ingredients.shoppingList.contains(ingredient.name)
            : ingredients.selected.contains(ingredient.name);

        return Dismissible(
          key: UniqueKey(),
          onDismissed: (_) => ingredients.remove(ingredient.name),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: GradientButton(
              gradient: toSurfaceGradient(limelightGradient),
              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
              borderRadius: 15,
              onPressed: () => shoppingList
                  ? ingredients.addToShoppingList(ingredient.name)
                  : ingredients.select(ingredient.name),
              onLongPress: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => IngredientEditorPage(
                    name: ingredient.name,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GradientIcon(
                      gradient: isSelected
                          ? limelightGradient
                          : toBackgroundGradient(limelightGradient),
                      size: 30,
                      icon: Icons.panorama_fish_eye,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: name,
                          style: GoogleFonts.workSans(
                            color: textColor(),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ingredient.season,
                        style: GoogleFonts.workSans(
                          color: textColor().withOpacity(0.6),
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${ingredient.price}",
                        style: GoogleFonts.workSans(
                          color: textColor().withOpacity(0.8),
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        ingredient.unit,
                        style: GoogleFonts.workSans(
                          color: textColor().withOpacity(0.6),
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
