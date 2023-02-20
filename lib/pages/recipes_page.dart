import 'package:flutter/material.dart';

import 'package:limelight/widgets/page_layout.dart';
import 'package:limelight/widgets/ingredient.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  final _gradient = const [
    Color(0xFFF2C94C),
    Color(0xFFF2994A),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF384364),
            Color(0xFF292f4d),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white24,
          onPressed: () {},
          child: const Icon(Icons.calendar_month_rounded),
        ),
        body: ShaderMask(
          shaderCallback: (bound) {
            return const LinearGradient(
                end: FractionalOffset.topCenter,
                begin: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFF292f4d),
                  Color(0x00292f4d),
                ],
                stops: [
                  0.0,
                  0.3,
                ]).createShader(bound);
          },
          blendMode: BlendMode.srcOver,
          child: DefaultPageLayout(
            title: 'Recipes',
            titleBackground: const AssetImage('assets/Recipes.jpg'),
            padding: 125,
            items: SliverList(
              delegate: SliverChildListDelegate(
                [
                  IngredientLayout(
                    name: 'Lettuce',
                    season: 'Spring and fall',
                    price: '\$1.00 per head',
                    cheapness: 'Really cheap',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Kale',
                    season: 'Fall and winter',
                    price: '\$2.00 per lb',
                    cheapness: 'Cheap',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Arugula',
                    season: 'Late spring and early fall',
                    price: '\$10.00 per lb',
                    cheapness: 'Expensive',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Arugula',
                    season: 'Late spring and early fall',
                    price: '\$10.00 per lb',
                    cheapness: 'Expensive',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Arugula',
                    season: 'Late spring and early fall',
                    price: '\$10.00 per lb',
                    cheapness: 'Expensive',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Arugula',
                    season: 'Late spring and early fall',
                    price: '\$10.00 per lb',
                    cheapness: 'Expensive',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                  IngredientLayout(
                    name: 'Arugula',
                    season: 'Late spring and early fall',
                    price: '\$10.00 per lb',
                    cheapness: 'Expensive',
                    accentGradient: _gradient,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
