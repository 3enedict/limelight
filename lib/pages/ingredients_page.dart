import 'package:flutter/material.dart';
import 'package:limelight/data/provider/ingredient_model.dart';

import 'package:limelight/pages/add_ingredient_page.dart';
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
            Center(
              child: GradientButton(
                gradient: toSurfaceGradient(limelightGradient),
                width: MediaQuery.of(context).size.width - 50 * 2,
                height: 66,
                borderRadius: 66 / 2,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(
                      shoppingList: false,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Text(
                      "Search...",
                      style: TextStyle(
                        color: textColor(),
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GradientIcon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddIngredientPage(),
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
                      size: 27,
                      icon: UniconsLine.shopping_basket,
                    ),
                    const SizedBox(width: 12),
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
