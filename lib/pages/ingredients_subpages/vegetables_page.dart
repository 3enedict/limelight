import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:limelight/data/provider/ingredient_model.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/gradients.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemList(
      title: 'Vegetables',
      titleBackground: const AssetImage('assets/Vegetables.webp'),
      gradient: vegetablesGradient,
      items: Consumer<IngredientModel>(
        builder: (context, ingredients, child) {
          final vegetables = ingredients.vegetables;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return vegetables[index].toButtonItem();
              },
              childCount: vegetables.length,
            ),
          );
        },
      ),
    );
  }
}
