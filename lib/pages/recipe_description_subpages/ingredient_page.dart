import 'package:flutter/material.dart';

import 'package:limelight/gradients.dart';
import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/items/button_item.dart';

class IngredientSubPage extends StatelessWidget {
  final int recipeId;

  const IngredientSubPage({
    super.key,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      gradient: limelightGradient,
      child: Column(
        children: [
          Expanded(
            child: ItemList(
              title: "Ingredients",
              titleBackground: const AssetImage('assets/Ingredient.jpg'),
              gradient: limelightGradient,
              items: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ButtonItem(
                      title: "",
                      subTitle: "",
                      info: "",
                      subInfo: "",
                      accentGradient: limelightGradient,
                      backgroundGradient: toSurfaceGradient(limelightGradient),
                    );
                  },
                  childCount: 2,
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
