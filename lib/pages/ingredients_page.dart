import 'package:flutter/material.dart';

import 'package:limelight/pages/ingredient_editor_page.dart';
import 'package:limelight/pages/search_page.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/circle.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:unicons/unicons.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      child: Circles(
        child: Stack(
          children: [
            Center(
              child: GradientButton(
                gradient: toSurfaceGradient(limelightGradient),
                width: MediaQuery.of(context).size.width - 50 * 2,
                height: 74,
                borderRadius: 74 / 2,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(
                      shoppingList: false,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Text(
                      "Search...",
                      style: TextStyle(
                        color: textColor(),
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GradientIcon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const IngredientEditorPage(),
                        ),
                      ),
                      size: 30,
                      icon: Icons.add,
                    ),
                    GradientIcon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            shoppingList: true,
                          ),
                        ),
                      ),
                      size: 28,
                      icon: UniconsLine.notes,
                    ),
                    const SizedBox(width: 18),
                  ],
                ),
              ),
            ),
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
