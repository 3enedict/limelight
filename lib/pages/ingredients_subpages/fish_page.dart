import 'package:flutter/material.dart';

import 'package:limelight/widgets/custom_sliver_list.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/data/ingredients.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSliverList(
      title: 'Fish & Dairy',
      titleBackground: const AssetImage('assets/Fish.jpg'),
      gradient: fishGradient,
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
