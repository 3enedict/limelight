import 'package:flutter/material.dart';

import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemList(
      title: 'Vegetables',
      titleBackground: const AssetImage('assets/Vegetables.webp'),
      gradient: vegetablesGradient,
      items: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return vegetables[index].toButtonItem();
          },
          childCount: vegetables.length,
        ),
      ),
    );
  }
}
