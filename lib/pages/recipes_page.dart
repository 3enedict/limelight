import 'package:flutter/material.dart';

import 'package:limelight/widgets/gradient_button.dart';
import 'package:limelight/widgets/page.dart';
import 'package:limelight/widgets/item_list.dart';
import 'package:limelight/widgets/items/button_item.dart';
import 'package:limelight/gradients.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPage(
      gradient: limelightGradient,
      fab: GradientButton(
        diameter: 56,
        gradient: toSurfaceGradient(limelightGradient),
        onPressed: () {},
        padding: const EdgeInsets.all(0),
        child: const Center(
          child: Icon(
            Icons.calendar_month_rounded,
            color: Colors.white70,
          ),
        ),
      ),
      child: ItemList(
        title: 'Recipes',
        titleBackground: const AssetImage('assets/Recipes.jpg'),
        padding: 80,
        gradient: limelightGradient,
        keyValue: 1,
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
    );
  }
}
