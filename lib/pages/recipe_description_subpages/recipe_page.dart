import 'package:flutter/material.dart';

import 'package:limelight/main.dart';
import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/items/compact_item.dart';

class RecipeSubPage extends StatelessWidget {
  final int recipeId;

  const RecipeSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    List<CompactItem> steps = [];

    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Recipe",
              titleBackground: const AssetImage('assets/Recipe.jpg'),
              gradient: fishGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return steps[index];
                  },
                  childCount: steps.length,
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
