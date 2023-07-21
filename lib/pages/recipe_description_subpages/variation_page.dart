import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';

class VariationSubPage extends StatelessWidget {
  final int recipeId;

  const VariationSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    var variationGroup = recipes[recipeId].variationGroups;

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Variations",
              titleBackground: const AssetImage('assets/Variation.jpg'),
              gradient: limelightGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: variationGroup[index].toVariationPicker((_) {}),
                      ),
                    );
                  },
                  childCount: variationGroup.length,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: GradientBackButton(),
          ),
        ],
      ),
    );
  }
}
