import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/gradients.dart';

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemList(
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
      gradient: meatGradient,
      items: Consumer<IngredientModel>(
        builder: (context, ingredients, child) {
          final meat = ingredients.meat;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return meat[index].toButtonItem();
              },
              childCount: meat.length,
            ),
          );
        },
      ),
    );
  }
}
