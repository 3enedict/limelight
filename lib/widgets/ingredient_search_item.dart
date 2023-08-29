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
  final String query;
  final IngredientDescription ingredient;
  final void Function(String) selectIngredient;
  final List<String> Function(IngredientModel) getSelected;

  const IngredientSearchItem({
    super.key,
    this.query = '',
    required this.ingredient,
    required this.selectIngredient,
    required this.getSelected,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IngredientModel>(context, listen: false);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => model.remove(ingredient.name),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: GradientButton(
          gradient: toSurfaceGradient(limelightGradient),
          padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
          borderRadius: 15,
          onPressed: () => selectIngredient(ingredient.name),
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
              LeadingCircle(getSelected: getSelected, name: ingredient.name),
              ItemTitle(
                query: query,
                name: ingredient.name,
                season: ingredient.season,
              ),
              const Expanded(child: SizedBox()),
              ItemInfo(price: ingredient.price, unit: ingredient.unit),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Utils

class LeadingCircle extends StatelessWidget {
  final List<String> Function(IngredientModel) getSelected;
  final String name;

  const LeadingCircle({
    super.key,
    required this.getSelected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer<IngredientModel>(
        builder: (context, ingredients, child) {
          final isSelected = getSelected(ingredients).contains(name);

          return GradientIcon(
            gradient: isSelected
                ? limelightGradient
                : toBackgroundGradient(limelightGradient),
            size: 30,
            icon: Icons.panorama_fish_eye, // (aka circle)
          );
        },
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  final String query;
  final String name;
  final String season;

  const ItemTitle({
    super.key,
    required this.query,
    required this.name,
    required this.season,
  });

  @override
  Widget build(BuildContext context) {
    final runes = name.runes;
    List<TextSpan> styledName = List.generate(
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: styledName,
            style: GoogleFonts.workSans(
              color: textColor(),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          season,
          style: GoogleFonts.workSans(
            color: textColor().withOpacity(0.6),
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  final String price;
  final String unit;

  const ItemInfo({
    super.key,
    required this.price,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "\$$price",
          style: GoogleFonts.workSans(
            color: textColor().withOpacity(0.8),
            fontStyle: FontStyle.italic,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          unit,
          style: GoogleFonts.workSans(
            color: textColor().withOpacity(0.6),
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}