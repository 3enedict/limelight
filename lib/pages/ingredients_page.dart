import 'package:flutter/material.dart';

import 'package:limelight/pages/search_page.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Stack(
        children: [
          Center(
            child: GradientButton(
              gradient: toSurfaceGradient(limelightGradient),
              width: MediaQuery.of(context).size.width - 50 * 2,
              height: 66,
              borderRadius: 66 / 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Search...",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: textColor(),
                    fontSize: 18,
                  ),
                ),
              ),
              onPressed: () => showIngredientSearch(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GradientIcon(
                gradient: toTextGradient(limelightGradient),
                icon: Icons.expand_less,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
