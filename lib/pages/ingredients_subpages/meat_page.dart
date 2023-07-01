import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/ingredients.dart';
import 'package:limelight/gradients.dart';

class MeatsPage extends StatelessWidget {
  const MeatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: 'Meat & Eggs',
      titleBackground: const AssetImage('assets/Meat.jpg'),
      backgroundGradient: toBackgroundGradient(meatGradient),
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
