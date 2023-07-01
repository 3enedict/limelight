import 'package:flutter/material.dart';

import 'package:limelight/widgets/page.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/ingredients.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
      backgroundGradient: toBackgroundGradient(fishGradient),
      items: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return fish[index].toButtonItem();
          },
          childCount: fish.length,
        ),
      ),
    );
  }
}
