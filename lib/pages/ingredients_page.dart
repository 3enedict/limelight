import 'package:flutter/material.dart';

import 'package:limelight/pages/add_ingredient_page.dart';
import 'package:limelight/pages/search_page.dart';
import 'package:limelight/widgets/gradient/button.dart';
import 'package:limelight/widgets/gradient/circle.dart';
import 'package:limelight/widgets/gradient/icon.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';

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
                  MaterialPageRoute(builder: (context) => const SearchPage()),
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
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddIngredientPage(),
                        ),
                      ),
                      icon: const GradientIcon(
                        size: 30,
                        icon: Icons.add,
                      ),
                    ),
                    const SizedBox(width: 8),
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
                  icon: Icons.expand_less,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
