import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limelight/data/json/ingredient_description.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:provider/provider.dart';

class IngredientSearchItem extends StatelessWidget {
  final IngredientDescription ingredient;

  const IngredientSearchItem({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = Provider.of<IngredientModel>(context)
        .selected
        .contains(ingredient.name);

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: GradientButton(
        gradient: toSurfaceGradient(limelightGradient),
        onPressed: () {
          Provider.of<IngredientModel>(context, listen: false).select(
            ingredient.name,
          );
        },
        borderRadius: 15,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 3),
              GradientIcon(
                gradient: isSelected
                    ? limelightGradient
                    : toBackgroundGradient(limelightGradient),
                icon: Icons.lens,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredient.name,
                    style: GoogleFonts.workSans(
                      color: textColor(),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
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
                    ingredient.price,
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
            ],
          ),
        ),
      ),
    );
  }
}
