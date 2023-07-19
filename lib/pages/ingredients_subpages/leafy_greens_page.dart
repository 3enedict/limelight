import 'package:flutter/material.dart';

import 'package:limelight/widgets/custom_sliver_list.dart';
import 'package:limelight/data/ingredients.dart';
import 'package:limelight/gradients.dart';

class LeafyGreensPage extends StatelessWidget {
  const LeafyGreensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSliverList(
      title: 'Leafy greens',
      titleBackground: const AssetImage('assets/Leafy Greeens.jpg'),
      gradient: leafyGreensGradient,
      items: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return leafyGreens[index].toButtonItem();
          },
          childCount: leafyGreens.length,
        ),
      ),
    );
  }
}
