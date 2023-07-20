import 'package:flutter/material.dart';

import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/data/ingredient.dart';
import 'package:limelight/gradients.dart';

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemList(
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
      gradient: meatGradient,
      items: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return meats[index].toButtonItem();
          },
          childCount: meats.length,
        ),
      ),
    );
  }
}
