import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/data/ingredients.dart';
import 'package:limelight/gradients.dart';

class VegetablesPage extends StatelessWidget {
  const VegetablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: 'Vegetables',
      titleBackground: const AssetImage('assets/Vegetables.webp'),
      backgroundGradient: toBackgroundGradient(vegetablesGradient),
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
